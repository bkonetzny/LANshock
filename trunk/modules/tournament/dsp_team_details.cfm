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
<cfif qTournament.teamsize EQ 1>
	<div class="headline2">#request.content.team_details_headline# #GetUsernameByID(stTeam.leaderid)#</div>
<cfelse>
	<div class="headline2">#request.content.team_details_headline# #stTeam.name#</div>
</cfif>
<br><br>

<table align="center" width="80%" cellpadding="5">
	<tr>
		<td align="center">
			<strong>#qPlayersReady.recordcount# (+ #qPlayersWaiting.recordcount#) / #qTournament.teamsize# (+ #qTournament.teamsubstitute#)</strong><br>
		</td>
	</tr>
	<cfif request.session.userid EQ stTeam.leaderid>
	<tr>
		<td>
			<strong>#request.content.teamleader_options#</strong><br>
			<cfif len(qTournament.export_league) OR qTournament.teamsize NEQ 1>
				<a href="#myself##myfusebox.thiscircuit#.team_edit&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.edit_this_team#</a><br>
				#request.content.edit_this_team_hint#<br>&nbsp;<br>
			</cfif>
			<a href="#myself##myfusebox.thiscircuit#.team_delete&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.delete_this_team#</a><br>
			#request.content.delete_this_team_hint#<br>&nbsp;<br>
		</td>
	</tr>
	</cfif>
	<cfif qTournament.teamsize NEQ 1>
		<tr>
			<td>
				<cfif request.session.userloggedin>
					<cfif NOT qTeamCurrentUser.recordcount>
						<a href="#myself##myfusebox.thiscircuit#.team_join&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended"><cfif ListFind(stTeam.autoacceptids, request.session.userid)>#request.content.join_this_team_autoaccept#<cfelse>#request.content.join_this_team#</cfif></a><br>
					<cfelseif qTeamCurrentUser.id EQ stTeam.id>
						<a href="#myself##myfusebox.thiscircuit#.team_leave&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.leave_this_team#</a><br>
						#request.content.leave_this_team_hint#<br>&nbsp;<br>
					</cfif>
				</cfif><br>&nbsp;
			</td>
		</tr>
	</cfif>
</table>

<table class="list">
	<cfif qPlayersAwaitingAuthorisation.recordcount>
		<tr>
			<th colspan="4">#request.content.team_player_awaiting_authorisation# <cfif qPlayersReady.recordcount GTE qTournament.teamsize AND qPlayersWaiting.recordcount GTE qTournament.teamsubstitute>(#request.content.team_is_complete#)</cfif></th>
		</tr>
		<cfloop query="qPlayersAwaitingAuthorisation">
			<tr>
				<td class="empty" align="center"<cfif request.session.userid EQ stTeam.leaderid> rowspan="2"</cfif>>#UserShowAvatar(userid)#</td>
				<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#userid#&#request.session.UrlToken#">#GetUsernameByID(userid)#</a></td>
				<cfset qUserdata = GetUserdataByID(userid)>
				<td><cfif request.session.userloggedin AND request.session.userid NEQ userid><a href="javascript:SendMsg(#userid#)"><img src="#stImageDir.general#/mail.gif" alt="" border="0"></a> </cfif><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#userid#&#request.session.UrlToken#">#qUserdata.firstname# #qUserdata.lastname#</a></td>
				<td><cftry>
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#userid#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry>
				</td>
			</tr>
			<cfif request.session.userid EQ stTeam.leaderid>
				<tr>
					<td colspan="4">
						<cfif qPlayersReady.recordcount LT qTournament.teamsize>
							<a href="#myself##myfusebox.thiscircuit#.team_player_change_status&userid=#userid#&status=ready&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_add_ready#</a><br>
						</cfif>
						<cfif qPlayersWaiting.recordcount LT qTournament.teamsubstitute>
							<a href="#myself##myfusebox.thiscircuit#.team_player_change_status&userid=#userid#&status=waiting&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_add_waiting#</a><br>
						</cfif>
						<a href="#myself##myfusebox.thiscircuit#.team_player_delete&userid=#userid#&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_remove#</a>
					</td>
				</tr>
			</cfif>
		</cfloop>
		<tr>
			<td class="empty" colspan="4">&nbsp;</td>
		</tr>
	</cfif>
	<tr>
		<th colspan="4">#request.content.teamleader#</th>
	</tr>
	<tr>
		<td class="empty" align="center">#UserShowAvatar(stTeam.leaderid)#</td>
		<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stTeam.leaderid#&#request.session.UrlToken#">#GetUsernameByID(stTeam.leaderid)#</a></td>
		<cfset qUserdata = GetUserdataByID(stTeam.leaderid)>
		<td><cfif request.session.userloggedin AND request.session.userid NEQ stTeam.leaderid><a href="javascript:SendMsg(#stTeam.leaderid#)"><img src="#stImageDir.general#/mail.gif" alt="" border="0"></a> </cfif><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stTeam.leaderid#&#request.session.UrlToken#">#qUserdata.firstname# #qUserdata.lastname#</a></td>
		<td><cftry>
				<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
					<cfinvokeargument name="userid" value="#stTeam.leaderid#">
				</cfinvoke>
				<cfif NOT StructIsEmpty(stSeat)>
					<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
				<cfelse>
					#request.content.player_unknown_seat#
				</cfif>
				<cfcatch>#request.content.player_unknown_seat#</cfcatch>
			</cftry></td>
	</tr>
	<cfif qTournament.teamsize NEQ 1>
		<tr>
			<th colspan="4">#request.content.teammembers#</th>
		</tr>
		<cfset cnt = 0>
		<cfloop query="qPlayersReady">
			<cfset cnt = cnt + 1>
			<tr>
				<td class="empty" align="center"<cfif request.session.userid EQ stTeam.leaderid> rowspan="2"</cfif>>#UserShowAvatar(userid)#</td>
				<td>#cnt#. <a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#userid#&#request.session.UrlToken#">#GetUsernameByID(userid)#</a></td>
				<cfset qUserdata = GetUserdataByID(userid)>
				<td><cfif request.session.userloggedin AND request.session.userid NEQ userid><a href="javascript:SendMsg(#userid#)"><img src="#stImageDir.general#/mail.gif" alt="" border="0"></a> </cfif><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#userid#&#request.session.UrlToken#">#qUserdata.firstname# #qUserdata.lastname#</a></td>
				<td><cftry>
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#userid#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry>
				</td>
			</tr>
			<cfif request.session.userid EQ stTeam.leaderid>
				<tr>
					<td class="empty" colspan="2" valign="top">
						<cfif userid NEQ stTeam.leaderid>
							<a href="#myself##myfusebox.thiscircuit#.team_player_delete&userid=#userid#&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_remove#</a><br>
							<a href="#myself##myfusebox.thiscircuit#.team_player_change_status&userid=#userid#&status=leader&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_add_leader#</a><br>
						</cfif>
						<cfif qPlayersWaiting.recordcount LT qTournament.teamsubstitute>
							<a href="#myself##myfusebox.thiscircuit#.team_player_change_status&userid=#userid#&status=waiting&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_add_waiting#</a>
						</cfif>
					</td>
					<form action="#myself##myfusebox.thiscircuit#.team_player_rearrange_players&userid=#userid#&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" method="post">
						<td class="empty" colspan="2" valign="top">
							<cfif qPlayersWaiting.recordcount>
								#request.content.team_player_change_waiting#<br>
								<select name="rearrange_users" style="width: 150px;">
									<cfloop query="qPlayersWaiting"><option value="#userid#">#GetUsernameByID(userid)#</option></cfloop>
								</select>
								<input type="submit" value="#request.content.team_player_change#">
							<cfelse>&nbsp;
							</cfif>
						</td>
					</form>
				</tr>
			</cfif>
		</cfloop>
		<cfloop condition="cnt LT qTournament.teamsize">
			<cfset cnt = cnt + 1>
			<tr>
				<td class="empty">&nbsp;</td>
				<td>#cnt#. <em>#request.content.empty_slot#</em></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
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
				<td align="center"<cfif request.session.userid EQ stTeam.leaderid> rowspan="2"</cfif>>#UserShowAvatar(userid)#</td>
				<td>#cnt#. <a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#userid#&#request.session.UrlToken#">#GetUsernameByID(userid)#</a></td>
				<cfset qUserdata = GetUserdataByID(userid)>
				<td><cfif request.session.userloggedin AND request.session.userid NEQ userid><a href="javascript:SendMsg(#userid#)"><img src="#stImageDir.general#/mail.gif" alt="" border="0"></a> </cfif>#qUserdata.firstname# #qUserdata.lastname#</td>
				<td>
					<cftry>
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#userid#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry>
				</td>
			</tr>
			<cfif request.session.userid EQ stTeam.leaderid>
				<tr>
					<td colspan="2" valign="top">
						<cfif userid NEQ stTeam.leaderid>
							<a href="#myself##myfusebox.thiscircuit#.team_player_delete&userid=#userid#&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_remove#</a><br>
							<a href="#myself##myfusebox.thiscircuit#.team_player_change_status&userid=#userid#&status=leader&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_add_leader#</a><br>
						</cfif>
						<cfif qPlayersReady.recordcount LT qTournament.teamsize>
							<a href="#myself##myfusebox.thiscircuit#.team_player_change_status&userid=#userid#&status=ready&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_player_add_ready#</a>
						</cfif>
					</td>
					<form action="#myself##myfusebox.thiscircuit#.team_player_rearrange_players&userid=#userid#&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" method="post">
						<td colspan="2" valign="top">
							<cfif qPlayersReady.recordcount>
								#request.content.team_player_change_ready#<br>
								<select name="rearrange_users" style="width: 150px;">
									<cfloop query="qPlayersReady"><option value="#userid#">#GetUsernameByID(userid)#</option></cfloop>
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