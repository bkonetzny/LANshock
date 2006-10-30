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
	<div class="headline">#qTopic.title#</div>
	
	<cfif qTopic.module NEQ myfusebox.thiscircuit>
		<div class="errorBox">
			<a href="#myself##qTopic.module#.#qTopic.linktosource#&#request.session.urltoken#">#request.content.link_to_original_content_hint#</a>
		</div>
	<cfelse>
		<table width="100%">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.board&id=#ListLast(qTopic.type,'_')#&#request.session.urltoken#" class="link_extended">#request.content.back_to_board#</a></td>
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
									<option value="#id#"<cfif id EQ ListLast(qTopic.type,'_')> selected</cfif>>#title#</option>
								</cfloop>
							</optgroup>
						</cfloop>
					</select>
				</td>
				</form>
			</tr>
		</table>
	</cfif>

	#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">