<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getTeam" access="public" returntype="query" output="false">
		<cfargument name="id" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qTeam">
			SELECT t.*, COUNT(u.user_id) AS members
			FROM core_team t, core_team_user u
			WHERE t.id = u.team_id
			AND t.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
			GROUP BY t.id
			ORDER BY name DESC
		</cfquery>
		
		<cfreturn qTeam>
		
	</cffunction>

	<cffunction name="deleteTeam" access="public" returntype="boolean" output="false">
		<cfargument name="id" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#">
			DELETE FROM core_team
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="setTeam" access="public" returntype="numeric" output="false">
		<cfargument name="id" required="true" type="numeric">
		<cfargument name="name" required="true" type="string">
		<cfargument name="tag" required="true" type="string">
		<cfargument name="homepage" required="false" type="string" default="">
		<cfargument name="description" required="false" type="string" default="">

		<cfset var iNewTeamID = arguments.id>

		<cfif arguments.id NEQ 0>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				UPDATE core_team
				SET name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" maxlength="255">,
					tag = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tag#" maxlength="255">,
					homepage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.homepage#" maxlength="255">,
					description = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.description#">
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
			</cfquery>

		<cfelse>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				INSERT INTO core_team (name, tag, homepage, description)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" maxlength="255">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tag#" maxlength="255">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.homepage#" maxlength="255">,
						<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.description#">)
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#" name="qNewTeamID">
				SELECT id
				FROM core_team
				WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#" maxlength="255">
				AND tag = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tag#" maxlength="255">
				AND homepage = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.homepage#" maxlength="255">
				AND description = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.description#">
				ORDER BY id DESC
			</cfquery>
			
			<cfset iNewTeamID = qNewTeamID.id>

		</cfif>
		
		<cfreturn iNewTeamID>
		
	</cffunction>

	<cffunction name="getTeamMembers" access="public" returntype="query" output="false">
		<cfargument name="id" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qTeamMembers">
			SELECT t.*, u.name, u.firstname, u.lastname
			FROM core_team_user t, user u
			WHERE t.team_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
			AND t.user_id = u.id
			ORDER BY u.name ASC
		</cfquery>
		
		<cfreturn qTeamMembers>
		
	</cffunction>

	<cffunction name="setTeamMember" access="public" returntype="boolean" output="false">
		<cfargument name="team_id" required="true" type="numeric">
		<cfargument name="user_id" required="true" type="numeric">
		<cfargument name="status" required="true" type="string">
		<cfargument name="rights" required="true" type="string">

		<cfif arguments.status EQ 'delete'>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM core_team_user
				WHERE team_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team_id#" maxlength="11">
				AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#" name="qValidateTeam">
				SELECT team_id
				FROM core_team_user
				WHERE team_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team_id#" maxlength="11">
			</cfquery>
			
			<cfif NOT qValidateTeam.recordcount>
				<cfinvoke method="deleteTeam">
					<cfinvokeargument name="id" value="#arguments.team_id#">
				</cfinvoke>
			</cfif>
		
		<cfelse>

			<cfquery datasource="#application.lanshock.environment.datasource#" name="qValidateTeam">
				SELECT team_id, user_id
				FROM core_team_user
				WHERE team_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team_id#" maxlength="11">
				AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
			</cfquery>
			
			<cfif qValidateTeam.recordcount>
	
				<cfquery datasource="#application.lanshock.environment.datasource#">
					UPDATE core_team_user
					SET status = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#" maxlength="255">,
						rights = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.rights#">				
					WHERE team_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team_id#" maxlength="11">
					AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">
				</cfquery>
	
			<cfelse>
	
				<cfquery datasource="#application.lanshock.environment.datasource#">
					INSERT INTO core_team_user (team_id, user_id, status, rights)
					VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.team_id#" maxlength="11">,
							<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#" maxlength="11">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.status#" maxlength="255">,
							<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.rights#">)
				</cfquery>
			
			</cfif>
		
		</cfif>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="getTeams" access="public" returntype="query" output="false">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qTeams">
			SELECT t.*, COUNT(u.user_id) AS members
			FROM core_team t
			LEFT OUTER JOIN core_team_user u ON t.id = u.team_id
			GROUP BY t.id
			ORDER BY name DESC
		</cfquery>
		
		<cfreturn qTeams>
		
	</cffunction>

	<cffunction name="getMemberData" access="public" returntype="query" output="false">
		<cfargument name="id" required="true" type="numeric">

		<cfquery datasource="#application.lanshock.environment.datasource#" name="qMemberData">
			SELECT *
			FROM core_team_user
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.id#" maxlength="11">
		</cfquery>
		
		<cfreturn qMemberData>
		
	</cffunction>

</cfcomponent>