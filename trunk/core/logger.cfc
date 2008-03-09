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
		<cfset var lLogLevels = "info,warn,error">
		
		<cfif ListFindNoCase(lLogLevels,arguments.level)>
			<cffile action="append" file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#arguments.type#.log" output="#now()# - #cgi.remote_addr# - #arguments.level# - #arguments.message#" mode="777" addnewline="true">
		</cfif>
		
	</cffunction>

</cfcomponent>