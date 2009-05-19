<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent extends="fusebox5.Application" output="false">
	<cfset this.name = 'lanshock_' & LCase(hash(GetCurrentTemplatePath()))>
	<cfset this.applicationTimeout = createTimeSpan(1,0,0,0)>
	<cfset this.clientManagement = false>
	<cfset this.loginStorage = "session">
	<cfset this.sessionManagement = true>
	<cfset this.sessionTimeout = createTimeSpan(0,0,20,0)>
	<cfset this.setClientCookies = true>
	<cfset this.setDomainCookies = false>
	<cfset this.scriptProtect = false>
	<cfset this.mappings['lanshock'] = expandPath('.')>
	<cfset this.mappings['reactor'] = expandPath('framework/reactor/')>
	<cfset this.mappings['fusebox5'] = expandPath('fusebox5/')>
	<cfset this.mappings['scaffolder'] = expandPath('scaffolding/')>
	
	<cffunction name="onApplicationStart">
		<cfif NOT fileExists(expandPath('fusebox.xml.cfm'))>
			<cffile action="copy" source="#expandPath('storage/secure/config/lanshock/default/fusebox.xml.cfm')#" destination="#expandPath('.')#">
		</cfif>
		<cfset super.onApplicationStart()>
	</cffunction>
	
	<cffunction name="onFuseboxApplicationStart">
		<cfset application.lanshock = StructNew()>
		<cfset application.lanshock.dtAppStart = now()>
		<cfset application.lanshock.bInitPhase = true>
		<cfset application.lanshock.oFactory = CreateObject('component','lanshock.core.factory')>
		<cfset application.lanshock.oRequest = application.lanshock.oFactory.load('lanshock.core.request')>
		<cfset application.lanshock.oRuntime = application.lanshock.oFactory.load('lanshock.core.runtime')>
		<cfset application.lanshock.oRuntime.init()>
		<cfset application.lanshock.oCache = application.lanshock.oFactory.load('lanshock.core.cache')>
		<cfset application.lanshock.oCache.init()>
		<cfset application.lanshock.oLogger = application.lanshock.oFactory.load('lanshock.core.logger')>
		<cfset application.lanshock.oApplication = this>
		<cfset application.lanshock.oLanguage = application.lanshock.oFactory.load('lanshock.core.language')>
		<cfset application.lanshock.oHelper = application.lanshock.oFactory.load('lanshock.core.helper')>
		<cfset application.lanshock.oRuntime.getConfig()>
		<cfset application.lanshock.oSessionmanager = application.lanshock.oFactory.load('lanshock.core.sessionmanager')>
		<cfset application.lanshock.oSessionmanager.init()>
		<cfset application.lanshock.oModules = application.lanshock.oFactory.load('lanshock.core.modules')>
		<cfset application.lanshock.oModules.init()>
		<cfset application.lanshock.bInitPhase = false>
		
		<cfset application.lanshock.oLogger.writeLog('core.application','Running "onFuseboxApplicationStart"')>
	</cffunction>
	
	<cffunction name="onRequestStart">
		<cfargument name="targetPage">

		<cfprocessingdirective pageencoding="utf-8"/>
		<cfcontent type="text/html; charset=utf-8">
		
		<cfset setEncoding("url", "utf-8")>
		<cfset setEncoding("form", "utf-8")>
		
		<cfif StructKeyExists(attributes,'reinitapp') AND isBoolean(attributes.reinitapp) AND attributes.reinitapp>
			<cfset dtRequestStarted = now()>
			<cfif StructKeyExists(application,'lanshock') AND StructKeyExists(application.lanshock,'oLogger')>
				<cftry>
					<cfset application.lanshock.oLogger.writeLog('core.application','Running "reloadApplication" manually | Referer: "#cgi.http_referer#" | UserAgent: "#cgi.http_user_agent#"','warn')>
					<cfcatch></cfcatch>
				</cftry>
			</cfif>
			<cfset session = StructNew()>
			<cfset reloadApplication()>
			<cfoutput>LANshock reloaded on #LSDateFormat(now())# #LSTimeFormat(now())# in #DateDiff('s',dtRequestStarted,now())# seconds.</cfoutput>
			<cfabort>
		<cfelseif NOT isDefined("application.lanshock.bInitPhase") OR application.lanshock.bInitPhase>
			<cfoutput>LANshock is reloading<cfif isDefined("application.lanshock.dtAppStart")> since #LSDateFormat(application.lanshock.dtAppStart)#  #LSTimeFormat(application.lanshock.dtAppStart)#</cfif>.</cfoutput>
			<cfabort>
		</cfif>
		
		<cfset super.onRequestStart(arguments.targetPage)>
		
		<cfset self = myFusebox.getSelf()>
		<cfset myself = myFusebox.getMyself()>
		<cfset setMyFusebox(myFusebox)>
		
		<cfset application.lanshock.oRuntime.prepareRequest()>
		<cfset application.lanshock.oRequest.init()>
		
		<cfset stImageDir = StructNew()>
		<cfif DirectoryExists(application.lanshock.oRuntime.getEnvironment().sBasePath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general')>
			<cfset stImageDir.general = application.lanshock.oRuntime.getEnvironment().sWebPath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general'>
		<cfelse>
			<cfset stImageDir.general = application.lanshock.oRuntime.getEnvironment().sWebPath & 'core/general/images/_general'>
		</cfif>
		<cfset stImageDir.template = application.lanshock.oRuntime.getEnvironment().sWebPath & 'templates/' & request.lanshock.settings.layout.template & '/images'>
	</cffunction>

	<cffunction name="onRequestEnd">
		<cfif isDefined("session.isBot") AND session.isBot>
			<cfset onSessionEnd()>
		</cfif>
	</cffunction>

	<cffunction name="onSessionEnd">
		<cfset super.onSessionEnd()>
		<cfset StructClear(session)>
	</cffunction>
	
	<cffunction name="reloadApplication">
		<cfset StructDelete(application,'lanshock')>
		<cfset StructDelete(application,variables.FUSEBOX_APPLICATION_KEY)>
		<cfset onApplicationStart()>
	</cffunction>
	
	<cffunction name="getMyFusebox" returntype="struct">
		<cfif NOT StructKeyExists(request,'myFusebox')>
			<cfset request.myFusebox = createObject("component","fusebox5.myFusebox").init(variables.FUSEBOX_APPLICATION_KEY,variables.attributes,variables) />
		</cfif>
		<cfreturn request.myFusebox>
	</cffunction>
	
	<cffunction name="setMyFusebox">
		<cfargument name="myfusebox" type="struct" required="true">
		<cfset request.myFusebox = arguments.myfusebox>
	</cffunction>
	
	<cffunction name="onError">
		<cfargument name="exception">
		
		<cfset var sRelocation = ''>
		<cfset var sLogMessage = ''>

		<cfset application.lanshock.bInitPhase = false>

		<cfif ListFindNoCase("fusebox.undefinedCircuit,fusebox.undefinedFuseaction",arguments.exception.type)>
			<cftry>
				<cfset sLogMessage = 'Message: "#arguments.exception.message#" | Fuseaction: "#attributes.fuseaction#"'>
				<cfif len(cgi.http_referer)>
					<cfset sLogMessage = sLogMessage & ' | Referer: "#cgi.http_referer#"'>
				</cfif>
				<cfset sLogMessage = sLogMessage & ' | UserAgent: "#cgi.http_user_agent#"'>
				
				<cfif attributes.fuseaction NEQ 'general.http404' AND ListFind("m_,c_",left(attributes.fuseaction,2))>
					<cfset sLogMessage = 'Type: "#arguments.exception.type#" - relocation | ' & sLogMessage>
					<cfset application.lanshock.oLogger.writeLog('core.error',sLogMessage,'warn')>
					<cfset sRelocation = cgi.query_string>
					<cfset sRelocation = replaceNoCase(sRelocation,'fuseaction=m_','','ONE')>
					<cfset sRelocation = replaceNoCase(sRelocation,'fuseaction=c_','','ONE')>
					
					<cfheader statuscode="301" statustext="Moved Permanently">
					<cfheader name="Location" value="#application.lanshock.oHelper.buildUrl('#sRelocation#')#">
					<cfabort>
				</cfif>
				<cfset sLogMessage = 'Type: "#arguments.exception.type#" | ' & sLogMessage>
				<cfset application.lanshock.oLogger.writeLog('core.error',sLogMessage,'error')>
				<cfcatch></cfcatch>
			</cftry>
			
			<cfif attributes.fuseaction NEQ 'general.http404'>
				<cfheader statuscode="301">
				<cfheader name="Location" value="#application.lanshock.oHelper.buildUrl('general.http404')#">
				<cfabort>
			</cfif>
		</cfif>
		
		<cftry>
			<cfset sLogMessage = 'Type: "#arguments.exception.type#" | Message: "#arguments.exception.message#" | Detail: "#arguments.exception.detail#"'>
			<cfif isDefined(attributes.fuseaction)>
				<cfset sLogMessage = sLogMessage & ' | Fuseaction: "#attributes.fuseaction#"'>
			</cfif>
			<cfif len(cgi.query_string)>
				<cfset sLogMessage = sLogMessage & ' | QueryString: "#cgi.query_string#"'>
			</cfif>
			<cfif len(cgi.http_referer)>
				<cfset sLogMessage = sLogMessage & ' | Referer: "#cgi.http_referer#"'>
			</cfif>
			<cfset sLogMessage = sLogMessage & ' | UserAgent: "#cgi.http_user_agent#"'>
			
			<cfset application.lanshock.oLogger.writeLog('core.error',sLogMessage,'error')>
			<cfcatch></cfcatch>
		</cftry>
		<cfinclude template="core/_errorhandler.cfm">
		
	</cffunction>

</cfcomponent>