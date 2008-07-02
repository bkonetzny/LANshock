<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="writeLog" output="false" returntype="void">
		<cfargument name="type" type="string" required="true">
		<cfargument name="message" type="string" required="true">
		<cfargument name="level" type="string" required="false" default="info" hint="info|warn|error|debug">
		<cfargument name="userid" type="numeric" required="false" default="0">
		
		<!--- <cfset var lLogLevels = "error,warn,info,debug"> --->
		<cfset var lLogLevels = "error,warn">
		
		<cfif arguments.userid EQ 0 AND StructKeyExists(session,'oUser')>
			<cfset arguments.userid = session.oUser.getDataValue('userid')>
		</cfif>
		
		<cfif ListFindNoCase(lLogLevels,arguments.level)>
			<cfset writeDbLog(arguments.type,arguments.message,arguments.level,arguments.userid)>
			<cflock type="exclusive" name="logger.cfc.writelog" timeout="5">
				<cftry>
					<cffile action="append" file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#arguments.type#.log" output="#now()# - #cgi.remote_addr# - #arguments.level# - #arguments.userid# - #arguments.message#" mode="777" addnewline="true">
					<cfcatch><!--- do nothing ---></cfcatch>
				</cftry>
			</cflock>
		</cfif>
		
	</cffunction>

	<cffunction name="writeDbLog" output="false" returntype="void">
		<cfargument name="type" type="string" required="true">
		<cfargument name="message" type="string" required="true">
		<cfargument name="level" type="string" required="false" default="info" hint="info|warn|error|debug">
		<cfargument name="userid" type="numeric" required="false" default="0">
		
		<cftry>
			<cfset var oLog = application.lanshock.oFactory.load('core_logs','reactorRecord')>
			<cfset oLog.setLogname(arguments.type)>
			<cfset oLog.setLevel(arguments.level)>
			<cfset oLog.setData(arguments.message)>
			<cfset oLog.setUserid(arguments.userid)>
			<cfset oLog.setTimestamp(now())>
			<cfset oLog.save()>
			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
		
	</cffunction>

</cfcomponent>