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
	
		<cfset variables.stSessions = StructNew()>
		<cfset variables.iTimeout = 1200>
		<cfset variables.iSessions = 0>
	
	</cffunction>
	
	<cffunction name="checkSession" output="false" returntype="void">
		
		<cfset var idx = 0>
		<cfset var sSessionIP = ''>
		
		<cfif NOT StructKeyExists(session,'oUser')>
			<cfset application.lanshock.oLogger.writeLog('core.sessionmanager','Started new session | QueryString: "#cgi.query_string#" | Referer: "#cgi.http_referer#" | UserAgent: "#cgi.http_user_agent#"')>
			<cfset session.dtSessionCreated = now()>
			<cfset session.oUser = application.lanshock.oFactory.load('lanshock.core.session')>
			<cfset session.oUser.init()>
			<!--- <cfset session.oPreferences = application.lanshock.oFactory.load('lanshock.core.preferences')> --->
			<cfset session.isBot = isBot(cgi.http_user_agent)>
			<cfif isDefined("cookie.email") AND isDefined("cookie.password")>
				<cflocation url="#application.lanshock.oHelper.buildUrl('user.login')#" addtoken="false">
			</cfif>
		</cfif>
		
		<cfset session.dtSessionLastCall = now()>
		
		<!--- check session hijacking --->
		<cfif session.ip_address NEQ cgi.remote_addr AND application.lanshock.oApplication.getMyFusebox().originalCircuit NEQ 'general'>
			<cfset application.lanshock.oLogger.writeLog('core.sessionmanager','Session hijacking detected | Session-IP: "#session.ip_address#" | CGI-IP: "#cgi.remote_addr#" | UserAgent: "#cgi.http_user_agent#"','error')>
			<cfset sSessionIP = session.ip_address>
			<cfset structClear(session)>
			<cfloop collection="#cookie#" item="idx">
				<cfcookie name="#idx#" expires="now">
			</cfloop>
			<cflocation url="#application.lanshock.oHelper.buildUrl('general.error_session_hijack&ip_session=#sSessionIP#')#" addtoken="false">
		</cfif>
		
		<cfparam name="session.isBot" default="false">
		
		<cfif NOT session.isBot>
			<cfset updateSessions()>
		<cfelse>
			<cfset application.lanshock.oLogger.writeLog('core.sessionmanager.bots','Tracked Bot / Crawler | UserAgent: "#cgi.http_user_agent#"')>
		</cfif>
		<cfset cleanSessions()>
	</cffunction>
	
	<cffunction name="isBot" output="false" returntype="boolean">
		<cfargument name="sUserAgent" type="string" required="true">
		<cfset var bReturn = false>

		<cfinclude template="_utils/bots.cfm">
		
		<cfreturn bReturn>
	</cffunction>
	
	<cffunction name="updateSessions" output="false" returntype="void">
		<cfset var sKey = ''>

		<cfset sKey = session.urltoken>
		<cfset variables.stSessions[sKey] = StructNew()>
		<cfset variables.stSessions[sKey].query_string = cgi.query_string>
		<cfset variables.stSessions[sKey].http_user_agent = cgi.http_user_agent>
		<cfset variables.stSessions[sKey].session = StructNew()>
		<cfset variables.stSessions[sKey].session.dtSessionCreated = session.dtSessionCreated>
		<cfset variables.stSessions[sKey].session.dtSessionLastCall = session.dtSessionLastCall>
		<cfset variables.stSessions[sKey].session.stUser = session.oUser.getData()>
		<cfset variables.stSessions[sKey].fusebox = StructNew()>
		<cfset variables.stSessions[sKey].fusebox.circuit = application.lanshock.oApplication.getMyFusebox().originalCircuit>
		<cfset variables.stSessions[sKey].fusebox.action = application.lanshock.oApplication.getMyFusebox().originalFuseaction>
	</cffunction>
	
	<cffunction name="cleanSessions" output="false" returntype="void">

		<cfset var idx = 0>

		<cfloop collection="#variables.stSessions#" item="idx">
			<cfif DateDiff('s',variables.stSessions[idx].session.dtSessionLastCall,now()) GTE variables.iTimeout>
				<cfset StructDelete(variables.stSessions,idx)>
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="getSessions" output="false" returntype="struct">
		
		<cfset cleanSessions()>
		<cfreturn variables.stSessions>

	</cffunction>
	
	<cffunction name="getSessionCount" output="false" returntype="numeric">

		<cfset cleanSessions()>
		<cfreturn StructCount(variables.stSessions)>

	</cffunction>

</cfcomponent>