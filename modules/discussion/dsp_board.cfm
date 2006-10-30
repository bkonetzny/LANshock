<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
	<div class="headline">#qBoard.title#</div>
	
	<table width="100%">
		<tr>
			<cfif request.session.userloggedin>
				<td><a href="#myself##myfusebox.thiscircuit#.post&board_id=#qBoard.id#&#request.session.urltoken#" class="link_extended">#request.content.new_topic#</a></td>
			</cfif>
			<form action="#myself##myfusebox.thiscircuit#.board&#request.session.urltoken#" method="post">
			<td align="right">
				#request.content.change_board#
				<select name="id" onChange="submit();">
					<cfloop query="qGroups">
						<cfinvoke component="discussion" method="getBoards" returnvariable="qBoards">
							<cfinvokeargument name="group_id" value="#id#">
						</cfinvoke>
						<optgroup label="#name#">
							<cfloop query="qBoards">
								<option value="#id#"<cfif id EQ attributes.id> selected</cfif>>#title#</option>
							</cfloop>
						</optgroup>
					</cfloop>
				</select>
			</td>
			</form>
		</tr>
	</table>

	<div class="headline2">#qBoard.subtitle#</div>

	<table class="list">
		<tr>
			<th>#request.content.topic#</th>
			<th>#request.content.created_by#</th>
			<th>#request.content.post_count#</th>
			<th>#request.content.last_post#</th>
		</tr>
		<cfloop query="qTopics">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.topic&id=#id#&#request.session.urltoken#">#title#</a></td>
				<td>#GetUsernameByID(user_id)#</td>
				<td align="center">#postcount#</td>
				<td>
					<cfif len(dt_lastpost)>
						#UDF_DateTimeFormat(dt_lastpost)#
					<cfelse>
						#UDF_DateTimeFormat(dt_created)#
					</cfif></td>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">