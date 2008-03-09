<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent hint="Preferences Manager">
	
	<cfset variables.user_id = ''>
	<cfset variables.stPreferences = ''>

	<cffunction name="init" access="public">
		<cfargument name="user_id" type="numeric" required="true">
		
		<cfset variables.user_id = arguments.user_id>
		<cfset variables.stPreferences = getPreferences()>
		
		<cfreturn this>
	</cffunction>

	<cffunction name="getPreferences" output="false" returntype="struct">
		<cfargument name="module" type="string" required="false" default="">
		<cfargument name="user_id" type="numeric" required="false" default="#variables.user_id#">
		
		<cfset var stLocal = StructNew()>
		<cfset stLocal.stReturn = StructNew()>

		<cfif application.lanshock.config.complete>
		
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="stLocal.qPreferences">
				SELECT preferences
				FROM user
				WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
			</cfquery>
			
			<cfif stLocal.qPreferences.recordcount AND isWDDX(stLocal.qPreferences.preferences)>
				<cfwddx action="wddx2cfml" input="#stLocal.qPreferences.preferences#" output="stLocal.stPreferences">

				<cfif len(arguments.module) AND StructKeyExists(stLocal.stPreferences,arguments.module)>
					<cfset stLocal.stReturn = stLocal.stPreferences[arguments.module]>
				<cfelse>
					<cfset stLocal.stReturn = stLocal.stPreferences>
				</cfif>
			</cfif>
			
		</cfif>
		
		<cfreturn stLocal.stReturn>
		
	</cffunction>

	<cffunction name="setPreferences" output="false" returntype="boolean">
		<cfargument name="module" type="string" required="true">
		<cfargument name="data" type="struct" required="true">
		<cfargument name="user_id" type="numeric" required="false" default="#variables.user_id#">
		
		<cfset var stLocal = StructNew()>
		<cfset stLocal.stPreferences = getPreferences(arguments.user_id)>
		<cfset stLocal.stPreferences[arguments.module] = arguments.data>
		<cfset updateDbEntry(arguments.user_id,stLocal.stPreferences)>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="setPreference" output="false" returntype="boolean">
		<cfargument name="module" type="string" required="true">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="string" required="true">
		<cfargument name="user_id" type="numeric" required="false" default="#variables.user_id#">
		
		<cfset var stLocal = StructNew()>
		<cfset stLocal.stPreferences = getPreferences(arguments.user_id)>
		<cfset stLocal.stPreferences[arguments.module][arguments.key] = arguments.value>
		<cfset updateDbEntry(arguments.user_id,stLocal.stPreferences)>
		
		<cfreturn true>
		
	</cffunction>

	<cffunction name="updateDbEntry" access="private" output="false" returntype="boolean">
		<cfargument name="user_id" type="numeric" required="true">
		<cfargument name="data" type="struct" required="true">
		
		<cfset var stLocal = StructNew()>
		
		<cfwddx action="cfml2wddx" input="#arguments.data#" output="stLocal.wddxData">

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			UPDATE user
			SET preferences = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#stLocal.wddxData#">
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
		</cfquery>
		
		<cfreturn true>
		
	</cffunction>

</cfcomponent>