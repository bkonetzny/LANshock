<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.module" default="">

<cfif len(attributes.module)>
	<cfinvoke component="#application.lanshock.oModules#" method="getModules" returnvariable="stScaffolding">
		<cfinvokeargument name="type" value="installed">
	</cfinvoke>

	<cfinvoke component="#application.lanshock.oFactory.load(sObject='lanshock.core.frameworks.scaffolder',bCache=false)#" method="createConfig"/>

	<cfset stSettings = StructNew()>
	<cfset stSettings.configFilePath = expandPath('./storage/secure/config/scaffolder/scaffolding.xml')>
	<cfset stSettings.datasource = application.lanshock.oRuntime.getEnvironment().sDatasource>
	<cfset stSettings.username = ''>
	<cfset stSettings.password = ''>
	<cfset stSettings.project = ''>
	<cfset stSettings.template = 'EXT2.0'>
	<cfset stSettings.author = ''>
	<cfset stSettings.authorEmail = ''>
	<cfset stSettings.copyright = ''>
	<cfset stSettings.licence = ''>
	<cfset stSettings.version = ''>
	<cfset stSettings.lTables = ListSort(LCase(StructKeyList(stScaffolding[attributes.module].database.tables)),'textnocase')>
	
	<cfset oMetaData = CreateObject("component","scaffolder.scaffolder.metadata").init(argumentCollection=stSettings)>
	
	<cfset cftemplate = CreateObject("component","scaffolder.scaffolder.cftemplate").init()>
	<cfset destinationFilePath = expandPath('./storage/secure/scaffolding/')>

	<cfif len(stSettings.lTables)>
		<cfset oMetaData.build(cftemplate=cftemplate,destinationFilePath=destinationFilePath,sModule=attributes.module,lTables=stSettings.lTables)>
	<cfelse>
		<cfset oMetaData.build(cftemplate=cftemplate,destinationFilePath=destinationFilePath,sModule=attributes.module)>
	</cfif>
</cfif>

<cfsetting enablecfoutputonly="No">