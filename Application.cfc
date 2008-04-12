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
	
	<cffunction name="onApplicationStart">
		<cfif NOT fileExists(expandPath('fusebox.xml.cfm'))>
			<cffile action="copy" source="#expandPath('storage/secure/config/lanshock/default/fusebox.xml.cfm')#" destination="#expandPath('.')#">
		</cfif>
		<cfset super.onApplicationStart()>
	</cffunction>
	
	<cffunction name="onFuseboxApplicationStart">
		<cfset application.lanshock = StructNew()>
		<cfset application.lanshock.dtAppStart = now()>
		<cfset application.lanshock.oFactory = CreateObject('component','lanshock.core.factory')>
		<cfset application.lanshock.oRuntime = application.lanshock.oFactory.load('lanshock.core.runtime')>
		<cfset application.lanshock.oRuntime.init()>
		<cfset application.lanshock.oCache = application.lanshock.oFactory.load('lanshock.core.cache')>
		<cfset application.lanshock.oCache.init()>
		<cfset application.lanshock.oLogger = application.lanshock.oFactory.load('lanshock.core.logger')>
		<cfset application.lanshock.oConfigmanager = application.lanshock.oFactory.load('lanshock.core.configmanager')>
		<cfset application.lanshock.oApplication = application.lanshock.oFactory.load('lanshock.application')>
		<cfset application.lanshock.oLanguage = application.lanshock.oFactory.load('lanshock.core.language')>
		<cfset application.lanshock.oHelper = application.lanshock.oFactory.load('lanshock.core.helper')>
		<cfset application.lanshock.oRuntime.getConfig()>
		<cfset application.lanshock.oSessionmanager = application.lanshock.oFactory.load('lanshock.core.sessionmanager')>
		<cfset application.lanshock.oSessionmanager.init()>
		<cfset application.lanshock.oModules = application.lanshock.oFactory.load('lanshock.core.modules')>
		<cfset application.lanshock.oModules.init()>
		
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
			<cfif StructKeyExists(application.lanshock,'oLogger')>
				<cftry>
					<cfset application.lanshock.oLogger.writeLog('core.application','Running "reloadApplication" manually')>
					<cfcatch></cfcatch>
				</cftry>
			</cfif>
			<cfset session = StructNew()>
			<cfset reloadApplication()>
			<cfoutput>LANshock reloaded on #LSDateFormat(now())# #LSTimeFormat(now())# in #DateDiff('s',dtRequestStarted,now())# seconds.</cfoutput>
			<cfabort>
		</cfif>
		
		<cfset super.onRequestStart(arguments.targetPage)>
		
		<cfset self = myFusebox.getSelf()>
		<cfset myself = myFusebox.getMyself()>
		<cfset setMyFusebox(myFusebox)>
		
		<cfset application.lanshock.oRuntime.prepareRequest()>
		
		<cfset stImageDir = StructNew()>
		<cfif DirectoryExists(application.lanshock.oRuntime.getEnvironment().sBasePath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general')>
			<cfset stImageDir.general = application.lanshock.oRuntime.getEnvironment().sWebPath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general'>
		<cfelse>
			<cfset stImageDir.general = application.lanshock.oRuntime.getEnvironment().sWebPath & 'core/general/images/_general'>
		</cfif>
		<cfset stImageDir.template = application.lanshock.oRuntime.getEnvironment().sWebPath & 'templates/' & request.lanshock.settings.layout.template & '/images'>
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

		<cfswitch expression="#arguments.exception.type#">
			<cfcase value="fusebox.undefinedCircuit,fusebox.undefinedFuseaction">
				<cftry>
					<cfset sLogMessage = 'Message: "#arguments.exception.message#" | Fuseaction: "#attributes.fuseaction#"'>
					<cfif len(cgi.http_referer)>
						<cfset sLogMessage = sLogMessage & ' | Referer: "#cgi.http_referer#"'>
					</cfif>
					<cfset sLogMessage = sLogMessage & ' | UserAgent: "#cgi.http_user_agent#"'>
					
					<cfif ListFind("m_,c_",left(attributes.fuseaction,2))>
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
				
				<cfheader statuscode="301">
				<cfheader name="Location" value="#application.lanshock.oHelper.buildUrl('general.http404')#">
				<cfabort>
			</cfcase>
			<cfdefaultcase>
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
			</cfdefaultcase>
		</cfswitch>
		
	</cffunction>

</cfcomponent>