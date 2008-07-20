<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>




	<cffunction name="getRanking" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfif qTournament.teamsize EQ 1>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qRanking">
				SELECT tsr.teamid, tsr.pos, u.name, t.leaderid
				FROM tournament_type_customranking_ranking tsr, tournament_teams t, user u
				WHERE tsr.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
				AND t.id = tsr.teamid
				AND t.leaderid = u.id
				ORDER BY tsr.pos
			</cfquery>
		
		<cfelse>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qRanking">
				SELECT tsr.teamid, tsr.pos, t.name, t.leaderid
				FROM tournament_type_customranking_ranking tsr, tournament_teams t
				WHERE tsr.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
				AND t.id = tsr.teamid
				ORDER BY tsr.pos
			</cfquery>
		
		</cfif>

		<cfreturn qRanking>
		
	</cffunction>




	<cffunction name="setRanking" access="public" returntype="boolean" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="ranking" required="true" type="struct">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_type_customranking_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfloop collection="#arguments.ranking#" item="idx">
			
			<cfif len(arguments.ranking[idx].teamid) AND len(arguments.ranking[idx].pos)>

				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					INSERT INTO tournament_type_customranking_ranking (tournamentid, teamid, pos)
					VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ranking[idx].teamid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ranking[idx].pos#">)
				</cfquery>
			
			</cfif>
		
		</cfloop>

		<cfreturn true>
		
	</cffunction>




	<cffunction name="deleteTournament" access="public" returntype="boolean" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_type_customranking_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>

		<cfreturn true>
		
	</cffunction>



</cfcomponent>