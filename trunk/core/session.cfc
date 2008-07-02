<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>
	
	<cffunction name="init" output="false" returntype="void">
		
		<cfset session.stVariablesScope.name = ''>
		<cfset session.stVariablesScope.userloggedin = false>
		<cfset session.stVariablesScope.userID = 0>
		<cfset session.stVariablesScope.isAdmin = false>
		<cfset session.stVariablesScope.qPermissions = QueryNew("module,name")>
		<cfset session.stVariablesScope.ip_address = cgi.remote_addr>
		<cfset session.stVariablesScope.lang = UCase(application.lanshock.settings.language)>
		<cfset session.stVariablesScope.stCustomData = StructNew()>
		
		<!--- TODO: remove --->
		<cfset copyVars()>
		
	</cffunction>

	<cffunction name="copyVars" output="false" returntype="void">
		
		<cfset session.name = session.stVariablesScope.name>
		<cfset session.userloggedin = session.stVariablesScope.userloggedin>
		<cfset session.userID = session.stVariablesScope.userID>
		<cfset session.isAdmin = session.stVariablesScope.isAdmin>
		<cfset session.ip_address = session.stVariablesScope.ip_address>
		<cfset session.lang = session.stVariablesScope.lang>
		
	</cffunction>
	
	<cffunction name="getData" output="false" returntype="struct">
		
		<cfreturn session.stVariablesScope>
		
	</cffunction>

	<cffunction name="getDataValue" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		
		<cfreturn session.stVariablesScope[arguments.key]>
	</cffunction>

	<cffunction name="setDataValue" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		
		<cfset session.stVariablesScope[arguments.key] = arguments.value>
		
		<!--- TODO: remove --->
		<cfset copyVars()>
	</cffunction>

	<cffunction name="getCustomDataValue" output="false" returntype="any">
		<cfargument name="key" type="string" required="true">
		<cfargument name="defaultvalue" type="any" required="false" default="">
		
		<cfif NOT StructKeyExists(session.stVariablesScope.stCustomData,arguments.key)>
			<cfset setCustomDataValue(arguments.key,arguments.defaultvalue)>
		</cfif>
		
		<cfreturn session.stVariablesScope.stCustomData[arguments.key]>
	</cffunction>

	<cffunction name="setCustomDataValue" output="false" returntype="void">
		<cfargument name="key" type="string" required="true">
		<cfargument name="value" type="any" required="true">
		
		<cfset session.stVariablesScope.stCustomData[arguments.key] = arguments.value>
	</cffunction>

	<cffunction name="deleteCustomDataValue" output="false" returntype="void">
		<cfargument name="key" type="string" required="true">
		
		<cfif StructKeyExists(session.stVariablesScope.stCustomData,arguments.key)>
			<cfset StructDelete(session.stVariablesScope.stCustomData,arguments.key)>
		</cfif>
	</cffunction>

	<cffunction name="existsCustomDataValue" output="false" returntype="boolean">
		<cfargument name="key" type="string" required="true">
		
		<cfreturn StructKeyExists(session.stVariablesScope.stCustomData,arguments.key)>
	</cffunction>
	
	<cffunction name="isLoggedIn" output="false" returntype="boolean">
		
		<cfreturn session.stVariablesScope.userloggedin>
		
	</cffunction>

	<cffunction name="dateTimeFormat" output="false" returntype="string">
		<cfargument name="datetime" type="string" required="true">
		<cfargument name="type" type="string" required="false" default="datetime" hint="datetime | date | time">
		
		<cfset var dtDatetime = arguments.datetime>
		
		<cfif isDate(dtDatetime) AND NOT LsIsDate(dtDatetime)>
			<cfset dtDatetime = ParseDateTime(dtDatetime)>
		</cfif>
		<cftry>
			<cfif arguments.type EQ 'datetime'>
				<cfreturn LSDateFormat(dtDatetime) & " " & LSTimeFormat(dtDatetime)>
			<cfelseif arguments.type EQ 'date'>
				<cfreturn LSDateFormat(dtDatetime)>
			<cfelseif arguments.type EQ 'time'>
				<cfreturn LSTimeFormat(dtDatetime)>
			</cfif>
			<cfcatch>
				<cfreturn ''>
			</cfcatch>
		</cftry>
		
	</cffunction>
	
	<cffunction name="checkPermissions" returntype="boolean" output="false">
		<cfargument name="area" type="string" required="true" default="">
		<cfargument name="module" type="string" required="true" default="">
		
		<cfset var bReturn = false>
		<cfset var qPermissionLookup = 0>
		
		<cfif NOT len(trim(arguments.module))>
			<cfset arguments.module = application.lanshock.oApplication.getMyFusebox().thiscircuit>
		</cfif>
		
		<cfif ListFirst(arguments.module,'_') EQ 'c'>
			<cfset arguments.module = right(arguments.module,len(arguments.module)-2)>
		</cfif>
		
		<cfquery dbtype="query" name="qPermissionLookup" maxrows="1">
			SELECT *
			FROM session.stVariablesScope.qPermissions
			WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.module#">
			<cfif arguments.area NEQ '*'>
				AND name IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.area#" list="true">)
			</cfif>
		</cfquery>
		
		<cfif qPermissionLookup.recordcount>
			<cfset bReturn = true>
		</cfif>
		
		<cfreturn bReturn>
	
	</cffunction>

</cfcomponent>