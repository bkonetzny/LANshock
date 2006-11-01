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
		
		<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
			<cfinvokeargument name="id" value="#arguments.tournamentid#">
		</cfinvoke>
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeams">
			SELECT t.id, t.leaderid, t.autoacceptids, t.leagueid, u.name AS leadername, u.email, <cfif qTournament.teamsize EQ 1>u.name<cfelse>t.name</cfif>
			FROM t2k4_teams t, user u
			WHERE t.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND t.leaderid = u.id
			ORDER BY t.name ASC, leadername ASC
		</cfquery>
		
		<cfscript>
			stTeams = StructNew();
		</cfscript>
		
		<cfloop query="qTeams">
		
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qPlayers">
				SELECT id, userid, status
				FROM t2k4_players
				WHERE teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">
			</cfquery> 
			
			<cfscript>
				stTeams[currentrow] = StructNew();
				stTeams[currentrow].id = id;
				stTeams[currentrow].name = name;
				stTeams[currentrow].leaderid = leaderid;
				stTeams[currentrow].leaderemail = email; // for wwcl export
				stTeams[currentrow].leadername = leadername;
				stTeams[currentrow].autoacceptids = autoacceptids;
				stTeams[currentrow].players = qPlayers;
				stTeams[currentrow].leagueid = leagueid;
			</cfscript>
			
		</cfloop>
		
		<cfreturn stTeams>
		
	</cffunction>




	<cffunction name="getTeamData" access="public" returntype="struct" output="false">
		<cfargument name="teamid" required="true" type="numeric">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetTournamentID">
			SELECT tournamentid
			FROM t2k4_teams
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>

		<cfif qGetTournamentID.recordcount>
			<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
				<cfinvokeargument name="id" value="#qGetTournamentID.tournamentid#">
			</cfinvoke>
		
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeams">
				SELECT t.id, t.tournamentid, t.leaderid, t.autoacceptids, t.leagueid, u.name AS leadername, u.email, <cfif qTournament.teamsize EQ 1>u.name<cfelse>t.name</cfif>
				FROM t2k4_teams t, user u
				WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
				AND t.leaderid = u.id
			</cfquery>
			
			<cfquery datasource="#request.lanshock.environment.datasource#" name="qPlayers">
				SELECT id, userid, status
				FROM t2k4_players
				WHERE teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
			</cfquery>
		
			<cfscript>
				stTeam = StructNew();
				stTeam.id = qTeams.id;
				stTeam.name = qTeams.name;
				stTeam.leagueid = qTeams.leagueid;
				stTeam.tournamentid = qTeams.tournamentid;
				stTeam.autoacceptids = qTeams.autoacceptids;
				stTeam.leaderid = qTeams.leaderid;
				stTeam.players = qPlayers;
			</cfscript>
		<cfelse>
			<cfscript>
				stTeam = StructNew();
				stTeam.id = arguments.teamid;
				stTeam.name = '';
				stTeam.leagueid = '';
				stTeam.tournamentid = '';
				stTeam.autoacceptids = '';
				stTeam.leaderid = '';
				stTeam.players = '';
			</cfscript>
		</cfif>
		
		<cfreturn stTeam>
		
	</cffunction>




	<cffunction name="getTeamByUserID" access="public" returntype="query" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeamCurrentUser">
			SELECT t.id, t.name
			FROM t2k4_teams t, t2k4_players p
			WHERE t.tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND p.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND t.id = p.teamid
		</cfquery>
		
		<cfreturn qTeamCurrentUser>
		
	</cffunction>




	<cffunction name="createTeam" access="public" returntype="numeric" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		<cfargument name="leaderid" required="true" type="numeric">
		<cfargument name="name" required="true" type="string">
		<cfargument name="leagueid" required="false" type="string" default="">

		<cfquery datasource="#request.lanshock.environment.datasource#">
			INSERT INTO t2k4_teams (tournamentid, leaderid, name, leagueid)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.leaderid#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.leagueid#">)
		</cfquery>
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeamID">
			SELECT id
			FROM t2k4_teams
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
			AND leaderid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.leaderid#">
			AND name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">
		</cfquery>

		<cfquery datasource="#request.lanshock.environment.datasource#">
			INSERT INTO t2k4_players (userid, teamid, status)
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

		<cfquery datasource="#request.lanshock.environment.datasource#">
			UPDATE t2k4_teams
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




	<cffunction name="joinTeam" access="public" returntype="boolean" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">
	
		<cfset var status = "awaiting_authorisation">
	
		<cfinvoke component="team" method="getTeamData" returnvariable="stTeam">
			<cfinvokeargument name="teamid" value="#arguments.teamid#">
		</cfinvoke>
		
		<cfset queryobject = stTeam.players>
		
		<cfif NOT ListFind(ValueList(queryobject.userid),arguments.userid)>
		
			<cfif ListFind(stTeam.autoacceptids,arguments.userid)>
				<cfset status = "ready">
			</cfif>
	
			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO t2k4_players (userid, teamid, status)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#status#">)
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="leaveTeam" access="public" returntype="boolean" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">

		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_players
			WHERE userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
	
		<cfinvoke component="team" method="getTeamData" returnvariable="stTeam">
			<cfinvokeargument name="teamid" value="#arguments.teamid#">
		</cfinvoke>
		
		<cfif NOT stTeam.players.recordcount>
	
			<cfinvoke component="team" method="removeTeam">
				<cfinvokeargument name="teamid" value="#arguments.teamid#">
			</cfinvoke>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="removeTeam" access="public" returntype="boolean" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_players
			WHERE teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
	
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_teams
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="changePlayerStatus" access="public" returntype="boolean" output="false">
		<cfargument name="teamid" required="true" type="numeric">
		<cfargument name="userid" required="true" type="numeric">
		<cfargument name="status" required="true" type="string">

		<cfif ListFind('ready,waiting,leader',arguments.status)>
	
			<cfif arguments.status EQ 'leader'>
		
				<cfquery datasource="#request.lanshock.environment.datasource#" name="qTeamID">
					UPDATE t2k4_teams
					SET leaderid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
					WHERE id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.teamid#">
				</cfquery>
			
			<cfelse>
	
				<cfquery datasource="#request.lanshock.environment.datasource#">
					UPDATE t2k4_players
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

		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_players
			WHERE userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND teamid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamid#">
		</cfquery>
	
		<cfinvoke component="team" method="getTeamData" returnvariable="stTeam">
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
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qAllUsersInTeams">
			SELECT u.id, u.name
			FROM t2k4_players p, user u
			WHERE p.userid = u.id
			GROUP BY u.id
			ORDER BY u.name
		</cfquery>
		
		<cfreturn qAllUsersInTeams>
		
	</cffunction>




</cfcomponent>