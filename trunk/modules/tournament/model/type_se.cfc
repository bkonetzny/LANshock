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
		
		<cfset var stFilter = StructNew()>
		<cfset var qTournament = 0>
		<cfset var qMatches = 0>
		<cfset var qTeamNames = 0>
		<cfset var aTeamNames = ArrayNew(1)>
		<cfset var aTeam1_Names = ArrayNew(1)>
		<cfset var aTeam2_Names = ArrayNew(1)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
		
		<cfset stFilter = StructNew()>
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
	
		<cfquery dbtype="query" name="qMatches">
			SELECT *
			FROM qMatches
			ORDER BY col, row
		</cfquery>
		
		<cfif qTournament.teamsize EQ 1>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeamNames">
				SELECT t.id, u.name
				FROM tournament_team t
				LEFT JOIN user u ON t.leaderid = u.id
				AND t.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			</cfquery>
			
		<cfelse>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeamNames">
				SELECT id, name
				FROM tournament_team
				WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			</cfquery>
			
		</cfif>
		
		<cfloop query="qTeamNames">
			<cfset aTeamNames[qTeamNames.id] = qTeamNames.name>
		</cfloop>
		
		<cfloop query="qMatches">
		
			<cfif isNumeric(qMatches.team1)>
				<cfparam name="aTeamNames[#qMatches.team1#]" default="">
			</cfif>
			<cfif isNumeric(qMatches.team2)>
				<cfparam name="aTeamNames[#qMatches.team2#]" default="">
			</cfif>
				
			<cfif isNumeric(qMatches.team1)>
				<cfset aTeam1_Names[qMatches.currentrow] = aTeamNames[qMatches.team1]>
			<cfelse>
				<cfset aTeam1_Names[qMatches.currentrow] = ''>
			</cfif>
			<cfif isNumeric(qMatches.team2)>
				<cfset aTeam2_Names[qMatches.currentrow] = aTeamNames[qMatches.team2]>
			<cfelse>
				<cfset aTeam2_Names[qMatches.currentrow] = ''>
			</cfif>
			
		</cfloop>
		
		<cfset QueryAddColumn(qMatches, "team1_name", aTeam1_Names)>
		<cfset QueryAddColumn(qMatches, "team2_name", aTeam2_Names)>

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
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>

		<cfreturn qMatches>
		
	</cffunction>

	<cffunction name="getMatch" access="public" returntype="struct" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="matchid" required="true" type="numeric">
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qMatches">
			SELECT *
			FROM tournament_type_se_match
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
		</cfquery>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qResults">
			SELECT team1_result, team2_result
			FROM tournament_type_se_result
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
	
	<cffunction name="calculateMatches" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">

		<cfset var stFilter = StructNew()>
		<cfset var qMatches = 0>
		<cfset var iTeam1ID = 0>
		<cfset var iTeam2ID = 0>
		
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
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfloop query="qMatches">
			<cfset qMatchesPre = getMatchesByCol(arguments.tournamentid,qMatches.col-1)>
			<cfset iTeam1ID = 0>
			<cfset iTeam2ID = 0>
			
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
				<cfif qIdTeam1.winner EQ 'team1'>
					<cfset iTeam1ID = qIdTeam1.team1>
				<cfelseif qIdTeam1.winner EQ 'team2'>
					<cfset iTeam1ID = qIdTeam1.team2>
				</cfif>
			</cfif>
			
			<cfif qIdTeam2.recordcount>
				<cfif qIdTeam2.winner EQ 'team1'>
					<cfset iTeam2ID = qIdTeam2.team1>
				<cfelseif qIdTeam2.winner EQ 'team2'>
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
		<cfset stFilter.stFields.team1.mode = 'isNull'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
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
		<cfset stFilter.stFields.team2.mode = 'isNull'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfloop query="qMatches">
			<cfset updateMatch(tournamentid=arguments.tournamentid,
								matchid=qMatches.id,
								winner='team1',
								status='done')>
		</cfloop>
		
	</cffunction>

	<cffunction name="createMatch" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="col" required="true" type="numeric">
		<cfargument name="row" required="true" type="numeric">
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			INSERT INTO tournament_type_se_match (col,row,tournamentid,status)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.col#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.row#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
					'empty')
		</cfquery>

	</cffunction>
	
	<cffunction name="createAllMatches" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var iTeams = 0>
		<cfset var iBrackets = 0>
		<cfset var iRowCount = 0>
		<cfset var col = 0>
		<cfset var row = 0>
		<cfset var qTournament = 0>
		
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

	<cffunction name="updateMatch" access="public" returntype="boolean" output="false">
		<cfargument name="matchid" required="true" type="numeric">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="status" required="false" type="string" default="">
		<cfargument name="team1" required="false" type="numeric" default="0">
		<cfargument name="team2" required="false" type="numeric" default="0">
		<cfargument name="winner" required="false" type="string" default="">
		<cfargument name="submittedby_userid" required="false" type="numeric" default="0">
		<cfargument name="submittedby_teamid" required="false" type="numeric" default="0">
		<cfargument name="checkedby_userid" required="false" type="numeric" default="0">
		<cfargument name="checkedby_teamid" required="false" type="numeric" default="0">
		<cfargument name="checkedby_admin" required="false" type="numeric" default="0">
		
		<cfif arguments.status EQ 'reset'
			OR arguments.status EQ 'clear'>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE tournament_type_se_match
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
				DELETE FROM tournament_type_se_result
				WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
			</cfquery>

		<cfelse>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				UPDATE tournament_type_se_match
				SET id = id
					<cfif len(arguments.status)>
						,status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#">
					</cfif>
					<cfif isNumeric(arguments.team1) AND arguments.team1 NEQ 0>
						,team1 = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team1#">
					</cfif>
					<cfif isNumeric(arguments.team2) AND arguments.team2 NEQ 0>
						,team2 = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team2#">
					</cfif>
					<cfif len(arguments.winner)>
						,winner = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.winner#">
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

		<cfreturn true>
		
	</cffunction>

	<cffunction name="updateResults" access="public" returntype="boolean" output="false">
		<cfargument name="matchid" required="true" type="numeric">
		<cfargument name="results" required="true" type="struct">

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_type_se_result
			WHERE matchid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchid#">
		</cfquery>
		
		<cfloop list="#ListSort(StructKeyList(arguments.results),'textnocase')#" index="item">
			
			<cfif isNumeric(arguments.results[item].team1_result) AND isNumeric(arguments.results[item].team2_result)>
			
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					INSERT INTO tournament_type_se_result (matchid,team1_result,team2_result)
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
		
		<cfset var qTournament = 0>
		<cfset var qRanking = 0>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qRanking">
			SELECT tsr.teamid, tsr.pos, <cfif qTournament.teamsize EQ 1>u.name<cfelse>t.name</cfif>, t.leaderid
			FROM tournament_type_se_ranking tsr
			LEFT JOIN tournament_team t ON t.id = tsr.teamid
			<cfif qTournament.teamsize EQ 1>
				LEFT JOIN user u ON t.leaderid = u.id
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
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_type_se_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfset stFilter.stFields.tournamentid = StructNew()>
		<cfset stFilter.stFields.tournamentid.mode = 'isEqual'>
		<cfset stFilter.stFields.tournamentid.value = arguments.tournamentid>
		<cfset stFilter.stFields.status = StructNew()>
		<cfset stFilter.stFields.status.mode = 'isEqual'>
		<cfset stFilter.stFields.status.value = 'done'>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_type_se_match','reactorGateway')#" method="getRecords" returnvariable="qMatches">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfquery dbtype="query" name="qMatches">
			SELECT *
			FROM qMatches
			ORDER BY col DESC, row ASC
		</cfquery>
		
		<cfset iColumn = qMatches.col>
		
		<cfloop query="qMatches">
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
				INSERT INTO tournament_type_se_ranking (tournamentid, teamid, pos)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#qRanking.teamid#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#qRanking.pos#">)
			</cfquery>
		</cfloop>
		
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
		
		<cfset lTeamIDs = ListRandom(lTeamIDs)>
	
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

	<cffunction name="generateWwclExport" access="public" returntype="string" output="false">
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
		
	</cffunction>

	<cffunction name="resetAllMatches" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfset var qMatches = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qMatches">
			SELECT id
			FROM tournament_type_se_match
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
	
		<cfif qMatches.recordcount>
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE FROM tournament_type_se_result
				WHERE matchid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qMatches.id)#" list="true">)
			</cfquery>
		</cfif>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_type_se_ranking
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_type_se_match
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
	</cffunction>

	<cffunction name="LogN" access="public" returntype="any" output="false">
		<cfargument name="x" required="true" type="numeric">
		<cfargument name="base" required="true" type="numeric">

		<cfif x GT 0>
			<cfreturn log(x)/log(base)>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="ListRandom" access="public" returntype="string" output="false">
		<cfargument name="list" required="true" type="string">

		<cfset var final_list = ''>
		<cfset var elements = ListLen(list)>
		
		<cfscript>
			for(x=1; x LTE elements; x=x+1){
				random_i = RandRange(1, ListLen(list));
				random_val = ListGetAt(list, random_i);
				list = ListDeleteAt(list, random_i);
		
				final_list = ListAppend(final_list, random_val);
			}
		</cfscript>
	
		<cfreturn final_list>
	</cffunction>

</cfcomponent>