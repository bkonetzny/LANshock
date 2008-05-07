<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/session.cfc $
$LastChangedDate: 2006-10-22 23:59:51 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 34 $
--->

<cfcomponent>
	
	<cffunction name="init" output="false" returntype="void">
		<cfset variables.stRuntimeConfig = StructNew()>
		<cfset variables.stEnvironment = StructNew()>
	
		<cfset setVersion()>
		<cfset setEnvironment()>
		
		<cfset request.stVersion = getVersion()>
		<cfset request.lanshock_version = request.stVersion.version>
		<cfset request.lanshock_build = request.stVersion.build>
		<cfset request.lanshock_name = request.stVersion.name>
	</cffunction>
	
	<cffunction name="prepareRequest" output="false" returntype="void">
		
		<cfset request.ProcessTime_Part1 = GetTickCount()>
		<cfset request.content = StructNew()>
		
		<cfset request.stVersion = getVersion()>
		<cfset request.lanshock_version = request.stVersion.version>
		<cfset request.lanshock_build = request.stVersion.build>
		<cfset request.lanshock_name = request.stVersion.name>
		
		<!--- TODO: Remove reference --->
		<cfset getConfig()>
		<cfset request.lanshock = application.lanshock>
		
		<cfset application.lanshock.oSessionmanager.checkSession()>
		
		<cfset SetLocale(session.lang)>
		<cfset request.ProcessTime_Part1 = GetTickCount()>
		
		<cfinvoke component="#application.lanshock.oLanguage#" method="loadProperties" returnvariable="request.content">
			<cfinvokeargument name="base" value="#request.content#">
			<cfinvokeargument name="lang" value="#session.lang#">
			<cfinvokeargument name="file" value="core/_utils/lang.properties">
		</cfinvoke>
		
		<!--- TODO: Remove reference --->
		<cfinvoke component="#application.lanshock.oLanguage#" method="loadProperties" returnvariable="request.content">
			<cfinvokeargument name="base" value="#request.content#">
			<cfinvokeargument name="lang" value="#session.lang#">
			<cfinvokeargument name="file" value="modules/comments/lang.properties">
		</cfinvoke>
		
		<cfinvoke component="#application.lanshock.oLanguage#" method="loadProperties" returnvariable="request.content">
			<cfinvokeargument name="base" value="#request.content#">
			<cfinvokeargument name="lang" value="#session.lang#">
			<cfinvokeargument name="file" value="templates/#application.lanshock.settings.layout.template#/lang.properties">
		</cfinvoke>

	</cffunction>
	
	<cffunction name="getRuntimeConfig" output="false" returntype="struct">
		<cfset var stRuntimeConfigRaw = StructNew()>
		<cfset var sRuntimeConfigFile = application.lanshock.oRuntime.getEnvironment().sStoragePath & 'secure/config/lanshock/config.ini.cfm'>
		<cfset var idxProfileSection = ''>
		<cfset var idxProfileString = ''>
		
		<cfif StructIsEmpty(variables.stRuntimeConfig) AND fileExists(sRuntimeConfigFile)>
		
			<cfset stRuntimeConfigRaw = GetProfileSections(sRuntimeConfigFile)>
			
			<cfloop collection="#stRuntimeConfigRaw#" item="idxProfileSection">
				<cfset variables.stRuntimeConfig[idxProfileSection] = StructNew()>
				<cfloop list="#stRuntimeConfigRaw[idxProfileSection]#" index="idxProfileString">
					<cfset variables.stRuntimeConfig[idxProfileSection][idxProfileString] = GetProfileString(sRuntimeConfigFile,idxProfileSection,idxProfileString)>
				</cfloop>
			</cfloop>
		
		</cfif>
		
		<cfreturn variables.stRuntimeConfig>

	</cffunction>

	<cffunction name="setRuntimeConfig" output="false" returntype="void">
		<cfargument name="stConfig" type="struct" required="true">
		
		<cfset var sRuntimeConfigFile = application.lanshock.oRuntime.getEnvironment().sStoragePath & 'secure/config/lanshock/config.ini.cfm'>
		<cfset var idxProfileSection = ''>
		<cfset var idxProfileString = ''>
		
		<cfloop collection="#arguments.stConfig#" item="idxProfileSection">
			<cfloop collection="#arguments.stConfig[idxProfileSection]#" item="idxProfileString">
				<cfset SetProfileString(sRuntimeConfigFile,idxProfileSection,idxProfileString,arguments.stConfig[idxProfileSection][idxProfileString])>
			</cfloop>
		</cfloop>
		
		<cfset getRuntimeConfig()>
		<cfset setEnvironment()>

	</cffunction>

	<cffunction name="getEnvironment" output="false" returntype="struct">
		
		<cfreturn variables.stEnvironment>

	</cffunction>

	<cffunction name="setEnvironment" output="false" returntype="void">

		<cfset variables.stEnvironment.sBasePath = left(GetDirectoryFromPath(GetCurrentTemplatePath()),len(GetDirectoryFromPath(GetCurrentTemplatePath()))-5)> <!--- 5 = "/core" --->
		<cfset variables.stEnvironment.sStoragePath = variables.stEnvironment.sBasePath & 'storage/'>
		<cfset variables.stEnvironment.sWebPath = listDeleteAt(cgi.script_name, ListLen(cgi.script_name,"/"), "/") & "/">
		<cfif cgi.server_port_secure>
			<cfset variables.stEnvironment.sServerAddress = 'https://'>
		<cfelse>
			<cfset variables.stEnvironment.sServerAddress = 'http://'>
		</cfif>
		<cfset variables.stEnvironment.sServerAddress = variables.stEnvironment.sServerAddress & cgi.server_name>
		<cfif cgi.server_port NEQ '80'>
			<cfset variables.stEnvironment.sServerAddress = variables.stEnvironment.sServerAddress & ':' & cgi.server_port>
		</cfif>
		<cfset variables.stEnvironment.sServerPath = variables.stEnvironment.sServerAddress & variables.stEnvironment.sWebPath>
		<cfset variables.stEnvironment.sComponentPath = 'lanshock.'>
		<cfset variables.stEnvironment.sMapping = '/lanshock/'>
		<cfset variables.stEnvironment.sCrypKey = hash(application.applicationname)>

		<cfset getRuntimeConfig()>
		
		<cfif NOT StructIsEmpty(variables.stRuntimeConfig)>
			<cfset variables.stEnvironment.sDatasource = variables.stRuntimeConfig.lanshock.datasource>
			<cfset variables.stEnvironment.sDatasourceType = variables.stRuntimeConfig.lanshock.datasource_type>
		</cfif>
		
	</cffunction>

	<cffunction name="getConfig" output="false" returntype="void">
		<cfset var oStruct = application.lanshock.oFactory.load('lanshock.core._utils.cf.struct')>
		
		<cfinclude template="mySettings.cfm">
		<cfset oStruct.structMerge(application.lanshock,stConfig)>
	</cffunction>
	
	<cffunction name="setVersion" output="false" returntype="void">
		
		<cfset variables.stVersion = StructNew()>
		<cfset var sXml = ''>
		<cfset var stXml = ''>
		
		<cffile action="read" file="#expandPath('core/version.xml')#" variable="sXml">
		<cfset stXml = xmlParse(sXml)>
		
		<cfset stVersion.name = stXml.lanshock.name.xmltext>
		<cfset stVersion.version = stXml.lanshock.version.xmltext>
		<cfset stVersion.build = stXml.lanshock.build.xmltext>

	</cffunction>
	
	<cffunction name="getVersion" output="false" returntype="struct">
		
		<cfreturn variables.stVersion>

	</cffunction>

</cfcomponent>