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


<cfloop query="qGroups">
	<cfparam name="aUserGroupIDs[id]" default="0">
	<h4>#qGroups.name#</h4>
	<cfif len(qGroups.description)>
		<p>#qGroups.description#</p>
	</cfif>
	<cfif qGroups.maxsignups AND session.userloggedin>
		<br/>#request.content.group_signups_maxsignups# <strong>#aUserGroupIDs[qGroups.id]#</strong> (<cfif qGroups.maxsignups EQ 0>#request.content.group_maxsignups_nolimit#<cfelse>#qGroups.maxsignups#</cfif>)
	</cfif>
	<table>
		<tr>
			<th colspan="2">#request.content.tournament_name#</th>
			<th>#request.content.tournament_maxteams#</th>
			<th>#request.content.tournament_teamsize#</th>
			<!--- <th>#request.content.tournament_type#</th> --->
			<cfif stModuleConfig.coinsystem>
				<th>#request.content.coins#</th>
			</cfif>
			<!--- <th>#request.content.tournament_status#</th> --->
			<th>#request.content.tournament_estimatedstarttime#</th>
		</tr>
		<cfloop query="qTournaments">
			<cfif qTournaments.groupid EQ qGroups.id>
				<tr>
					<td><cfif len(qTournaments.image)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#images/icons/#qTournaments.image#"></cfif></td>
					<cfif session.oUser.checkPermissions('*','admin')>
						<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTournaments.id#')#"><cfif len(qTournaments.export_league)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#images/export/#qTournaments.export_league#_small.gif"> </cfif>#qTournaments.name#</a></td>
						<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTournaments.id#')#"><!--- <strong>#currentteams#</strong> /  --->#qTournaments.maxteams#</a></td>
					<cfelse>
						<td>#qTournaments.name#</td>
						<td>#qTournaments.maxteams#</td>
					</cfif>
					<td>#qTournaments.teamsize# #request.content.players#<cfif qTournaments.teamsubstitute GT 0> (+ #qTournaments.teamsubstitute#)</cfif></td>
					<!--- <td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#qTournaments.id#')#">#request.content['tournament_type_' & qTournaments.type]#</a></td> --->
					<cfif stModuleConfig.coinsystem>
						<td align="right">#qTournaments.coins#</td>
					</cfif>
					<!--- <td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#qTournaments.id#')#">#request.content['tournament_status_' & qTournaments.status]#</a></td> --->
					<td>#session.oUser.DateTimeFormat(qTournaments.starttime)#
						<cfif DateCompare(qTournaments.starttime,now()) NEQ "-1" AND DateDiff('d',qTournaments.starttime,now()) LTE 31>
							<br/>#calcRemainingTime(qTournaments.starttime)#
						</cfif></td>
				</tr>
			</cfif>
		</cfloop>
	</table>
</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="No">