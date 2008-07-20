<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getTournaments" access="public" returntype="query" output="false">
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTournaments">
			SELECT ts.*, COUNT(t.id) AS currentteams
			FROM tournament_tournament ts
			LEFT OUTER JOIN tournament_team t ON t.tournamentid = ts.id
			GROUP BY ts.id
			ORDER BY ts.name ASC
		</cfquery>
		
		<cfreturn qTournaments>
		
	</cffunction>

	<cffunction name="getUserTournaments" access="public" returntype="query" output="false">
		<cfargument name="userid" type="numeric" required="true">
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qMyTournaments">
			SELECT ts.*, t.id AS teamid, t.name AS teamname, u.name AS playername
			FROM tournament_tournament ts, tournament_team t, tournament_player p, user u
			WHERE t.tournamentid = ts.id
			AND p.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND p.userid = u.id
			AND t.id = p.teamid
		</cfquery>
		
		<cfreturn qMyTournaments>
		
	</cffunction>

	<cffunction name="getTournamentData" access="public" returntype="query" output="false">
		<cfargument name="id" required="true" type="numeric">
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTournamentData">
			SELECT t.*, COUNT(tm.id) AS currentteams
			FROM tournament_tournament t
			LEFT OUTER JOIN tournament_team tm ON tm.tournamentid = t.id
			WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			GROUP BY t.id
		</cfquery>
		
		<cfreturn qTournamentData>
		
	</cffunction>

</cfcomponent>