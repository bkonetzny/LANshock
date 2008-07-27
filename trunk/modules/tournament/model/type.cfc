<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/model/type_se.cfc $
$LastChangedDate: 2008-07-22 02:35:52 +0200 (Di, 22 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 424 $
--->

<cfcomponent>

	<cffunction name="getMatches" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var qTournament = 0>
		<cfset var qMatches = 0>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qMatches">
			SELECT m.*, u1.country AS team1_country, u2.country AS team2_country, <cfif qTournament.teamsize EQ 1>u1.name AS team1_name, u2.name AS team2_name<cfelse>t1.name AS team1_name, t2.name AS team2_name</cfif>
			FROM tournament_match m
			LEFT OUTER JOIN tournament_team t1 ON t1.id = m.team1
			LEFT OUTER JOIN tournament_team t2 ON t2.id = m.team2
			LEFT OUTER JOIN user u1 ON t1.leaderid = u1.id
			LEFT OUTER JOIN user u2 ON t2.leaderid = u2.id
			WHERE m.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			ORDER BY m.col, m.row
		</cfquery>
		
		<cfreturn qMatches>
		
	</cffunction>

	<cffunction name="getMatchesByCol" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="col" required="true" type="numeric">
		
		<cfset var stFilter = StructNew()>
		<cfset var qMatches = 0>
		
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.col = StructNew()>
		<cfset stFilter.stFields.col.mode = 'isEqual'>
		<cfset stFilter.stFields.col.value = arguments.col>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>

		<cfreturn qMatches>
		
	</cffunction>

	<cffunction name="getMatch" access="public" returntype="struct" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="matchid" required="true" type="numeric">
		
		<cfset var qMatches = 0>
		<cfset var qResults = 0>
		<cfset var qTournament = 0>
		<cfset var qTeam1Name = 0>
		<cfset var qTeam2Name = 0>
		<cfset var stMatch = StructNew()>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qMatches">
			SELECT *
			FROM tournament_match
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
		</cfquery>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qResults">
			SELECT team1_result, team2_result
			FROM tournament_result
			WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.id#">
			ORDER BY id
		</cfquery>
		
		<cfif qTournament.teamsize EQ 1>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeam1Name">
				SELECT u.name, t.leaderid
				FROM tournament_team t, user u
				WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team1#">
				AND t.leaderid = u.id
			</cfquery>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeam2Name">
				SELECT u.name, t.leaderid
				FROM tournament_team t, user u
				WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team2#">
				AND t.leaderid = u.id
			</cfquery>
			
		<cfelse>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeam1Name">
				SELECT name, leaderid
				FROM tournament_team
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team1#">
			</cfquery>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeam2Name">
				SELECT name, leaderid
				FROM tournament_team
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.team2#">
			</cfquery>
			
		</cfif>
		
		<cfset stMatch.id = qMatches.id>
		<cfset stMatch.status = qMatches.status>
		<cfset stMatch.col = qMatches.col>
		<cfset stMatch.row = qMatches.row>
		<cfset stMatch.qResults = qResults>
		<cfset stMatch.winner = qMatches.winner>
		<cfset stMatch.submittedby_userid = qMatches.submittedby_userid>
		<cfset stMatch.submittedby_teamid = qMatches.submittedby_teamid>
		<cfset stMatch.submittedby_dt = qMatches.submittedby_dt>
		<cfset stMatch.checkedby_userid = qMatches.checkedby_userid>
		<cfset stMatch.checkedby_teamid = qMatches.checkedby_teamid>
		<cfset stMatch.checkedby_dt = qMatches.checkedby_dt>
		<cfset stMatch.checkedby_admin = qMatches.checkedby_admin>
		<cfset stMatch.checkedby_admin_dt = qMatches.checkedby_admin_dt>
		<cfset stMatch.team1 = StructNew()>
		<cfset stMatch.team1.id = qMatches.team1>
		<cfset stMatch.team1.name = qTeam1Name.name>
		<cfset stMatch.team1.leaderid = qTeam1Name.leaderid>
		<cfset stMatch.team2 = StructNew()>
		<cfset stMatch.team2.id = qMatches.team2>
		<cfset stMatch.team2.name = qTeam2Name.name>
		<cfset stMatch.team2.leaderid = qTeam2Name.leaderid>

		<cfreturn stMatch>
		
	</cffunction>

	<cffunction name="createMatch" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="col" required="true" type="numeric">
		<cfargument name="row" required="true" type="numeric">
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			INSERT INTO tournament_match (col,row,tournamentid,status)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.col#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.row#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
					'empty')
		</cfquery>

	</cffunction>
	
	<cffunction name="calculateMatches_Wildcard" access="private" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">

		<cfset var stFilter = StructNew()>
		<cfset var qMatches = 0>
		
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'play'>
		<cfset stFilter.stFields.team1 = StructNew()>
		<cfset stFilter.stFields.team1.mode = 'isEqual'>
		<cfset stFilter.stFields.team1.value = '0'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfloop query="qMatches">
			<cfset updateMatch(tournamentid=arguments.tournamentid,
								matchid=qMatches.id,
								winner='team2',
								status='done')>
		</cfloop>
		
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'play'>
		<cfset stFilter.stFields.team2 = StructNew()>
		<cfset stFilter.stFields.team2.mode = 'isEqual'>
		<cfset stFilter.stFields.team2.value = '0'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfloop query="qMatches">
			<cfset updateMatch(tournamentid=arguments.tournamentid,
								matchid=qMatches.id,
								winner='team1',
								status='done')>
		</cfloop>
		
	</cffunction>

	<cffunction name="updateMatch" access="public" returntype="void" output="false">
		<cfargument name="matchid" required="true" type="numeric">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="status" required="false" type="string" default="">
		<cfargument name="team1" required="false" type="string" default="">
		<cfargument name="team2" required="false" type="string" default="">
		<cfargument name="winner" required="false" type="string" default="">
		<cfargument name="submittedby_userid" required="false" type="numeric" default="0">
		<cfargument name="submittedby_teamid" required="false" type="numeric" default="0">
		<cfargument name="checkedby_userid" required="false" type="numeric" default="0">
		<cfargument name="checkedby_teamid" required="false" type="numeric" default="0">
		<cfargument name="checkedby_admin" required="false" type="numeric" default="0">
		
		<cfif arguments.status EQ 'reset'
			OR arguments.status EQ 'clear'>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE tournament_match
				SET status = 'play',
					winner = '',
					<cfif arguments.status EQ 'clear'>
						team1 = NULL,
						team2 = NULL,
					</cfif>
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

			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE FROM tournament_result
				WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
			</cfquery>

		<cfelse>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE tournament_match
				SET id = id
					<cfif len(arguments.status)>
						,status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#">
					</cfif>
					<cfif isNumeric(arguments.team1)>
						,team1 = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team1#">
					</cfif>
					<cfif isNumeric(arguments.team2)>
						,team2 = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team2#">
					</cfif>
					<cfif len(arguments.winner)>
						<cfif arguments.winner EQ 'NULL'>
							,winner = NULL
						<cfelse>
							,winner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.winner#">
						</cfif>
					</cfif>
					<cfif isNumeric(arguments.submittedby_userid) AND arguments.submittedby_userid NEQ 0>
						,submittedby_userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.submittedby_userid#">
						,submittedby_dt = #now()#
					</cfif>
					<cfif isNumeric(arguments.submittedby_teamid) AND arguments.submittedby_teamid NEQ 0>
						,submittedby_teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.submittedby_teamid#">
					</cfif>
					<cfif isNumeric(arguments.checkedby_userid) AND arguments.checkedby_userid NEQ 0>
						,checkedby_userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.checkedby_userid#">
						,checkedby_dt = #now()#
					</cfif>
					<cfif isNumeric(arguments.checkedby_teamid) AND arguments.checkedby_teamid NEQ 0>
						,checkedby_teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.checkedby_teamid#">
					</cfif>
					<cfif isNumeric(arguments.checkedby_admin) AND arguments.checkedby_admin NEQ 0>
						,checkedby_admin = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.checkedby_admin#">
						,checkedby_admin_dt = #now()#
					</cfif>
				WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
				AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
			</cfquery>
		
		</cfif>

	</cffunction>

	<cffunction name="updateResults" access="public" returntype="void" output="false">
		<cfargument name="matchid" required="true" type="numeric">
		<cfargument name="results" required="true" type="struct">
		
		<cfset var idx = ''>

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_result
			WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
		</cfquery>
		
		<cfloop list="#ListSort(StructKeyList(arguments.results),'textnocase')#" index="idx">
			
			<cfif isNumeric(arguments.results[idx].team1_result) AND isNumeric(arguments.results[idx].team2_result)>
			
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					INSERT INTO tournament_result (matchid,team1_result,team2_result)
					VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.results[item].team1_result#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.results[item].team2_result#">)
				</cfquery>
			
			</cfif>
			
		</cfloop>

	</cffunction>

	<cffunction name="getRanking" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var qTournament = 0>
		<cfset var qRanking = 0>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qRanking">
			SELECT tsr.teamid, tsr.pos, tsr.stats_win, tsr.stats_lose, tsr.points_win, tsr.points_lose, <cfif qTournament.teamsize EQ 1>u.name<cfelse>t.name</cfif>, t.leaderid
			FROM tournament_ranking tsr
			INNER JOIN tournament_team t ON t.id = tsr.teamid
			<cfif qTournament.teamsize EQ 1>
				INNER JOIN user u ON t.leaderid = u.id
			</cfif>
			WHERE tsr.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			ORDER BY tsr.pos
		</cfquery>

		<cfreturn qRanking>
		
	</cffunction>

	<cffunction name="calculateRanking" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var stFilter = StructNew()>
		<cfset var qMatches = 0>
		<cfset var qRanking = QueryNew('teamid, pos')>
		<cfset var lExcludeTeams = ''>
		<cfset var iWinnerID = ''>
		<cfset var iLoserID = ''>
		<cfset var iPosition = 1>
		<cfset var iColumn = 0>
		<cfset var stStats = StructNew()>
		<cfset var qResults = 0>
		<cfset var qPoints = 0>
		
		<cfset stStats.stWin = StructNew()>
		<cfset stStats.stLose = StructNew()>
		<cfset stStats.stPointWin = StructNew()>
		<cfset stStats.stPointLose = StructNew()>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'done'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfif qMatches.recordcount>
			<cfquery name="qResults" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				SELECT matchid, team1_result, team2_result
				FROM tournament_result
				WHERE matchid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qMatches.id)#" list="true">)
			</cfquery>
			
			<cfquery dbtype="query" name="qMatches">
				SELECT id, team1, team2, winner, col
				FROM qMatches
				ORDER BY col DESC, row ASC
			</cfquery>
			
			<cfset iColumn = qMatches.col>
			
			<cfloop query="qMatches">
				<cfif NOT StructKeyExists(stStats.stWin,qMatches.team1)>
					<cfset stStats.stWin[qMatches.team1] = 0>
				</cfif>
				<cfif NOT StructKeyExists(stStats.stWin,qMatches.team2)>
					<cfset stStats.stWin[qMatches.team2] = 0>
				</cfif>
				<cfif NOT StructKeyExists(stStats.stLose,qMatches.team1)>
					<cfset stStats.stLose[qMatches.team1] = 0>
				</cfif>
				<cfif NOT StructKeyExists(stStats.stLose,qMatches.team2)>
					<cfset stStats.stLose[qMatches.team2] = 0>
				</cfif>
				<cfif NOT StructKeyExists(stStats.stPointWin,qMatches.team1)>
					<cfset stStats.stPointWin[qMatches.team1] = 0>
				</cfif>
				<cfif NOT StructKeyExists(stStats.stPointWin,qMatches.team2)>
					<cfset stStats.stPointWin[qMatches.team2] = 0>
				</cfif>
				<cfif NOT StructKeyExists(stStats.stPointLose,qMatches.team1)>
					<cfset stStats.stPointLose[qMatches.team1] = 0>
				</cfif>
				<cfif NOT StructKeyExists(stStats.stPointLose,qMatches.team2)>
					<cfset stStats.stPointLose[qMatches.team2] = 0>
				</cfif>
	
				<cfif iColumn GT qMatches.col>
					<cfset iPosition = iPosition + 1>
					<cfset iColumn = qMatches.col>
				</cfif>
				
				<cfif qMatches.winner EQ 'team1'>
					<cfset iWinnerID = qMatches.team1>
					<cfset iLoserID = qMatches.team2>
				<cfelse>
					<cfset iWinnerID = qMatches.team2>
					<cfset iLoserID = qMatches.team1>
				</cfif>
			
				<cfquery dbtype="query" name="qPoints">
					SELECT SUM(team1_result) AS team1_result_sum, SUM(team2_result) AS team2_result_sum
					FROM qResults
					WHERE matchid = #qMatches.id#
				</cfquery>
			
				<cfset stStats.stWin[iWinnerID] = stStats.stWin[iWinnerID] + 1>
				<cfset stStats.stLose[iLoserID] = stStats.stWin[iLoserID] + 1>
				<cfif isNumeric(qPoints.team1_result_sum)>
					<cfset stStats.stPointWin[qMatches.team1] = stStats.stPointWin[qMatches.team1] + qPoints.team1_result_sum>
					<cfset stStats.stPointLose[qMatches.team2] = stStats.stPointLose[qMatches.team2] + qPoints.team1_result_sum>
				</cfif>
				<cfif isNumeric(qPoints.team2_result_sum)>
					<cfset stStats.stPointWin[qMatches.team2] = stStats.stPointWin[qMatches.team2] + qPoints.team2_result_sum>
					<cfset stStats.stPointLose[qMatches.team1] = stStats.stPointLose[qMatches.team1] + qPoints.team2_result_sum>
				</cfif>
				
				<cfif isNumeric(iWinnerID) AND NOT ListFind(lExcludeTeams,iWinnerID)>
					<cfset QueryAddRow(qRanking)>
					<cfset QuerySetCell(qRanking,'teamid',iWinnerID)>
					<cfset QuerySetCell(qRanking,'pos',iPosition)>
					<cfset iPosition = iPosition + 1>
					<cfset lExcludeTeams = ListAppend(lExcludeTeams,iWinnerID)>
				</cfif>
				
				<cfif isNumeric(iLoserID) AND NOT ListFind(lExcludeTeams,iLoserID)>
					<cfset QueryAddRow(qRanking)>
					<cfset QuerySetCell(qRanking,'teamid',iLoserID)>
					<cfset QuerySetCell(qRanking,'pos',iPosition)>
					<cfset lExcludeTeams = ListAppend(lExcludeTeams,iLoserID)>
				</cfif>
			</cfloop>
			
			<cfloop query="qRanking">
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					INSERT INTO tournament_ranking (tournamentid, teamid, pos, stats_win, stats_lose, points_win, points_lose)
					VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#qRanking.teamid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#qRanking.pos#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#stStats.stWin[qRanking.teamid]#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#stStats.stLose[qRanking.teamid]#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#stStats.stPointWin[qRanking.teamid]#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#stStats.stPointLose[qRanking.teamid]#">)
				</cfquery>
			</cfloop>
		</cfif>
		
	</cffunction>

	<cffunction name="resetAllMatches" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var qMatches = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qMatches">
			SELECT id
			FROM tournament_match
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
	
		<cfif qMatches.recordcount>
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE FROM tournament_result
				WHERE matchid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qMatches.id)#" list="true">)
			</cfquery>
		</cfif>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_match
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
	</cffunction>

	<cffunction name="LogN" access="public" returntype="any" output="false">
		<cfargument name="x" required="true" type="numeric">
		<cfargument name="base" required="true" type="numeric">

		<cfif arguments.x GT 0>
			<cfreturn log(arguments.x)/log(arguments.base)>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="ListRandom" access="public" returntype="string" output="false">
		<cfargument name="list" required="true" type="string">

		<cfset var lRandomList = ''>
		<cfset var iElements = ListLen(list)>
		<cfset var iRandomElement = ''>
		<cfset var sRandomValue = ''>
		<cfset var idx = 1>
		
		<cfloop condition="#idx# LTE #iElements#">
			<cfset idx = idx + 1>
			<cfset iRandomElement = RandRange(1, ListLen(arguments.list))>
			<cfset sRandomValue = ListGetAt(arguments.list, iRandomElement)>
			<cfset arguments.list = ListDeleteAt(arguments.list, iRandomElement)>
			<cfset lRandomList = ListAppend(lRandomList, sRandomValue)>
		</cfloop>
	
		<cfreturn lRandomList>
	</cffunction>

</cfcomponent>