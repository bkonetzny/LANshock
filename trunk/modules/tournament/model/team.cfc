<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getTeams" access="public" returntype="struct" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">

		<cfset var qTournament = 0>
		<cfset var qTeams = 0>
		<cfset var qPlayers = 0>
		<cfset var stTeams = StructNew()>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeams">
			SELECT t.id, t.leaderid, t.autoacceptids, t.leagueid, u.name AS leadername, u.email, <cfif qTournament.teamsize EQ 1>u.name<cfelse>t.name</cfif>
			FROM tournament_team t
			INNER JOIN user u ON t.leaderid = u.id
			WHERE t.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			ORDER BY t.name ASC, leadername ASC
		</cfquery>
		
		<cfloop query="qTeams">
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qPlayers">
				SELECT id, userid, status
				FROM tournament_player
				WHERE teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#qTeams.id#">
			</cfquery> 
			
			<cfset stTeams[qTeams.currentrow] = StructNew()>
			<cfset stTeams[qTeams.currentrow].id = qTeams.id>
			<cfset stTeams[qTeams.currentrow].name = qTeams.name>
			<cfset stTeams[qTeams.currentrow].leaderid = qTeams.leaderid>
			<cfset stTeams[qTeams.currentrow].leaderemail = qTeams.email>
			<cfset stTeams[qTeams.currentrow].leadername = qTeams.leadername>
			<cfset stTeams[qTeams.currentrow].autoacceptids = qTeams.autoacceptids>
			<cfset stTeams[qTeams.currentrow].players = qPlayers>
			<cfset stTeams[qTeams.currentrow].leagueid = qTeams.leagueid>
			
		</cfloop>
		
		<cfreturn stTeams>
		
	</cffunction>

	<cffunction name="getTeamData" access="public" returntype="struct" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="teamid" required="true" type="numeric">

		<cfset var qTournament = 0>
		<cfset var qTeams = 0>
		<cfset var qPlayers = 0>
		<cfset var stTeam = StructNew()>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeams">
			SELECT t.leaderid, t.autoacceptids, t.leagueid, <cfif qTournament.teamsize EQ 1>u.name<cfelse>t.name</cfif>
			FROM tournament_team t
			<cfif qTournament.teamsize EQ 1>
				INNER JOIN user u ON t.leaderid = u.id
			</cfif> 
			WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
			AND t.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfif qTeams.recordcount>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qPlayers">
				SELECT p.id, p.userid, p.status, u.name, u.firstname, u.lastname
				FROM tournament_player p
				INNER JOIN user u ON p.userid = u.id
				WHERE p.teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
				ORDER BY p.status ASC
			</cfquery>
		
			<cfset stTeam.id = arguments.teamid>
			<cfset stTeam.name = qTeams.name>
			<cfset stTeam.leagueid = qTeams.leagueid>
			<cfset stTeam.tournamentid = arguments.tournamentid>
			<cfset stTeam.autoacceptids = qTeams.autoacceptids>
			<cfset stTeam.leaderid = qTeams.leaderid>
			<cfset stTeam.players = qPlayers>
		
		</cfif>
		
		<cfreturn stTeam>
		
	</cffunction>

	<cffunction name="getTeamByUserID" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">
		
		<cfset var qTeamCurrentUser = 0>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeamCurrentUser">
			SELECT t.id, t.name
			FROM tournament_team t
			INNER JOIN tournament_player p ON t.id = p.teamid AND p.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			WHERE t.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfreturn qTeamCurrentUser>
		
	</cffunction>

	<cffunction name="createTeam" access="public" returntype="numeric" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="leaderid" required="true" type="numeric">
		<cfargument name="name" required="true" type="string">
		<cfargument name="leagueid" required="false" type="string" default="">

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			INSERT INTO tournament_team (tournamentid, leaderid, name, leagueid)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.leaderid#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.leagueid#">)
		</cfquery>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeamID">
			SELECT id
			FROM tournament_team
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND leaderid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.leaderid#">
			AND name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">
		</cfquery>

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			INSERT INTO tournament_player (userid, teamid, status)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.leaderid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#qTeamID.id#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="ready">)
		</cfquery>
		
		<cfreturn qTeamID.id>
		
	</cffunction>

	<cffunction name="setTeamData" access="public" returntype="boolean" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="teamname" required="false" type="string">
		<cfargument name="leagueid" required="false" type="string">
		<cfargument name="autoacceptids" required="false" type="string">
		
		<cfif isDefined("arguments.autoacceptids")>
			<cfloop list="#arguments.autoacceptids#" index="idx">
				<cfif NOT isNumeric(idx)><cfset arguments.autoacceptids = ListDeleteAt(arguments.autoacceptids, ListFind(arguments.autoacceptids,idx))></cfif>
			</cfloop>
		</cfif>

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			UPDATE tournament_team
			SET id = id
			<cfif isDefined("arguments.teamname")>
				,name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.teamname#">
			</cfif>
			<cfif isDefined("arguments.leagueid")>
				,leagueid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.leagueid#">
			</cfif>
			<cfif isDefined("arguments.autoacceptids")>
				,autoacceptids = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.autoacceptids#">
			</cfif>
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="joinTeam" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">
	
		<cfset var sStatus = "awaiting_authorisation">
		<cfset var stTeam = StructNew()>
	
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
			<cfinvokeargument name="tournamentid" value="#arguments.tournamentid#">
			<cfinvokeargument name="teamid" value="#arguments.teamid#">
		</cfinvoke>
		
		<cfif NOT ListFind(ValueList(stTeam.players.userid),arguments.userid)>
		
			<cfif ListFind(stTeam.autoacceptids,arguments.userid)>
				<cfset sStatus = "ready">
			</cfif>
	
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO tournament_player (userid, teamid, status)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#sStatus#">)
			</cfquery>
		
		</cfif>
		
	</cffunction>

	<cffunction name="leaveTeam" access="public" returntype="void" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">

		<cfset var stTeam = StructNew()>

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_player
			WHERE userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
	
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
			<cfinvokeargument name="tournamentid" value="#arguments.tournamentid#">
			<cfinvokeargument name="teamid" value="#arguments.teamid#">
		</cfinvoke>
		
		<cfif NOT stTeam.players.recordcount>
	
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="removeTeam">
				<cfinvokeargument name="teamid" value="#arguments.teamid#">
			</cfinvoke>
		
		</cfif>
		
	</cffunction>

	<cffunction name="removeTeam" access="public" returntype="void" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_player
			WHERE teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_team
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
		
	</cffunction>

	<cffunction name="changePlayerStatus" access="public" returntype="boolean" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">
		<cfargument name="status" required="true" type="string">

		<cfif ListFind('ready,waiting,leader',arguments.status)>
	
			<cfif arguments.status EQ 'leader'>
		
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qTeamID">
					UPDATE tournament_team
					SET leaderid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
					WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.teamid#">
				</cfquery>
			
			<cfelse>
	
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					UPDATE tournament_player
					SET status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#">
					WHERE userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
					AND teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
				</cfquery>
			
			</cfif>
			
			<cfreturn true>
		
		<cfelse>
		
			<cfreturn false>
		
		</cfif>
		
	</cffunction>

	<cffunction name="removePlayer" access="public" returntype="boolean" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM tournament_player
			WHERE userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
	
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
			<cfinvokeargument name="teamid" value="#arguments.teamid#">
		</cfinvoke>
		
		<cfif ListFind(stTeam.autoacceptids,arguments.userid)>

			<cfinvoke method="setTeamAutoacceptids">
				<cfinvokeargument name="teamid" value="#arguments.teamid#">
				<cfinvokeargument name="autoacceptids" value="#ListDeleteAt(stTeam.autoacceptids,ListFind(stTeam.autoacceptids,arguments.userid))#">
			</cfinvoke>
			
		</cfif>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="getAllUsersInTeams" access="public" returntype="query" output="false">
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qAllUsersInTeams">
			SELECT u.id, u.name
			FROM tournament_player p, user u
			WHERE p.userid = u.id
			GROUP BY u.id
			ORDER BY u.name
		</cfquery>
		
		<cfreturn qAllUsersInTeams>
		
	</cffunction>

</cfcomponent>