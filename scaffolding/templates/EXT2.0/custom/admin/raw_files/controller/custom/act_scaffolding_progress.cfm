<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_start.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.module" default="">

<cfinclude template="../../../../scaffolding/templates/EXT2.0/custom/config.cfm">

<cfif len(attributes.module)>
	<cfset stSettings = StructNew()>
	<cfset stSettings.configFilePath = expandPath('./scaffolding/scaffolding.xml')>
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
	<cfset stSettings.lTables = stScaffolding[attributes.module].lTables>
	
	<cfset oMetaData = CreateObject("component","scaffolder.scaffolder.metadata").init(argumentCollection=stSettings)>
	
	<cfset cftemplate = CreateObject("component","scaffolder.scaffolder.cftemplate").init()>
	<cfset destinationFilePath = expandPath('./scaffolding/generated/lanshock/')>

	<cfif len(stSettings.lTables)>
		<cfset oMetaData.build(cftemplate=cftemplate,destinationFilePath=destinationFilePath,sModule=attributes.module,lTables=stSettings.lTables)>
	<cfelse>
		<cfset oMetaData.build(cftemplate=cftemplate,destinationFilePath=destinationFilePath,sModule=attributes.module)>
	</cfif>
</cfif>

<cfsetting enablecfoutputonly="No">