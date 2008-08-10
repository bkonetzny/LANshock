<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/model/type_se.cfc $
$LastChangedDate: 2008-07-27 05:05:46 +0200 (So, 27 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 426 $
--->

<cfcomponent extends="type">
	
	<cffunction name="createAllMatches" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var qTeams = 0>
		<cfset var qTeams2 = 0>
		
		<cfset resetAllMatches(arguments.tournamentid)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTournamentTeams" returnvariable="qTeams">
			<cfinvokeargument name="tournamentid" value="#arguments.tournamentid#">
		</cfinvoke>
		
		<cfset qTeams2 = duplicate(qTeams)>
		
		<cfloop query="qTeams">
			<cfloop query="qTeams2">
				<cfif qTeams.id NEQ qTeams2.id>
					<cfset createMatch(tournamentid=arguments.tournamentid,col=qTeams.currentrow,row=qTeams2.currentrow,team1=qTeams.id,team2=qTeams2.id,status="play")>
				</cfif>
			</cfloop>
		</cfloop>

	</cffunction>

	<cffunction name="calculateRanking" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var stFilter = StructNew()>
		<cfset var qMatches = 0>
		<cfset var qRanking = QueryNew('teamid, pos, win, lose, pointwin, pointlose')>
		<cfset var lExcludeTeams = ''>
		<cfset var iWinnerID = ''>
		<cfset var iLoserID = ''>
		<cfset var iPosition = 1>
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
					<cfset QuerySetCell(qRanking,'pos',0)>
					<cfset QuerySetCell(qRanking,'win',0)>
					<cfset QuerySetCell(qRanking,'lose',0)>
					<cfset QuerySetCell(qRanking,'pointwin',0)>
					<cfset QuerySetCell(qRanking,'pointlose',0)>
					<cfset lExcludeTeams = ListAppend(lExcludeTeams,iWinnerID)>
				</cfif>
				
				<cfif isNumeric(iLoserID) AND NOT ListFind(lExcludeTeams,iLoserID)>
					<cfset QueryAddRow(qRanking)>
					<cfset QuerySetCell(qRanking,'teamid',iLoserID)>
					<cfset QuerySetCell(qRanking,'pos',0)>
					<cfset QuerySetCell(qRanking,'win',0)>
					<cfset QuerySetCell(qRanking,'lose',0)>
					<cfset QuerySetCell(qRanking,'pointwin',0)>
					<cfset QuerySetCell(qRanking,'pointlose',0)>
					<cfset lExcludeTeams = ListAppend(lExcludeTeams,iLoserID)>
				</cfif>
			</cfloop>
			
			<cfloop query="qRanking">
				<cfset QuerySetCell(qRanking,'win',stStats.stWin[qRanking.teamid],qRanking.currentrow)>
				<cfset QuerySetCell(qRanking,'lose',stStats.stLose[qRanking.teamid],qRanking.currentrow)>
				<cfset QuerySetCell(qRanking,'pointwin',stStats.stPointWin[qRanking.teamid],qRanking.currentrow)>
				<cfset QuerySetCell(qRanking,'pointlose',stStats.stPointLose[qRanking.teamid],qRanking.currentrow)>
			</cfloop>

			<cfquery dbtype="query" name="qRanking">
				SELECT *
				FROM qRanking
				ORDER BY win DESC, lose ASC
			</cfquery>
			
			<cfloop query="qRanking">
				<cfif qRanking.currentrow NEQ 1	AND (
						qRanking.win[qRanking.currentrow-1] GT qRanking.win[qRanking.currentrow]
						OR qRanking.lose[qRanking.currentrow-1] LT qRanking.lose[qRanking.currentrow]
					)>
					<cfset iPosition = iPosition + 1>
				</cfif>
				<cfset QuerySetCell(qRanking,'pos',iPosition,qRanking.currentrow)>
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

</cfcomponent>