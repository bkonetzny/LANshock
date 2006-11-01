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
		
		<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfif qTournament.teamsize EQ 1>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qRanking">
				SELECT tsr.teamid, tsr.pos, u.name, t.leaderid
				FROM t2k4_type_customranking_ranking tsr, t2k4_teams t, user u
				WHERE tsr.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
				AND t.id = tsr.teamid
				AND t.leaderid = u.id
				ORDER BY tsr.pos
			</cfquery>
		
		<cfelse>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qRanking">
				SELECT tsr.teamid, tsr.pos, t.name, t.leaderid
				FROM t2k4_type_customranking_ranking tsr, t2k4_teams t
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
	
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_type_customranking_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfloop collection="#arguments.ranking#" item="idx">
			
			<cfif len(arguments.ranking[idx].teamid) AND len(arguments.ranking[idx].pos)>

				<cfquery datasource="#request.lanshock.environment.datasource#">
					INSERT INTO t2k4_type_customranking_ranking (tournamentid, teamid, pos)
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
	
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_type_customranking_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>

		<cfreturn true>
		
	</cffunction>



</cfcomponent>