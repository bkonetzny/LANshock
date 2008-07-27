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
			
		<cfset iBrackets = iTeams / 2>
		
		<cfloop from="1" to="#iRowCount#" index="col">
			<cfloop from="1" to="#iBrackets#" index="row">
				<cfset createMatch(tournamentid=arguments.tournamentid,col=col,row=row)>
			</cfloop>
			<cfset iBrackets = iBrackets / 2>
		</cfloop>

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
		
		<cfset calculateMatches_Wildcard(arguments.tournamentid)>
		
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.col = StructNew()>
		<cfset stFilter.stFields.col.mode = 'isNotEqual'>
		<cfset stFilter.stFields.col.value = 1>
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
			
			<cfquery dbtype="query" name="qIdTeam2">
				SELECT *
				FROM qMatchesPre
				WHERE row = <cfqueryparam cfsqltype="cf_sql_integer" value="#qMatches.row*2#">
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
			
			<cfif qIdTeam2.recordcount>
				<cfif qIdTeam2.winner EQ 'team1' AND isNumeric(qIdTeam2.team1)>
					<cfset iTeam2ID = qIdTeam2.team1>
				<cfelseif qIdTeam2.winner EQ 'team2' AND isNumeric(qIdTeam2.team2)>
					<cfset iTeam2ID = qIdTeam2.team2>
				</cfif>
			</cfif>
			
			<cfif isNumeric(iTeam1ID) AND iTeam1ID NEQ 0
				AND isNumeric(iTeam2ID) AND iTeam2ID NEQ 0>
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
	
	<cffunction name="randomizeFirstRound" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var stTeams = StructNew()>
		<cfset var idx = ''>
		<cfset var lTeamIDs = ''>
		<cfset var iTeamsReal = ''>
		<cfset var iTeamsDummy = ''>
		<cfset var qMatchesFirstRound = 0>
		<cfset var qTournament = 0>
		
		<cfset createAllMatches(arguments.tournamentid)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
		
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
		
		<cfloop condition="#FindNoCase('0,0',lTeamIDs)# NEQ 0">
			<cfset lTeamIDs = ListRandom(lTeamIDs)>
		</cfloop>
		
		<cfset qMatchesFirstRound = getMatchesByCol(tournamentid=arguments.tournamentid,col=1)>
		
		<cfloop query="qMatchesFirstRound">
			
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateMatch">
				<cfinvokeargument name="tournamentid" value="#arguments.tournamentid#">
				<cfinvokeargument name="matchid" value="#qMatchesFirstRound.id#">
				<cfinvokeargument name="status" value="clear">
			</cfinvoke>
			
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateMatch">
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

		<cfscript>
			iActiveCol = 0;
			sContent = '<winner0>';
			stExportTeams = arguments.stExportTeams;
			qMatches = getMatches(arguments.tournamentid);
		</cfscript>

		<cfloop query="qMatches">
			<cfscript>
				if(col-1 NEQ iActiveCol){
					sContent = sContent & '</winner#iActiveCol#><winner#iActiveCol+1#>';
					iActiveCol = iActiveCol + 1;
				}
				if(winner EQ 'team1') sContent = sContent & '<match><win>#stExportTeams[team1].wwclid#</win><loose>#stExportTeams[team2].wwclid#</loose></match>#chr(13)#';
				else if(winner EQ 'team2') sContent = sContent & '<match><win>#stExportTeams[team2].wwclid#</win><loose>#stExportTeams[team1].wwclid#</loose></match>#chr(13)#';
			</cfscript>
		</cfloop>
		
		<cfset sContent = sContent & '</winner#iActiveCol#>'>

		<cfreturn sContent>
		
	</cffunction> --->

</cfcomponent>