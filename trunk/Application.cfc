<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent output="false">

	<cfset this.name = 'lanshock_' & LCase(hash(GetCurrentTemplatePath()))>
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
	<cfset this.clientManagement = false>
	<cfset this.loginStorage = "session">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
	<cfset this.setClientCookies = true>
	<cfset this.setDomainCookies = false>
	<cfset this.scriptProtect = false>

	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfreturn true>
	</cffunction>

	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>

	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="false">
		<cfreturn true>
	</cffunction>

	<cffunction name="onRequest" returnType="void">
		<cfargument name="thePage" type="string" required="false" default=""><!--- cfmx --->
		<cfargument name="targetpage" type="string" required="false" default=""><!--- railo --->
		
		<cfset var sCalledPage = ''>
		
		<cfif len(arguments.thePage)>
			<cfset sCalledPage = arguments.thePage>
		<cfelse>
			<cfset sCalledPage = arguments.targetpage>
		</cfif>
		
		<cfif ListLast(sCalledPage,'/') NEQ 'index.cfm' AND ListLast(sCalledPage,'.') NEQ 'cfc'>
			<cflocation url="index.cfm" addtoken="false">
		</cfif>
		
		<cfinclude template="#sCalledPage#">
	</cffunction>

	<cffunction name="onRequestEnd" returnType="void" output="false">
		<cfargument name="thePage" type="string" required="true">
	</cffunction>

	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
		
		<!--- workaround for "Session is invalid" error --->
		<cfif arguments.exception.message IS "Session is invalid" AND IsDefined("cookie.jsessionid")>
			<cfheader statuscode="302" statustext="Moved Temporarily"/>
			<cfheader name="location" value="/index.cfm"/>
			<cfheader name="Set-Cookie" value="JSESSIONID=;expires=#GetHttpTimeString(DateAdd('d',-1,now()))#;path=/"/>
		</cfif>		
		
	</cffunction>

	<cffunction name="onSessionStart" returnType="void" output="false">
	</cffunction>

	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>

</cfcomponent>