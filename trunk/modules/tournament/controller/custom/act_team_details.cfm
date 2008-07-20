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

<cfset queryobject = stTeam.players>
<cfquery dbtype="query" name="qPlayers">
	SELECT id, userid, status
	FROM queryobject
</cfquery>
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
<cfquery dbtype="query" name="qPlayersAwaitingAuthorisation">
	SELECT id, userid, status
	FROM queryobject
	WHERE status = 'awaiting_authorisation'
</cfquery>

<cfsetting enablecfoutputonly="No">