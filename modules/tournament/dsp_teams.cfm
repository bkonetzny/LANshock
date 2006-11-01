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
<div class="headline2">#request.content.teams_headline#</div>
<br><br>

<cfif qTournament.status EQ "signup" AND request.session.userloggedin AND NOT qTeamCurrentUser.recordcount>
	<a href="#myself##myfusebox.thiscircuit#.signup&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.add_a_new_team#</a>
	<br><br>
</cfif>

<cfif qTournament.teamsize GT 1>
	<table class="list">
		<tr>
			<th>#request.content.teams_team#</th>
			<th>#request.content.teams_members#</th>
			<th>#request.content.teamleader#</th>
			<th>#request.content.teams_leaderseat#</th>
		</tr>
		<cfset lTeams = ListSort(StructKeyList(stTeams),'numeric','ASC')>
		<cfloop list="#lTeams#" index="item">
			<cfset queryobject = stTeams[item].players>
			<cfquery dbtype="query" name="qPlayersReady">
				SELECT id, userid, status
				FROM queryobject
				WHERE status = 'ready'
			</cfquery>
			<cfquery dbtype="query" name="qPlayersWaiting">
				SELECT id, userid, status
				FROM queryobject
				WHERE status = 'waiting'
			</cfquery>
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.team_details&teamid=#stTeams[item].id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#">#HTMLEditFormat(stTeams[item].name)#</a></td>
				<td align="center">#qPlayersReady.recordcount# (#qPlayersWaiting.recordcount#)</td>
				<td><cfif request.session.userloggedin AND request.session.userid NEQ stTeams[item].leaderid><a href="javascript:SendMsg(#stTeams[item].leaderid#)"><img src="#stImageDir.general#/mail.gif" alt="" border="0"></a></cfif>
					<a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stTeams[item].leaderid#&#request.session.UrlToken#">#stTeams[item].leadername#</a></td>
				<td>
					<cftry>
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#stTeams[item].leaderid#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry></td>
			</tr>
		</cfloop>
	</table>
<cfelse>
	<cfif qTournament.status EQ "signup" AND request.session.userloggedin AND qTeamCurrentUser.recordcount>
		<a href="#myself##myfusebox.thiscircuit#.team_delete&teamid=#qTeamCurrentUser.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.delete_this_team#</a><br>
		#request.content.delete_this_team_hint#
	</cfif>
	<table class="list">
		<tr>
			<th colspan="2">#request.content.teamleader#</th>
			<th>#request.content.teams_leaderseat#</th>
		</tr>
		<cfset lTeams = ListSort(StructKeyList(stTeams),'numeric','ASC')>
		<cfloop list="#lTeams#" index="item">
			<tr>
				<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stTeams[item].leaderid#&#request.session.UrlToken#">#stTeams[item].leadername#</a></td>
				<td align="right"><cfif request.session.userloggedin AND request.session.userid NEQ stTeams[item].leaderid><a href="javascript:SendMsg(#stTeams[item].leaderid#)"><img src="#stImageDir.general#/mail.gif" alt="" border="0"></a><cfelse>&nbsp;</cfif></td>
				<td>
					<cftry>
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#stTeams[item].leaderid#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry></td>
			</tr>
		</cfloop>
	</table>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">