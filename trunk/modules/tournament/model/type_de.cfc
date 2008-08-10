<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent extends="type">

	<cffunction name="createAllMatches" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var iTeams = 0>
		<cfset var iBrackets = 0>
		<cfset var iRowCount = 0>
		<cfset var iRowCountL = 0>
		<cfset var col = 0>
		<cfset var row = 0>
		<cfset var qTournament = 0>
		
		<cfset resetAllMatches(arguments.tournamentid)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
		
		<cfset iTeams = 2^Ceiling(LogN(qTournament.currentteams,2))>
		<cfset iBrackets = iTeams>
		
		<cfloop condition="#iBrackets# GTE 2">
			<cfset iRowCount = iRowCount + 1>
			<cfset iBrackets = iBrackets / 2>
		</cfloop>
		
		<cfset iRowCountL = (iRowCount - 1) * 2>
		<cfset iBrackets = 1>
		
		<cfif iTeams GT 2>
			<cfset iRowCount = iRowCount + 1>
		</cfif>
		
		<cfif iTeams LTE 2>
			<cfset createMatch(tournamentid=arguments.tournamentid,col=1,row=1)>
		<cfelse>
			<!--- Loser Bracket --->
			<cfloop from="1" to="#iRowCountL#" index="col">
				<cfloop from="1" to="#iBrackets#" index="row">
					<cfset createMatch(tournamentid=arguments.tournamentid,col=col,row=row)>
				</cfloop>
				<cfif NOT col MOD 2>
					<cfset iBrackets = iBrackets * 2>
				</cfif>
			</cfloop>
			<!--- Winner Bracket --->
			<cfset iBrackets = iTeams / 2>
			<cfloop from="1" to="#iRowCount#" index="col">
				<cfif col EQ iRowCount>
					<cfset iBrackets = 1>
				</cfif>
				<cfloop from="1" to="#iBrackets#" index="row">
					<cfset createMatch(tournamentid=arguments.tournamentid,col=col+iRowCountL,row=row)>
				</cfloop>
				<cfset iBrackets = iBrackets / 2>
			</cfloop>
		</cfif>

	</cffunction>

	<cffunction name="calculateMatches" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">

		<cfset var stFilter = StructNew()>
		<cfset var qMatches = 0>
		<cfset var iTeam1ID = ''>
		<cfset var iTeam2ID = ''>
		<cfset var qIdTeam1 = 0>
		<cfset var qIdTeam2 = 0>
		<cfset var sStatus = ''>
		
		<cfset var qTournament = 0>
		<cfset var iTeams = 0>
		<cfset var iBrackets = 0>
		<cfset var iRowCount = 0>
		<cfset var iRowCountL = 0>
		<cfset var qMaxRow = 0>
		<cfset var qMaxCol = 0>
		
		<cfset calculateMatches_Wildcard(arguments.tournamentid)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
		
		<cfset iTeams = 2^Ceiling(LogN(qTournament.currentteams,2))>
		<cfset iBrackets = iTeams>
		<cfset iRowCount = 0>
		
		<cfloop condition="#iBrackets# GTE 2">
			<cfset iRowCount = iRowCount + 1>
			<cfset iBrackets = iBrackets / 2>
		</cfloop>
		
		<cfset iRowCountL = (iRowCount - 1) * 2>
		<cfset iBrackets = 1>
		
		<cfif iTeams GT 2>
			<cfset iRowCount = iRowCount + 1>
		</cfif>
		
		<!--- winner bracket --->
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.col = StructNew()>
		<cfset stFilter.stFields.col.mode = 'isGt'>
		<cfset stFilter.stFields.col.value = iRowCountL+1>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'empty'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfloop query="qMatches">
			<cfset qMatchesPre = getMatchesByCol(arguments.tournamentid,qMatches.col-1)>
			<cfset iTeam1ID = ''>
			<cfset iTeam2ID = ''>
			
			<cfquery dbtype="query" name="qIdTeam1">
				SELECT *
				FROM qMatchesPre
				WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.row*2-1#">
				AND winner != ''
				AND status = 'done'
			</cfquery>
	
			<cfquery name="qMaxCol" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				SELECT MAX(col) AS max_col
				FROM tournament_match
				WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			</cfquery>
			
			<cfif qMatches.col EQ qMaxCol.max_col>
				<cfset qMatchesPre = getMatchesByCol(arguments.tournamentid,1)>
				<cfquery dbtype="query" name="qIdTeam2">
					SELECT *
					FROM qMatchesPre
					WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="1">
					AND winner != ''
					AND status = 'done'
				</cfquery>
			<cfelse>
				<cfquery dbtype="query" name="qIdTeam2">
					SELECT *
					FROM qMatchesPre
					WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.row*2#">
					AND winner != ''
					AND status = 'done'
				</cfquery>
			</cfif>
			
			<cfif qIdTeam1.recordcount>
				<cfif qIdTeam1.winner EQ 'team1' AND isNumeric(qIdTeam1.team1)>
					<cfset iTeam1ID = qIdTeam1.team1>
				<cfelseif qIdTeam1.winner EQ 'team2' AND isNumeric(qIdTeam1.team2)>
					<cfset iTeam1ID = qIdTeam1.team2>
				</cfif>
			</cfif>
			
			<cfif qIdTeam2.recordcount>
				<cfif qIdTeam2.winner EQ 'team1' AND isNumeric(qIdTeam2.team1)>
					<cfset iTeam2ID = qIdTeam2.team1>
				<cfelseif qIdTeam2.winner EQ 'team2' AND isNumeric(qIdTeam2.team2)>
					<cfset iTeam2ID = qIdTeam2.team2>
				</cfif>
			</cfif>
			
			<cfif isNumeric(iTeam1ID) AND isNumeric(iTeam2ID)>
				<cfset sStatus = 'play'>
			<cfelse>
				<cfset sStatus = 'empty'>
			</cfif>
			
			<cfset updateMatch(tournamentid=arguments.tournamentid,
								matchid=qMatches.id,
								team1=iTeam1ID,
								team2=iTeam2ID,
								status=sStatus)>
		</cfloop>
		
		<!--- loser bracket --->
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.col = StructNew()>
		<cfset stFilter.stFields.col.mode = 'isLt'>
		<cfset stFilter.stFields.col.value = iRowCountL+1>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'empty'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfloop query="qMatches">
			<cfset iTeam1ID = ''>
			<cfset iTeam2ID = ''>
			
			<cfif qMatches.col MOD 2>
				<cfquery name="qMaxRow" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					SELECT MAX(row) AS max_row
					FROM tournament_match
					WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
					AND col = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.col#">
				</cfquery>
				
				<cfset qMatchesPre = getMatchesByCol(arguments.tournamentid,iRowCountL+1+iRowCount-(qMatches.col+1)/2-1)>
			
				<cfquery dbtype="query" name="qIdTeam2">
					SELECT *
					FROM qMatchesPre
					WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMaxRow.max_row-qMatches.row+1#">
					AND winner != ''
					AND status = 'done'
				</cfquery>

				<cfif qIdTeam2.recordcount>
					<cfif qIdTeam2.winner NEQ 'team1' AND isNumeric(qIdTeam2.team1)>
						<cfset iTeam2ID = qIdTeam2.team1>
					<cfelseif qIdTeam2.winner NEQ 'team2' AND isNumeric(qIdTeam2.team2)>
						<cfset iTeam2ID = qIdTeam2.team2>
					</cfif>
				</cfif>
			<cfelse>
				<cfset qMatchesPre = getMatchesByCol(arguments.tournamentid,qMatches.col+1)>

				<cfquery dbtype="query" name="qIdTeam2">
					SELECT *
					FROM qMatchesPre
					WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.row*2#">
					AND winner != ''
					AND status = 'done'
				</cfquery>
				
				<cfif qMatches.col EQ iRowCountL>
					<cfif qIdTeam2.recordcount>
						<cfif qIdTeam2.winner NEQ 'team1' AND isNumeric(qIdTeam2.team1)>
							<cfset iTeam2ID = qIdTeam2.team1>
						<cfelseif qIdTeam2.winner NEQ 'team2' AND isNumeric(qIdTeam2.team2)>
							<cfset iTeam2ID = qIdTeam2.team2>
						</cfif>
					</cfif>
				<cfelse>
					<cfif qIdTeam2.recordcount>
						<cfif qIdTeam2.winner EQ 'team1' AND isNumeric(qIdTeam2.team1)>
							<cfset iTeam2ID = qIdTeam2.team1>
						<cfelseif qIdTeam2.winner EQ 'team2' AND isNumeric(qIdTeam2.team2)>
							<cfset iTeam2ID = qIdTeam2.team2>
						</cfif>
					</cfif>
				</cfif>
			</cfif>
			
			<cfset qMatchesPre = getMatchesByCol(arguments.tournamentid,qMatches.col+1)>
			
			<cfif qMatches.col EQ iRowCountL>
				<cfquery dbtype="query" name="qIdTeam1">
					SELECT *
					FROM qMatchesPre
					WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.row*2-1#">
					AND winner != ''
					AND status = 'done'
				</cfquery>
				
				<cfif qIdTeam1.recordcount>
					<cfif qIdTeam1.winner NEQ 'team1' AND isNumeric(qIdTeam1.team1)>
						<cfset iTeam1ID = qIdTeam1.team1>
					<cfelseif qIdTeam1.winner NEQ 'team2' AND isNumeric(qIdTeam1.team2)>
						<cfset iTeam1ID = qIdTeam1.team2>
					<cfelse>
						<cfset iTeam1ID = 0>
					</cfif>
				</cfif>
			<cfelseif qMatches.col MOD 2>
				<cfquery dbtype="query" name="qIdTeam1">
					SELECT *
					FROM qMatchesPre
					WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.row#">
					AND winner != ''
					AND status = 'done'
				</cfquery>

				<cfif qIdTeam1.recordcount>
					<cfif qIdTeam1.winner EQ 'team1' AND isNumeric(qIdTeam1.team1)>
						<cfset iTeam1ID = qIdTeam1.team1>
					<cfelseif qIdTeam1.winner EQ 'team2' AND isNumeric(qIdTeam1.team2)>
						<cfset iTeam1ID = qIdTeam1.team2>
					</cfif>
				</cfif>
			<cfelse>
				<cfquery dbtype="query" name="qIdTeam1">
					SELECT *
					FROM qMatchesPre
					WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.row*2-1#">
					AND winner != ''
					AND status = 'done'
				</cfquery>

				<cfif qIdTeam1.recordcount>
					<cfif qIdTeam1.winner EQ 'team1' AND isNumeric(qIdTeam1.team1)>
						<cfset iTeam1ID = qIdTeam1.team1>
					<cfelseif qIdTeam1.winner EQ 'team2' AND isNumeric(qIdTeam1.team2)>
						<cfset iTeam1ID = qIdTeam1.team2>
					</cfif>
				</cfif>
			</cfif>
			
			<cfif isNumeric(iTeam1ID) AND isNumeric(iTeam2ID)>
				<cfset sStatus = 'play'>
			<cfelse>
				<cfset sStatus = 'empty'>
			</cfif>
			
			<cfset updateMatch(tournamentid=arguments.tournamentid,
								matchid=qMatches.id,
								team1=iTeam1ID,
								team2=iTeam2ID,
								status=sStatus)>
		</cfloop>
	</cffunction>

	<cffunction name="calculateRanking" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var stFilter = StructNew()>
		<cfset var qMatches = 0>
		<cfset var qMatchesL = 0>
		<cfset var qRanking = QueryNew('teamid, pos')>
		<cfset var lExcludeTeams = ''>
		<cfset var iWinnerID = ''>
		<cfset var iLoserID = ''>
		<cfset var iPosition = 1>
		<cfset var iColumn = 0>
		<cfset var stStats = StructNew()>
		<cfset var qResults = 0>
		<cfset var qPoints = 0>
		
		<cfset var qTournament = 0>
		<cfset var iTeams = 0>
		<cfset var iBrackets = 0>
		<cfset var iRowCount = 0>
		<cfset var iRowCountL = 0>
		
		<cfset stStats.stWin = StructNew()>
		<cfset stStats.stLose = StructNew()>
		<cfset stStats.stPointWin = StructNew()>
		<cfset stStats.stPointLose = StructNew()>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
		
		<cfset iTeams = 2^Ceiling(LogN(qTournament.currentteams,2))>
		<cfset iBrackets = iTeams>
		<cfset iRowCount = 0>
		
		<cfloop condition="#iBrackets# GTE 2">
			<cfset iRowCount = iRowCount + 1>
			<cfset iBrackets = iBrackets / 2>
		</cfloop>
		
		<cfset iRowCountL = (iRowCount - 1) * 2>
		<cfset iBrackets = 1>
		
		<cfif iTeams GT 2>
			<cfset iRowCount = iRowCount + 1>
		</cfif>
		
		<!--- winner bracket --->
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.col = StructNew()>
		<cfset stFilter.stFields.col.mode = 'isGt'>
		<cfset stFilter.stFields.col.value = iRowCountL+1>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'done'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfquery dbtype="query" name="qMatches">
			SELECT id, team1, team2, winner, col, row, '' AS maxround, 'winner' AS type
			FROM qMatches
			ORDER BY col DESC, row ASC
		</cfquery>
		
		<cfloop query="qMatches">
			<cfset QuerySetCell(qMatches,'maxround',(qMatches.col-1-iRowCountL)*2+1,qMatches.currentrow)>
		</cfloop>
		
		<!--- loser bracket --->
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.col = StructNew()>
		<cfset stFilter.stFields.col.mode = 'isLt'>
		<cfset stFilter.stFields.col.value = iRowCountL+1>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'done'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_match','reactorGateway')#" method="getRecords" returnvariable="qMatchesL">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfquery dbtype="query" name="qMatchesL">
			SELECT id, team1, team2, winner, col, row, '' AS maxround, 'loser' AS type
			FROM qMatchesL
			ORDER BY col ASC, row ASC
		</cfquery>
		
		<cfloop query="qMatchesL">
			<cfset QuerySetCell(qMatchesL,'maxround',iRowCountL-qMatchesL.col+2,qMatchesL.currentrow)>
		</cfloop>
		
		<cfquery dbtype="query" name="qMatches">
			SELECT id, team1, team2, winner, maxround, row
			FROM qMatches
			UNION
			SELECT id, team1, team2, winner, maxround, row
			FROM qMatchesL
			ORDER BY maxround DESC, row ASC
		</cfquery>
		
		<cfif qMatches.recordcount>
			<cfquery name="qResults" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				SELECT matchid, team1_result, team2_result
				FROM tournament_result
				WHERE matchid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qMatches.id)#" list="true">)
			</cfquery>
			
			<cfset iColumn = qMatches.maxround>
			
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
	
				<cfif iColumn GT qMatches.maxround>
					<cfset iPosition = iPosition + 1>
					<cfset iColumn = qMatches.maxround>
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
				<cfset stStats.stLose[iLoserID] = stStats.stLose[iLoserID] + 1>
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

	<cffunction name="randomizeFirstRound" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var stTeams = StructNew()>
		<cfset var idx = ''>
		<cfset var lTeamIDs = ''>
		<cfset var iTeamsReal = ''>
		<cfset var iTeamsDummy = ''>
		<cfset var qMatchesFirstRound = 0>
		<cfset var qTournament = 0>
		<cfset var iSortCount = 0>
		
		<cfset var iTeams = 0>
		<cfset var iBrackets = 0>
		<cfset var iRowCount = 0>
		<cfset var iRowCountL = 0>
		
		<cfset createAllMatches(arguments.tournamentid)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
		
		<cfset iTeams = 2^Ceiling(LogN(qTournament.currentteams,2))>
		<cfset iBrackets = iTeams>
		
		<cfloop condition="#iBrackets# GTE 2">
			<cfset iRowCount = iRowCount + 1>
			<cfset iBrackets = iBrackets / 2>
		</cfloop>

		<cfset iRowCountL = (iRowCount - 1) * 2>
		
		<cfset iTeamsReal = qTournament.currentteams>
		<cfset iTeamsDummy = 2^Ceiling(LogN(iTeamsReal,2))-iTeamsReal>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeams" returnvariable="stTeams">
			<cfinvokeargument name="tournamentid" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfloop collection="#stTeams#" item="idx">
			<cfset lTeamIDs = ListAppend(lTeamIDs,stTeams[idx].id)>
		</cfloop>
		
		<cfif iTeamsDummy GT 0>
			<cfloop from="1" to="#iTeamsDummy#" index="idx">
				<cfset lTeamIDs = ListAppend(lTeamIDs,0)>
			</cfloop>
		</cfif>
		
		<cfloop condition="#iSortCount# LTE 10 AND #FindNoCase('0,0',lTeamIDs)# NEQ 0">
			<cfset lTeamIDs = ListRandom(lTeamIDs)>
			<cfset iSortCount = iSortCount + 1>
		</cfloop>
		
		<cfset qMatchesFirstRound = getMatchesByCol(tournamentid=arguments.tournamentid,col=1+iRowCountL)>
		
		<cfloop query="qMatchesFirstRound">
			
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_de')#" method="updateMatch">
				<cfinvokeargument name="tournamentid" value="#arguments.tournamentid#">
				<cfinvokeargument name="matchid" value="#qMatchesFirstRound.id#">
				<cfinvokeargument name="status" value="clear">
			</cfinvoke>
			
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_de')#" method="updateMatch">
				<cfinvokeargument name="tournamentid" value="#arguments.tournamentid#">
				<cfinvokeargument name="matchid" value="#qMatchesFirstRound.id#">
				<cfinvokeargument name="team1" value="#ListFirst(lTeamIDs)#">
				<cfset lTeamIDs = listDeleteAt(lTeamIDs,1)>
				<cfinvokeargument name="team2" value="#ListFirst(lTeamIDs)#">
				<cfset lTeamIDs = listDeleteAt(lTeamIDs,1)>
				<cfinvokeargument name="status" value="play">
			</cfinvoke>
		
		</cfloop>
		
	</cffunction>

	<!--- <cffunction name="generateWwclExport" access="public" returntype="string" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="stExportTeams" required="true" type="struct">
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
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
	
	<cffunction name="setRanking" access="public" returntype="boolean" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="ranking" required="true" type="struct">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfloop collection="#arguments.ranking#" item="idx">
			
			<cfif len(arguments.ranking[idx].teamid) AND len(arguments.ranking[idx].pos)>

				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					INSERT INTO tournament_ranking (tournamentid, teamid, pos)
					VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ranking[idx].teamid#">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ranking[idx].pos#">)
				</cfquery>
			
			</cfif>
		
		</cfloop>

		<cfreturn true>
		
	</cffunction> --->

</cfcomponent>