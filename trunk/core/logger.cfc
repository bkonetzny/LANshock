<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/session.cfc $
$LastChangedDate: 2006-10-22 23:59:51 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 34 $
--->

<cfcomponent>

	<cffunction name="writeLog" output="false" returntype="void">
		<cfargument name="type" type="string" required="true">
		<cfargument name="message" type="string" required="true">
		<cfargument name="level" type="string" required="false" default="info" hint="info|warn|error|debug">
		
		<!--- <cfset var lLogLevels = "info,warn,error,debug"> --->
		<cfset var lLogLevels = "warn,error">
		
		<cfif ListFindNoCase(lLogLevels,arguments.level)>
			<cfset writeDbLog(arguments.type,arguments.message,arguments.level)>
			<cflock type="exclusive" name="logger.cfc.writelog" timeout="5">
				<cffile action="append" file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#arguments.type#.log" output="#now()# - #cgi.remote_addr# - #arguments.level# - #arguments.message#" mode="777" addnewline="true">
			</cflock>
		</cfif>
		
	</cffunction>

	<cffunction name="writeDbLog" output="false" returntype="void">
		<cfargument name="type" type="string" required="true">
		<cfargument name="message" type="string" required="true">
		<cfargument name="level" type="string" required="false" default="info" hint="info|warn|error|debug">
		
		<cftry>
			<cfset var oLog = application.lanshock.oFactory.load('core_logs','reactorRecord')>
			<cfset oLog.setLogname(arguments.type)>
			<cfset oLog.setLevel(arguments.level)>
			<cfset oLog.setData(arguments.message)>
			<cfset oLog.setTimestamp(now())>
			<cfset oLog.save()>
			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
		
	</cffunction>

</cfcomponent>