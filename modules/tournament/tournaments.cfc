<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>




	<cffunction name="getGroups" access="public" returntype="query" output="false">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGroups">
			SELECT id, name, description, maxsignups
			FROM t2k4_groups
			ORDER BY name ASC
		</cfquery>
		
		<cfreturn qGroups>
		
	</cffunction>




	<cffunction name="getGroup" access="public" returntype="query" output="false">
		<cfargument name="id" required="true" type="numeric">
	
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGroup">
			SELECT id, name, description, maxsignups
			FROM t2k4_groups
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn qGroup>
		
	</cffunction>




	<cffunction name="setGroup" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="name" required="true" type="string">
		<cfargument name="description" required="false" type="string" default="">
		<cfargument name="maxsignups" required="false" type="numeric" default="1">
	
		<cfif arguments.id LTE 0>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO t2k4_groups (name, description, maxsignups)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.description#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.maxsignups#">)
			</cfquery>
		
		<cfelse>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				UPDATE t2k4_groups
				SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
					description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.description#">,
					maxsignups = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.maxsignups#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="removeGroup" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="true" type="numeric">
	
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_groups
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="getTournaments" access="public" returntype="query" output="false">
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTournaments">
			SELECT ts.*, COUNT(t.id) AS currentteams
			FROM t2k4_tournaments ts
			LEFT OUTER JOIN t2k4_teams t ON t.tournamentid = ts.id
			GROUP BY ts.id
			ORDER BY ts.name ASC
		</cfquery>
		
		<cfreturn qTournaments>
		
	</cffunction>




	<cffunction name="getUserTournaments" access="public" returntype="query" output="false">
		<cfargument name="userid" type="numeric" required="true">
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qMyTournaments">
			SELECT ts.*, t.id AS teamid, t.name AS teamname, u.name AS playername
			FROM t2k4_tournaments ts, t2k4_teams t, t2k4_players p, user u
			WHERE t.tournamentid = ts.id
			AND p.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#">
			AND p.userid = u.id
			AND t.id = p.teamid
		</cfquery>
		
		<cfreturn qMyTournaments>
		
	</cffunction>




	<cffunction name="setTournament" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="false" type="numeric" default="0">
		<cfargument name="name" required="true" type="string">
		<cfargument name="maxteams" required="true" type="numeric">
		<cfargument name="type" required="true" type="string">
		<cfargument name="export_league" required="true" type="string">
		<cfargument name="export_league_data" required="false" type="string" default="">
		<cfargument name="groupid" required="true" type="numeric">
		<cfargument name="teamsize" required="true" type="numeric">
		<cfargument name="teamsubstitute" required="true" type="numeric">
		<cfargument name="rulefile" required="true" type="string">
		<cfargument name="image" required="true" type="string">
		<cfargument name="coins" required="true" type="numeric">
		<cfargument name="matchcount" required="true" type="numeric">
		<cfargument name="matchtime" required="true" type="numeric">
		<cfargument name="pausetime" required="true" type="numeric">
		<cfargument name="starttime_day" required="false" type="numeric" default="#day(now())#">
		<cfargument name="starttime_month" required="false" type="numeric" default="#month(now())#">
		<cfargument name="starttime_year" required="false" type="numeric" default="#year(now())#">
		<cfargument name="starttime_hour" required="false" type="numeric" default="#hour(now())#">
		<cfargument name="starttime_minute" required="false" type="numeric" default="#minute(now())#">
		<cfargument name="endtime_day" required="false" type="numeric" default="#day(now())#">
		<cfargument name="endtime_month" required="false" type="numeric" default="#month(now())#">
		<cfargument name="endtime_year" required="false" type="numeric" default="#year(now())#">
		<cfargument name="endtime_hour" required="false" type="numeric" default="#hour(now())#">
		<cfargument name="endtime_minute" required="false" type="numeric" default="#minute(now())#">
		<cfargument name="timetable_color" required="false" type="string" default="">
		<cfargument name="ladminids" required="false" type="string" default="">
		<cfargument name="infotext" required="false" type="string" default="">

		<cfset var starttime_generated = now()>
		<cfset var endtime_generated = now()>
		<cftry>
			<cfset starttime_generated = CreateDateTime(arguments.starttime_year, arguments.starttime_month, arguments.starttime_day, arguments.starttime_hour, arguments.starttime_minute, '00')>
			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
		<cftry>
			<cfset endtime_generated = CreateDateTime(arguments.endtime_year, arguments.endtime_month, arguments.endtime_day, arguments.endtime_hour, arguments.endtime_minute, '00')>
			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
		
		<cfset arguments.timetable_color = trim(arguments.timetable_color)>
		
		<cfif arguments.id LTE 0>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				INSERT INTO t2k4_tournaments (name, type, export_league, export_league_data, groupid, maxteams, teamsize, teamsubstitute, rulefile, image, coins, starttime, endtime, pausetime, matchtime, matchcount, timetable_color, ladminids, infotext)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.type#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.export_league#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.export_league_data#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.groupid#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.maxteams#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamsize#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamsubstitute#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.rulefile#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.image#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.coins#">,
						#starttime_generated#,
						#endtime_generated#,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pausetime#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchtime#">,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchcount#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.timetable_color#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ladminids#">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.infotext#">)
			</cfquery>
		
		<cfelse>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				UPDATE t2k4_tournaments
				SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">,
					type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.type#">,
					export_league = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.export_league#">,
					export_league_data = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.export_league_data#">,
					groupid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.groupid#">,
					maxteams = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.maxteams#">,
					teamsize = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamsize#">,
					teamsubstitute = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.teamsubstitute#">,
					rulefile = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.rulefile#">,
					image = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.image#">,
					coins = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.coins#">,
					starttime = #starttime_generated#,
					endtime = #endtime_generated#,
					pausetime = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pausetime#">,
					matchtime = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchtime#">,
					matchcount = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.matchcount#">,
					timetable_color = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.timetable_color#">,
					ladminids = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.ladminids#">,
					infotext = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.infotext#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>




	<cffunction name="setTournamentStatus" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="true" type="numeric">
		<cfargument name="status" required="true" type="string">

		<cfif ListFind("signup,warmup,playing,done,paused,cancelled",arguments.status)>
		
			<cfquery datasource="#request.lanshock.environment.datasource#">
				UPDATE t2k4_tournaments
				SET status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			</cfquery>
			
			<cfreturn true>
		
		<cfelse>

			<cfreturn false>

		</cfif>
		
	</cffunction>




	<cffunction name="getTournamentData" access="public" returntype="query" output="false">
		<cfargument name="id" required="true" type="numeric">
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qTournamentData">
			SELECT t.*, COUNT(tm.id) AS currentteams
			FROM t2k4_tournaments t
			LEFT OUTER JOIN t2k4_teams tm ON tm.tournamentid = t.id
			WHERE t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#">
			GROUP BY t.id
		</cfquery>
		
		<cfreturn qTournamentData>
		
	</cffunction>




	<cffunction name="deleteTournament" access="public" returntype="boolean" output="false">
		<cfargument name="tournamentid" required="true" type="numeric">
		
		<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetTeams">
			SELECT id FROM t2k4_teams
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>

		<cfif qGetTeams.recordcount>
			<cfquery datasource="#request.lanshock.environment.datasource#">
				DELETE FROM t2k4_players
				WHERE teamid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qGetTeams.id)#" list="true">)
			</cfquery>
		</cfif>
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_teams
			WHERE tournamentid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfquery datasource="#request.lanshock.environment.datasource#">
			DELETE FROM t2k4_tournaments
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.tournamentid#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>




</cfcomponent>