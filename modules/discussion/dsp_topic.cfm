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
	<h3>#qTopic.title#</h3>
	
	<cfif qTopic.module NEQ myfusebox.thiscircuit>
		<div class="errorBox">
			<a href="#application.lanshock.oHelper.buildUrl('#qTopic.module#.#qTopic.linktosource#')#">#request.content.link_to_original_content_hint#</a>
		</div>
	<cfelse>
		<ul class="options">
			<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.board&id=#ListLast(qTopic.type,'_')#')#">#request.content.back_to_board#</a></li>
		</ul>
		
		<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.board')#" method="post">
			<div class="form">
				<div class="formrow">
					<div class="formrow_label">
						<label for="board_select">#request.content.change_board#</label>
					</div>
					<div class="formrow_input">
						<select name="id" id="board_select" onChange="submit();">
							<cfloop query="qGroups">
								<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getBoards" returnvariable="qBoards">
									<cfinvokeargument name="group_id" value="#id#">
								</cfinvoke>
								<optgroup label="#name#">
									<cfloop query="qBoards">
										<option value="#id#"<cfif id EQ ListLast(qTopic.type,'_')> selected</cfif>>#title#</option>
									</cfloop>
								</optgroup>
							</cfloop>
						</select>
					</div>
				</div>
				<div class="clearer"></div>
			</div>
		</form>
	</cfif>

	#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">