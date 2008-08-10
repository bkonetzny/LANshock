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
<h3>#request.content.tournamentsystem#</h3>

<cfif session.userloggedin AND stModuleConfig.coinsystem>
	<p>#request.content.coins_user_amount_avaible# <strong>#iUserCoins#</strong> / #stModuleConfig.coinsystem_usercoins#</p>
</cfif>

<cfoutput query="qTournaments" group="groupid">
	<cfparam name="aUserGroupIDs[id]" default="0">
	<h4>#qTournaments.group_name#</h4>
	<cfif len(qTournaments.group_description)>
		<p>#qTournaments.group_description#</p>
	</cfif>
	<cfif qTournaments.group_maxsignups AND session.userloggedin>
		<br/>#request.content.group_signups_maxsignups# <strong>#aUserGroupIDs[qGroups.id]#</strong> (<cfif qTournaments.group_maxsignups EQ 0>#request.content.group_maxsignups_nolimit#<cfelse>#qTournaments.group_maxsignups#</cfif>)
	</cfif>
	<table>
		<tr>
			<th colspan="2">#request.content.tournament_name#</th>
			<th>#request.content.tournament_maxteams#<!--- </th>
			<th> ---> / #request.content.tournament_teamsize#</th>
			<!--- <th>#request.content.tournament_type#</th> --->
			<cfif stModuleConfig.coinsystem>
				<th>#request.content.coins#</th>
			</cfif>
			<th>#request.content.tournament_status#</th>
			<th>#request.content.tournament_estimatedstarttime#</th>
		</tr>
		<cfoutput>
			<cfswitch expression="#qTournaments.status#">
				<cfcase value="signup,cancelled">
					<cfset sTournamentLink = 'teams'>
				</cfcase>
				<cfcase value="warmup,playing,paused">
					<cfset sTournamentLink = 'matches'>
				</cfcase>
				<cfcase value="done">
					<cfset sTournamentLink = 'ranking'>
				</cfcase>
				<cfdefaultcase>
					<cfset sTournamentLink = 'teams'>
				</cfdefaultcase>
			</cfswitch>
			<tr>
				<td><cfif len(qTournaments.image)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#images/icons/#qTournaments.image#"></cfif></td>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#sTournamentLink#&tournamentid=#qTournaments.id#')#"><cfif len(qTournaments.export_league)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#images/export/#qTournaments.export_league#_small.gif"> </cfif>#qTournaments.name#</a></td>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTournaments.id#')#"><strong>#qTournaments.currentteams#</strong> / #qTournaments.maxteams#</a><!--- </td>
				<td> ---><br/>#qTournaments.teamsize# #request.content.players#<cfif qTournaments.teamsubstitute GT 0> (+ #qTournaments.teamsubstitute#)</cfif></td>
				<!--- <td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#qTournaments.id#')#">#request.content['tournament_type_' & qTournaments.type]#</a></td> --->
				<cfif stModuleConfig.coinsystem>
					<td align="right">#qTournaments.coins#</td>
				</cfif>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#sTournamentLink#&tournamentid=#qTournaments.id#')#">#request.content['tournament_status_' & qTournaments.status]#</a></td>
				<td>#session.oUser.DateTimeFormat(qTournaments.starttime)#
					<cfif DateCompare(qTournaments.starttime,now()) NEQ "-1" AND DateDiff('d',qTournaments.starttime,now()) LTE 31>
						<br/>#calcRemainingTime(qTournaments.starttime)#
					</cfif></td>
			</tr>
		</cfoutput>
	</table>
</cfoutput>
</cfoutput>

<cfsetting enablecfoutputonly="No">