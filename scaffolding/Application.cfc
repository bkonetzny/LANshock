<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent output="false">
	<cfset this.name = 'scaffolder'>
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
	<cfset this.clientManagement = false>
	<cfset this.loginStorage = "session">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
	<cfset this.setClientCookies = true>
	<cfset this.setDomainCookies = false>
	<cfset this.scriptProtect = false>
</cfcomponent>