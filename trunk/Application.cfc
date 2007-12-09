<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/Application.cfc $
$LastChangedDate: 2006-11-09 22:02:06 +0100 (Do, 09 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 80 $
--->

<cfcomponent extends="fusebox5.Application" output="false">
	<cfset this.name = 'lanshock_' & LCase(hash(GetCurrentTemplatePath()))>
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
	<cfset this.clientManagement = false>
	<cfset this.loginStorage = "session">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
	<cfset this.setClientCookies = true>
	<cfset this.setDomainCookies = false>
	<cfset this.scriptProtect = false>
	<!--- optionally set FUSEBOX_* variables --->
	
	<cffunction name="onRequestStart">
		<cfargument name="targetPage" />
		
		<cfinclude template="core/lanshock.runtime.cfm">
		<cfset super.onRequestStart(arguments.targetPage)>
	</cffunction>

</cfcomponent>