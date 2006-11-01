<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>




	<cffunction name="getMatches" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qMatches">
			SELECT *
			FROM t2k4_type_de_matches
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			ORDER BY col, row
		</cfquery>
		
		<cfif qTournament.teamsize EQ 1>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeamNames">
				SELECT t.id, u.name
				FROM t2k4_teams t, user u
				WHERE t.leaderid = u.id
				AND tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			</cfquery>
			
		<cfelse>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeamNames">
				SELECT id, name
				FROM t2k4_teams
				WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			</cfquery>
			
		</cfif>
	
		<cfscript>
			aTeam1_Names = ArrayNew(1);
			aTeam2_Names = ArrayNew(1);
			
			aTeamNames = ArrayNew(1);
		</cfscript>
		
		<cfloop query="qTeamNames">
			<cfset aTeamNames[id] = name>
		</cfloop>
		
		<cfloop query="qMatches">
		
			<cfif team1 NEQ 0>
				<cfparam name="aTeamNames[#team1#]" default="">
			</cfif>
			<cfif team2 NEQ 0>
				<cfparam name="aTeamNames[#team2#]" default="">
			</cfif>
				
			<cfscript>
				if(team1 NEQ 0)	aTeam1_Names[currentrow] = aTeamNames[team1];
				else aTeam1_Names[currentrow] = '';
				if(team2 NEQ 0)	aTeam2_Names[currentrow] = aTeamNames[team2];
				else aTeam2_Names[currentrow] = '';
			</cfscript>
			
		</cfloop>
		
		<cfscript>
			QueryAddColumn(qMatches, "team1_name", aTeam1_Names);
			QueryAddColumn(qMatches, "team2_name", aTeam2_Names);
		</cfscript>

		<cfreturn qMatches>
		
	</cffunction>




	<cffunction name="getMatchesByCol" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="col" required="true" type="numeric">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qMatches">
			SELECT *
			FROM t2k4_type_de_matches
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND col = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.col#">
		</cfquery>

		<cfreturn qMatches>
		
	</cffunction>




	<cffunction name="getMatch" access="public" returntype="struct" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="matchid" required="true" type="numeric">
		
		<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qMatches">
			SELECT *
			FROM t2k4_type_de_matches
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
		</cfquery>
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qResults">
			SELECT team1_result, team2_result
			FROM t2k4_type_de_results
			WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.id#">
			ORDER BY id
		</cfquery>
		
		<cfif qTournament.teamsize EQ 1>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeam1Name">
				SELECT u.name, t.leaderid
				FROM t2k4_teams t, user u
				WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team1#">
				AND t.leaderid = u.id
			</cfquery>
		
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeam2Name">
				SELECT u.name, t.leaderid
				FROM t2k4_teams t, user u
				WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team2#">
				AND t.leaderid = u.id
			</cfquery>
			
		<cfelse>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeam1Name">
				SELECT name, leaderid
				FROM t2k4_teams
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team1#">
			</cfquery>
		
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeam2Name">
				SELECT name, leaderid
				FROM t2k4_teams
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team2#">
			</cfquery>
			
		</cfif>
		
		<cfscript>
			stMatch = StructNew();
			stMatch.id = qMatches.id;
			stMatch.status = qMatches.status;
			stMatch.col = qMatches.col;
			stMatch.row = qMatches.row;
			stMatch.results = qResults;
			stMatch.winner = qMatches.winner;
			stMatch.submittedby_userid = qMatches.submittedby_userid;
			stMatch.submittedby_teamid = qMatches.submittedby_teamid;
			stMatch.submittedby_dt = qMatches.submittedby_dt;
			stMatch.checkedby_userid = qMatches.checkedby_userid;
			stMatch.checkedby_teamid = qMatches.checkedby_teamid;
			stMatch.checkedby_dt = qMatches.checkedby_dt;
			stMatch.checkedby_admin = qMatches.checkedby_admin;
			stMatch.checkedby_admin_dt = qMatches.checkedby_admin_dt;
			stMatch.team1 = StructNew();
			stMatch.team1.id = qMatches.team1;
			stMatch.team1.name = qTeam1Name.name;
			stMatch.team1.leaderid = qTeam1Name.leaderid;
			stMatch.team2 = StructNew();
			stMatch.team2.id = qMatches.team2;
			stMatch.team2.name = qTeam2Name.name;
			stMatch.team2.leaderid = qTeam2Name.leaderid;
		</cfscript>

		<cfreturn stMatch>
		
	</cffunction>




	<cffunction name="createMatch" access="public" returntype="boolean" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="col" required="true" type="numeric">
		<cfargument name="row" required="true" type="numeric">
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qMatches">
			INSERT INTO t2k4_type_de_matches (col,row,tournamentid,status)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.col#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.row#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
					'empty')
		</cfquery>

		<cfreturn true>
		
	</cffunction>




	<cffunction name="updateMatch" access="public" returntype="boolean" output="false">
		<cfargument name="matchid" required="true" type="numeric">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="status" required="false" type="string">
		<cfargument name="team1" required="false" type="string">
		<cfargument name="team2" required="false" type="string">
		<cfargument name="winner" required="false" type="string">
		<cfargument name="submittedby_userid" required="false" type="numeric">
		<cfargument name="submittedby_teamid" required="false" type="numeric">
		<cfargument name="checkedby_userid" required="false" type="numeric">
		<cfargument name="checkedby_teamid" required="false" type="numeric">
		<cfargument name="checkedby_admin" required="false" type="numeric">
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qMatches">
			UPDATE t2k4_type_de_matches
			SET id = id
				<cfif isDefined('arguments.status')>
					,status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#">
				</cfif>
				<cfif isDefined('arguments.team1')>
					,team1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.team1#">
				</cfif>
				<cfif isDefined('arguments.team2')>
					,team2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.team2#">
				</cfif>
				<cfif isDefined('arguments.winner')>
					,winner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.winner#">
				</cfif>
				<cfif isDefined('arguments.submittedby_userid')>
					,submittedby_userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.submittedby_userid#">
					,submittedby_dt = #now()#
				</cfif>
				<cfif isDefined('arguments.submittedby_teamid')>
					,submittedby_teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.submittedby_teamid#">
				</cfif>
				<cfif isDefined('arguments.checkedby_userid')>
					,checkedby_userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.checkedby_userid#">
					,checkedby_dt = #now()#
				</cfif>
				<cfif isDefined('arguments.checkedby_teamid')>
					,checkedby_teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.checkedby_teamid#">
				</cfif>
				<cfif isDefined('arguments.checkedby_admin')>
					,checkedby_admin = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.checkedby_admin#">
					,checkedby_admin_dt = #now()#
				</cfif>
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
		</cfquery>
		
		<cfif isDefined("arguments.status") AND arguments.status EQ 'reset'>
		
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qMatches">
				UPDATE t2k4_type_de_matches
				SET status = 'play',
					winner = '',
					submittedby_userid = NULL,
					submittedby_teamid = NULL,
					submittedby_dt = NULL,
					checkedby_userid = NULL,
					checkedby_teamid = NULL,
					checkedby_dt = NULL,
					checkedby_admin = NULL,
					checkedby_admin_dt = NULL
				WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
				AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
			</cfquery>

			<cfquery datasource="#request.lanshock.environment.datasource#">
				DELETE FROM t2k4_type_de_results
				WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
			</cfquery>
		
		</cfif>

		<cfreturn true>
		
	</cffunction>




	<cffunction name="updateResults" access="public" returntype="boolean" output="false">
		<cfargument name="matchid" required="true" type="numeric">
		<cfargument name="results" required="true" type="struct">

		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_type_de_results
			WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
		</cfquery>
		
		<cfloop list="#ListSort(StructKeyList(arguments.results),'textnocase')#" index="item">
			
			<cfif isNumeric(arguments.results[item].team1_result) AND isNumeric(arguments.results[item].team2_result)>
			
				<cfquery datasource="#request.lanshock.environment.datasource#">
					INSERT INTO t2k4_type_de_results (matchid,team1_result,team2_result)
					VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.results[item].team1_result#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.results[item].team2_result#">)
				</cfquery>
			
			</cfif>
			
		</cfloop>

		<cfreturn true>
		
	</cffunction>




	<cffunction name="getRanking" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfif qTournament.teamsize EQ 1>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qRanking">
				SELECT tsr.teamid, tsr.pos, u.name, t.leaderid
				FROM t2k4_type_de_ranking tsr, t2k4_teams t, user u
				WHERE tsr.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
				AND t.id = tsr.teamid
				AND t.leaderid = u.id
				ORDER BY tsr.pos
			</cfquery>
		
		<cfelse>
	
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qRanking">
				SELECT tsr.teamid, tsr.pos, t.name, t.leaderid
				FROM t2k4_type_de_ranking tsr, t2k4_teams t
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
			DELETE FROM t2k4_type_de_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfloop collection="#arguments.ranking#" item="idx">
			
			<cfif len(arguments.ranking[idx].teamid) AND len(arguments.ranking[idx].pos)>

				<cfquery datasource="#request.lanshock.environment.datasource#">
					INSERT INTO t2k4_type_de_ranking (tournamentid, teamid, pos)
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
			DELETE FROM t2k4_type_de_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetMatchIDs">
			SELECT id
			FROM t2k4_type_de_matches
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
	
		<cfif qGetMatchIDs.recordcount>
			<cfquery datasource="#request.lanshock.environment.datasource#">
				DELETE FROM t2k4_type_de_results
				WHERE matchid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qGetMatchIDs.id)#" list="true">)
			</cfquery>
		</cfif>
	
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_type_de_matches
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>

		<cfreturn true>
		
	</cffunction>




	<cffunction name="LogN" access="public" returntype="numeric" output="false">
		<cfargument name="x" required="true" type="numeric">
		<cfargument name="base" required="true" type="numeric">

		<cfscript>
			if(arguments.x GT 0) return(log(arguments.x)/log(arguments.base));
			else return false;
		</cfscript>
		
	</cffunction>




	<cffunction name="generateWwclExport" access="public" returntype="string" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="stExportTeams" required="true" type="struct">
		
		<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>

		<cfscript>
			iTeams = qTournament.currentteams;
			iTeams = 2^Ceiling(LogN(iTeams,2));
			iBrackets = iTeams;
			iRowCount = 0;
			while(iBrackets GTE 2){
				iRowCount = iRowCount + 1;
				iBrackets = iBrackets / 2;
			}
			iRowCountL = (iRowCount - 1) * 2;

			iActiveCol = 1;
			sContent = '<looser#iRowCountL#>';
			stExportTeams = arguments.stExportTeams;
			qMatches = getMatches(arguments.tournamentid);
		</cfscript>

		<cfloop query="qMatches">
			<cfscript>			
				if(col NEQ iActiveCol){
					if(iRowCountL+1-iActiveCol GT 0) sContent = sContent & '</looser#iRowCountL+1-iActiveCol#>';
					else sContent = sContent & '</winner#abs(iRowCountL+1-iActiveCol)#>';
					if(iRowCountL-iActiveCol GT 0) sContent = sContent & '<looser#iRowCountL-iActiveCol#>';
					else sContent = sContent & '<winner#abs(iRowCountL-iActiveCol)#>';
					iActiveCol = iActiveCol + 1;
				}
				if(winner EQ 'team1') sContent = sContent & '<match><win>#stExportTeams[team1].wwclid#</win><loose>#stExportTeams[team2].wwclid#</loose></match>#chr(13)#';
				else if(winner EQ 'team2') sContent = sContent & '<match><win>#stExportTeams[team2].wwclid#</win><loose>#stExportTeams[team1].wwclid#</loose></match>#chr(13)#';
			</cfscript>
		</cfloop>
		
		<cfset sContent = sContent & '</winner#abs(iRowCountL-iActiveCol+1)#>'>

		<cfreturn sContent>
		
	</cffunction>



</cfcomponent>