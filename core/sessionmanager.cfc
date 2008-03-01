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
		<cfset variables.iTimeout = 300>
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
			<cfset session.oPreferences = application.lanshock.oFactory.load('lanshock.core.preferences')>
		</cfif>
		
		<!--- check session hijacking --->
		<cfif application.lanshock.settings.security.check_sessionhijack>
			<cfif session.ip_address NEQ cgi.remote_addr AND application.lanshock.oApplication.getMyFusebox().originalCircuit NEQ 'c_general'>
				<cfset sSessionIP = session.ip_address>
				<cfset session = StructNew()>
				<cfloop collection="#cookie#" item="idx">
					<cfcookie name="#idx#" expires="now">
				</cfloop>
				<cflocation url="#application.lanshock.oApplication.getMyFusebox().getMyself()#c_general.error_session_hijack&ip_session=#UrlEncodedFormat(ip_session)#" addtoken="false">
			</cfif>
		</cfif>
		
		<!--- TODO: check in circuit code?
				check if user may access the module --->
		<!--- <cfif application.lanshock.settings.security.check_useraccess_module AND NOT session.userloggedin>
			<cfif StructKeyExists(application.module,application.lanshock.oApplication.getMyFusebox().originalCircuit) AND 
					StructKeyExists(application.module[application.lanshock.oApplication.getMyFusebox().originalCircuit], 'general') AND 
					StructKeyExists(application.module[application.lanshock.oApplication.getMyFusebox().originalCircuit].general, 'reqlogin') AND 
					application.module[application.lanshock.oApplication.getMyFusebox().originalCircuit].general.reqlogin AND 
					application.lanshock.oApplication.getMyFusebox().originalCircuit NEQ 'c_user'>
				<cflocation url="#application.lanshock.oApplication.getMyFusebox().getMyself()#c_general.error_access_denied&#session.urltoken#" addtoken="false">
			</cfif>
		</cfif> --->
		
		<cfset updateSessions()>		
	</cffunction>
	
	<cffunction name="updateSessions" output="false" returntype="void">
		<cfset var sKey = ''>

		<cfset sKey = session.urltoken>
		<cfset variables.stSessions[sKey] = StructNew()>
		<cfset variables.stSessions[sKey].query_string = cgi.query_string>
		<cfset variables.stSessions[sKey].http_user_agent = cgi.http_user_agent>
		<cfset variables.stSessions[sKey].session = session>
		<cfset variables.stSessions[sKey].fusebox = StructNew()>
		<cfset variables.stSessions[sKey].fusebox.circuit = application.lanshock.oApplication.getMyFusebox().originalCircuit>
		<cfset variables.stSessions[sKey].fusebox.action = application.lanshock.oApplication.getMyFusebox().originalFuseaction>
	</cffunction>
	
	<cffunction name="cleanSessions" output="false" returntype="void">

		<cfset var idx = 0>

		<cfloop collection="#variables.stSessions#" item="idx">
			<cfif DateDiff('s',variables.stSessions[idx].session.timestamp, now()) GT variables.iTimeout>
				<cfset StructDelete(variables.stSessions,idx)>
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="getSessions" output="false" returntype="struct">

		<cfreturn variables.stSessions>

	</cffunction>
	
	<cffunction name="getSessionCount" output="false" returntype="numeric">

		<cfreturn StructCount(variables.stSessions)>

	</cffunction>

</cfcomponent>