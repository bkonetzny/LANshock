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
		<cfset application.lanshock.sStoragePath = ExpandPath('./storage/')>
		<cfset application.lanshock.oFactory = CreateObject('component','lanshock.core.factory')>
		<cfset application.lanshock.oCache = application.lanshock.oFactory.load('lanshock.core.cache')>
		<cfset application.lanshock.oCache.init()>
		<cfset application.lanshock.oLogger = application.lanshock.oFactory.load('lanshock.core.logger')>
		<cfset application.lanshock.oConfigmanager = application.lanshock.oFactory.load('lanshock.core.configmanager')>
		<cfset application.lanshock.oApplication = application.lanshock.oFactory.load('lanshock.application')>
		<cfset application.lanshock.oLanguage = application.lanshock.oFactory.load('lanshock.core.language')>
		<cfset application.lanshock.oHelper = application.lanshock.oFactory.load('lanshock.core.helper')>
		<cfset application.lanshock.oRuntime = application.lanshock.oFactory.load('lanshock.core.runtime')>
		<cfset application.lanshock.oRuntime.init()>
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
		
		<cfif StructKeyExists(attributes,'reinitapp') AND attributes.reinitapp>
			<cfset application.lanshock.oLogger.writeLog('core.application','Running "reloadApplication" manually')>
			<cfset session = StructNew()>
			<cfset reloadApplication()>
			<cfoutput>LANshock init done! (#now()#)</cfoutput>
			<cfabort>
		</cfif>
		
		<cfset super.onRequestStart(arguments.targetPage)>
		
		<cfset self = myFusebox.getSelf()>
		<cfset myself = myFusebox.getMyself()>
		<cfset setMyFusebox(myFusebox)>
		
		<cfset application.lanshock.oRuntime.prepareRequest()>
		
		<cfset stImageDir = StructNew()>
		<cfif DirectoryExists(request.lanshock.environment.abspath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general')>
			<cfset stImageDir.general = request.lanshock.environment.webpath & 'templates/' & request.lanshock.settings.layout.template & '/images/_general'>
		<cfelse>
			<cfset stImageDir.general = request.lanshock.environment.webpath & 'core/general/images/_general'>
		</cfif>
		<cfset stImageDir.template = request.lanshock.environment.webpath & 'templates/' & request.lanshock.settings.layout.template & '/images'>
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
	
	<cffunction name="setMyFusebox" returntype="struct">
		<cfargument name="myfusebox" type="struct" required="true">
		<cfset request.myFusebox = arguments.myfusebox>
	</cffunction>
	
	<cffunction name="onError" returntype="struct">
		<cfargument name="exception">

		<cfswitch expression="#arguments.exception.type#">
			<cfcase value="fusebox.undefinedCircuit,fusebox.undefinedFuseaction">
				<cftry>
					<cfset application.lanshock.oLogger.writeLog('core.error','Type: "#arguments.exception.type#" | Message: "#arguments.exception.message#" | Fuseaction: "#attributes.fuseaction#" | Referer: "#cgi.http_referer#" | UserAgent: "#cgi.http_user_agent#"','error')>
					<cfcatch></cfcatch>
				</cftry>
				<cflocation url="#application.lanshock.oHelper.buildUrl('c_general.error&type=#UrlEncodedFormat(arguments.exception.type)#&message=#UrlEncodedFormat(arguments.exception.message)#')#" addtoken="false">
			</cfcase>
			<cfdefaultcase>
				<cftry>
					<cfset application.lanshock.oLogger.writeLog('core.error','Type: "#arguments.exception.type#" | Message: "#arguments.exception.message#" | Detail: "#arguments.exception.detail#"','error')>
					<cfcatch></cfcatch>
				</cftry>
				<cfinclude template="core/_errorhandler.cfm">
			</cfdefaultcase>
		</cfswitch>
		
	</cffunction>

</cfcomponent>