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
	<h3>#qBoard.title#</h3>
	
	<cfif session.userloggedin>
		<ul class="options">
			<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.post&board_id=#qBoard.id#')#">#request.content.new_topic#</a></li>
		</ul>
	</cfif>
	
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.board')#" method="post">
		<div class="form">
			<div class="formrow">
				<div class="formrow_label">
					<label for="board_select">#request.content.change_board#</label>
				</div>
				<div class="formrow_input">
					<select name="id" id="board_select" onChange="submit();">
						<cfloop query="qGroups">
							<cfif NOT len(qGroups.permission)
								OR (len(qGroups.permission) AND session.oUser.checkPermissions(ListLast(qGroups.permission,'.'),ListFirst(qGroups.permission,'.')))>
								<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getBoards" returnvariable="qBoards">
									<cfinvokeargument name="group_id" value="#id#">
								</cfinvoke>
								<optgroup label="#name#">
									<cfloop query="qBoards">
										<option value="#qBoards.id#"<cfif qBoards.id EQ attributes.id> selected="selected"</cfif>>#qBoards.title#</option>
									</cfloop>
								</optgroup>
							</cfif>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="clearer"></div>
		</div>
	</form>

	<cfif len(qBoard.subtitle)>
		<h4>#qBoard.subtitle#</h4>
	<cfelse>
		<h4>#qBoard.title#</h4>
	</cfif>

	<table>
		<thead>
			<tr>
				<th>#request.content.topic#</th>
				<th>#request.content.post_count#</th>
				<th>#request.content.last_post#</th>
			</tr>
		</thead>
		<tbody>
		<cfloop query="qTopics">
			<tr>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.topic&id=#qTopics.id#')#">#qTopics.title#</a></td>
				<td align="center">#qTopics.postcount#</td>
				<td>#session.oUser.DateTimeFormat(qTopics.dt_lastpost)#
					<br/><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qTopics.user_id_lastpost#')#">#application.lanshock.oHelper.GetUsernameByID(qTopics.user_id_lastpost)#</a></td>
			</tr>
		</cfloop>
		</tbody>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">