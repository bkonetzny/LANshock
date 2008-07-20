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
<h4>#request.content.team_details_headline# <cfif qTournament.teamsize EQ 1>#application.lanshock.oHelper.GetUsernameByID(stTeam.leaderid)#<cfelse>#stTeam.name#</cfif></h4>

<cfif (session.userid EQ stTeam.leaderid)
	OR qTournament.teamsize NEQ 1 AND session.oUser.isLoggedIn()>
	<ul>
		<cfif session.userid EQ stTeam.leaderid>
			<cfif len(qTournament.export_league) OR qTournament.teamsize NEQ 1>
				<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_edit&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#">#request.content.edit_this_team#</a>
					<br/>#request.content.edit_this_team_hint#</li>
			</cfif>
			<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_delete&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#">#request.content.delete_this_team#</a>
				<br/>#request.content.delete_this_team_hint#</li>
		</cfif>
		<cfif qTournament.teamsize NEQ 1 AND session.oUser.isLoggedIn()>
			<cfif NOT qTeamCurrentUser.recordcount>
				<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_join&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#"><cfif ListFind(stTeam.autoacceptids, session.userid)>#request.content.join_this_team_autoaccept#<cfelse>#request.content.join_this_team#</cfif></a></li>
			<cfelseif qTeamCurrentUser.id EQ stTeam.id>
				<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_leave&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#">#request.content.leave_this_team#</a>
					<br/>#request.content.leave_this_team_hint#</li>
			</cfif>
		</cfif>
	</ul>
</cfif>

<table class="vlist">
	<tr>
		<th>Players (Ready)</th>
		<td>#qPlayersReady.recordcount#</td>
	</tr>
	<tr>
		<th>Players (Waiting)</th>
		<td>#qPlayersWaiting.recordcount#</td>
	</tr>
	<tr>
		<th>Teamsize</th>
		<td>#qTournament.teamsize#</td>
	</tr>
	<tr>
		<th>Substitutes</th>
		<td>#qTournament.teamsubstitute#</td>
	</tr>
</table>

<h4>Players</h4>

<table>
	<cfif qPlayersAwaitingAuthorisation.recordcount>
		<tr>
			<th colspan="4">#request.content.team_player_awaiting_authorisation# <cfif qPlayersReady.recordcount GTE qTournament.teamsize AND qPlayersWaiting.recordcount GTE qTournament.teamsubstitute>(#request.content.team_is_complete#)</cfif></th>
		</tr>
		<cfloop query="qPlayersAwaitingAuthorisation">
			<tr>
				<td class="empty" align="center"<cfif session.userid EQ stTeam.leaderid> rowspan="2"</cfif>>#application.lanshock.oHelper.UserShowAvatar(userid)#</td>
				<td><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#userid#')#">#application.lanshock.oHelper.GetUsernameByID(userid)#</a></td>
				<cfset qUserdata = application.lanshock.oHelper.GetUserdataByID(userid)>
				<td><cfif session.userloggedin AND session.userid NEQ userid><a href="javascript:LANshock.userSendMessage(#userid#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a> </cfif><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#userid#')#">#qUserdata.firstname# #qUserdata.lastname#</a></td>
				<td><cftry>
						<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.event.model.seatplan')#" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#userid#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#application.lanshock.oHelper.buildUrl('#stSeat.linkurl#')#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry>
				</td>
			</tr>
			<cfif session.userid EQ stTeam.leaderid>
				<tr>
					<td colspan="4">
						<cfif qPlayersReady.recordcount LT qTournament.teamsize>
							<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#&status=ready')#">#request.content.team_player_add_ready#</a><br>
						</cfif>
						<cfif qPlayersWaiting.recordcount LT qTournament.teamsubstitute>
							<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#&status=waiting')#">#request.content.team_player_add_waiting#</a><br>
						</cfif>
						<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_delete&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#')#">#request.content.team_player_remove#</a>
					</td>
				</tr>
			</cfif>
		</cfloop>
		<tr>
			<td class="empty" colspan="4">&nbsp;</td>
		</tr>
	</cfif>
</table>

<h4>#request.content.teamleader#</h4>
<cfset qUserdata = application.lanshock.oHelper.GetUserdataByID(stTeam.leaderid)>
<div style="float: left; margin-right: 20px; width: 80px; height: 80px;">
	#application.lanshock.oHelper.UserShowAvatar(qUserdata.id)#
</div>
<div style="float: left;">
	<p>#qUserdata.name#<br/>
		#qUserdata.firstname# #qUserdata.lastname#<br/>
		<br/>
		<a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qUserdata.id#')#">Profil</a>
		<cfif session.oUser.isLoggedIn() AND session.oUser.getDataValue('userid') NEQ qUserdata.id> <a href="javascript:LANshock.userSendMessage(#qUserdata.id#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a></cfif>
		
		<cftry>
			<br/>
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.event.model.seatplan')#" method="getSeatLinkDataByUserID" returnvariable="stSeat">
				<cfinvokeargument name="userid" value="#stTeam.leaderid#">
			</cfinvoke>
			<cfif NOT StructIsEmpty(stSeat)>
				<a href="#application.lanshock.oHelper.buildUrl('#stSeat.linkurl#')#">#stSeat.description#</a>
			<cfelse>
				#request.content.player_unknown_seat#
			</cfif>
			<cfcatch>#request.content.player_unknown_seat#</cfcatch>
		</cftry>
	</p>
</div>
<div class="clearer"></div>

<cfif qTournament.teamsize NEQ 1>
	<h4>#request.content.teammembers#</h4>
	
	<cfset cnt = 0>
	<cfloop query="qPlayersReady">
		<cfset qUserdata = application.lanshock.oHelper.GetUserdataByID(qPlayersReady.userid)>
		<div style="float: left; margin-right: 20px; width: 80px; height: 80px;">
			#application.lanshock.oHelper.UserShowAvatar(qUserdata.id)#
		</div>
		<div style="float: left;">
			<p>#qUserdata.name#<br/>
				#qUserdata.firstname# #qUserdata.lastname#<br/>
				<br/>
				<a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qUserdata.id#')#">Profil</a>
				<cfif session.oUser.isLoggedIn() AND session.oUser.getDataValue('userid') NEQ qUserdata.id> <a href="javascript:LANshock.userSendMessage(#qUserdata.id#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a></cfif>
				
				<cftry>
					<br/>
					<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.event.model.seatplan')#" method="getSeatLinkDataByUserID" returnvariable="stSeat">
						<cfinvokeargument name="userid" value="#stTeam.leaderid#">
					</cfinvoke>
					<cfif NOT StructIsEmpty(stSeat)>
						<a href="#application.lanshock.oHelper.buildUrl('#stSeat.linkurl#')#">#stSeat.description#</a>
					<cfelse>
						#request.content.player_unknown_seat#
					</cfif>
					<cfcatch>#request.content.player_unknown_seat#</cfcatch>
				</cftry>
			</p>
		</div>
		<div class="clearer"></div>

		<cfif session.oUser.getDataValue('userid') EQ stTeam.leaderid>
			<ul class="options">
				<cfif userid NEQ stTeam.leaderid>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_delete&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#')#">#request.content.team_player_remove#</a></li>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#&status=leader')#">#request.content.team_player_add_leader#</a></li>
				</cfif>
				<cfif qPlayersWaiting.recordcount LT qTournament.teamsubstitute>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#&status=waiting')#">#request.content.team_player_add_waiting#</a></li>
				</cfif>
			</ul>
			
			<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_rearrange_players&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#')#" method="post">
				<cfif qPlayersWaiting.recordcount>
					#request.content.team_player_change_waiting#<br>
					<select name="rearrange_users" style="width: 150px;">
						<cfloop query="qPlayersWaiting"><option value="#userid#">#application.lanshock.oHelper.GetUsernameByID(userid)#</option></cfloop>
					</select>
					<input type="submit" value="#request.content.team_player_change#">
				</cfif>
			</form>
		</cfif>
	</cfloop>
</cfif>
	
	<cfif qTournament.teamsubstitute GT 0>
		<tr>
			<th colspan="4">#request.content.substitute#</th>
		</tr>
		<cfset cnt = 0>
		<cfloop query="qPlayersWaiting">
			<cfset cnt = cnt + 1>
			<tr>
				<td align="center"<cfif session.userid EQ stTeam.leaderid> rowspan="2"</cfif>>#application.lanshock.oHelper.UserShowAvatar(userid)#</td>
				<td>#cnt#. <a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#userid#')#">#application.lanshock.oHelper.GetUsernameByID(userid)#</a></td>
				<cfset qUserdata = application.lanshock.oHelper.GetUserdataByID(userid)>
				<td><cfif session.userloggedin AND session.userid NEQ userid><a href="javascript:LANshock.userSendMessage(#userid#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a> </cfif>#qUserdata.firstname# #qUserdata.lastname#</td>
				<td>
					<cftry>
						<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.event.model.seatplan')#" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#userid#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#application.lanshock.oHelper.buildUrl('#stSeat.linkurl#')#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry>
				</td>
			</tr>
			<cfif session.userid EQ stTeam.leaderid>
				<tr>
					<td colspan="2" valign="top">
						<cfif userid NEQ stTeam.leaderid>
							<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_delete&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#')#">#request.content.team_player_remove#</a><br>
							<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#&status=leader')#">#request.content.team_player_add_leader#</a><br>
						</cfif>
						<cfif qPlayersReady.recordcount LT qTournament.teamsize>
							<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#&status=ready')#">#request.content.team_player_add_ready#</a>
						</cfif>
					</td>
					<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_rearrange_players&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#userid#')#" method="post">
						<td colspan="2" valign="top">
							<cfif qPlayersReady.recordcount>
								#request.content.team_player_change_ready#<br>
								<select name="rearrange_users" style="width: 150px;">
									<cfloop query="qPlayersReady"><option value="#userid#">#application.lanshock.oHelper.GetUsernameByID(userid)#</option></cfloop>
								</select>
								<input type="submit" value="#request.content.team_player_change#">
							<cfelse>&nbsp;
							</cfif>
						</td>
					</form>
				</tr>
			</cfif>
		</cfloop>
		<cfloop condition="cnt LT qTournament.teamsubstitute">
			<cfset cnt = cnt + 1>
			<tr>
				<td class="empty">&nbsp;</td>
				<td>#cnt#. <em>#request.content.empty_slot#</em></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</cfloop>
	</cfif>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">