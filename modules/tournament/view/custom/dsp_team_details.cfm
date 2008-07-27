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

<cfif session.oUser.getDataValue('userid') EQ stTeam.leaderid>
	<ul class="options">
		<cfif len(qTournament.export_league) OR qTournament.teamsize NEQ 1>
			<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_edit&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#">#request.content.edit_this_team#</a>
				<br/>#request.content.edit_this_team_hint#</li>
		</cfif>
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_delete&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#">#request.content.delete_this_team#</a>
			<br/>#request.content.delete_this_team_hint#</li>
	</ul>
<cfelseif session.oUser.isLoggedIn() AND stStatus.ready LT qTournament.teamsize AND NOT qTeamCurrentUser.recordcount>
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_join&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#"><cfif ListFind(stTeam.autoacceptids, session.userid)>#request.content.join_this_team_autoaccept#<cfelse>#request.content.join_this_team#</cfif></a></li>
	</ul>
</cfif>

<p>
	Maximale Teamgr&ouml;&szlig;e <strong>#qTournament.teamsize#</strong>, aktuelle Teamgr&ouml;&szlig;e <strong>#stStatus.ready#</strong>.
	<cfif stStatus.waiting GT 0>
		<br/>Dieses Team hat #stStatus.waiting# Auswechselspieler
	</cfif>
	<cfif stStatus.awaiting_authorisation>
		<br/><strong>#stStatus.awaiting_authorisation#</strong> Spieler warten auf Annahme.
	</cfif>
</p>

<h4>Players</h4>

<table>
	<tr>
		<th>Name</th>
		<th>Status</th>
		<th>Sitzplatz</th>
		<th>Optionen</th>
	</tr>
	<cfloop query="qPlayers">
		<tr>
			<td><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qPlayers.userid#')#">#qPlayers.name#</a></td>
			<td><cfswitch expression="#qPlayers.status#">
					<cfcase value="ready">
						<cfif qPlayers.userid EQ stTeam.leaderid>
							#request.content.teamleader#
						<cfelse>
							#request.content.teammembers#
						</cfif>
					</cfcase>
					<cfcase value="waiting">
						#request.content.substitute#
					</cfcase>
					<cfcase value="awaiting_authorisation">
						#request.content.team_player_awaiting_authorisation#
					</cfcase>
				</cfswitch></td>
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
				</cftry></td>
			<td>
				<cfif session.oUser.getDataValue('userid') NEQ qPlayers.userid>
					<a href="javascript:LANshock.userSendMessage(#qPlayers.userid#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a>
				</cfif>
				<cfif session.oUser.getDataValue('userid') EQ stTeam.leaderid>
					<cfswitch expression="#qPlayers.status#">
						<cfcase value="ready">
							<cfif qPlayers.userid NEQ stTeam.leaderid>
								<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#qPlayers.userid#&status=leader')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/user.png" alt="#request.content.team_player_add_leader#" title="#request.content.team_player_add_leader#"/></a>
								<cfif stStatus.waiting LT qTournament.teamsubstitute>
									<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#qPlayers.userid#&status=waiting')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/error.png" alt="#request.content.team_player_add_waiting#" title="#request.content.team_player_add_waiting#"/></a>
								</cfif>
							</cfif>
						</cfcase>
						<cfcase value="waiting">
							<cfif stStatus.ready LT qTournament.teamsize>
								<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#qPlayers.userid#&status=ready')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/accept.png" alt="#request.content.team_player_add_ready#" title="#request.content.team_player_add_ready#"/></a>
							</cfif>
						</cfcase>
						<cfcase value="awaiting_authorisation">
							<cfif stStatus.ready LT qTournament.teamsize>
								<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#qPlayers.userid#&status=ready')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/accept.png" alt="#request.content.team_player_add_ready#" title="#request.content.team_player_add_ready#"/></a>
							</cfif>
							<cfif stStatus.waiting LT qTournament.teamsubstitute>
								<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_change_status&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#qPlayers.userid#&status=waiting')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/error.png" alt="#request.content.team_player_add_waiting#" title="#request.content.team_player_add_waiting#"/></a>
							</cfif>
						</cfcase>
					</cfswitch>
					<cfif ListFind('signup,warmup',qTournament.status) AND qPlayers.userid NEQ stTeam.leaderid>
						<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_delete&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#qPlayers.userid#')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/delete.png" alt="#request.content.team_player_remove#" title="#request.content.team_player_remove#"/></a>
					</cfif>
				</cfif>
				<cfif ListFind('signup,warmup',qTournament.status) AND qPlayers.userid NEQ stTeam.leaderid AND session.oUser.getDataValue('userid') EQ qPlayers.userid>
					<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_leave&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#&userid=#qPlayers.userid#')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/delete.png" alt="#request.content.team_player_remove#" title="#request.content.team_player_remove#"/></a>
				</cfif>
			</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">