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
			SELECT t.*, COUNT(tt.id) AS currentteams,
					g.season_id AS group_season_id, g.name AS group_name, g.description AS group_description, g.maxsignups AS group_maxsignups,
					s.name AS season_name, s.event_id
			FROM tournament_group g
			INNER JOIN tournament_tournament t ON t.groupid = g.id
			LEFT OUTER JOIN tournament_team tt ON tt.tournamentid = t.id
			LEFT OUTER JOIN tournament_season s ON s.id = g.season_id
			GROUP BY t.id
			ORDER BY g.name ASC, t.name ASC
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
		
		<cfset var qTournamentData = 0>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTournamentData">
			SELECT t.*, COUNT(tt.id) AS currentteams,
					g.season_id AS group_season_id, g.name AS group_name, g.description AS group_description, g.maxsignups AS group_maxsignups,
					s.name AS season_name, s.event_id
			FROM tournament_group g
			INNER JOIN tournament_tournament t ON t.groupid = g.id
			LEFT OUTER JOIN tournament_team tt ON tt.tournamentid = t.id
			LEFT OUTER JOIN tournament_season s ON s.id = g.season_id
			WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			GROUP BY t.id
		</cfquery>
		
		<cfreturn qTournamentData>
		
	</cffunction>

</cfcomponent>