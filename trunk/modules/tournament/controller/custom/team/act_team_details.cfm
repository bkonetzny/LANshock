<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif qTournament.teamsize EQ 1>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTournament.id#')#" addtoken="false">
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	<cfinvokeargument name="teamid" value="#attributes.teamid#">
</cfinvoke>

<cfif StructIsEmpty(stTeam)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTournament.id#')#" addtoken="false">
</cfif>

<cfset qPlayers = stTeam.players>

<cfquery dbtype="query" name="qPlayersStatus">
	SELECT DISTINCT COUNT(status) as status_count, status
	FROM qPlayers
	GROUP BY status
</cfquery>

<cfset stStatus = StructNew()>
<cfset stStatus.ready = 0>
<cfset stStatus.waiting = 0>
<cfset stStatus.awaiting_authorisation = 0>
<cfloop query="qPlayersStatus">
	<cfset stStatus[qPlayersStatus.status] = qPlayersStatus.status_count>
</cfloop>

<cfsetting enablecfoutputonly="No">