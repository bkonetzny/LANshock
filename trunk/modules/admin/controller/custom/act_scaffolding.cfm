<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_start.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.bUpdateScaffoldingXml" default="false">

<cfset stScaffolding = StructNew()>

<cfif attributes.bUpdateScaffoldingXml>
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
	<cfset stSettings.lTables = ''>
	
	<cfset oMetaData = CreateObject("component","scaffolder.scaffolder.metadata").init(argumentCollection=stSettings)>
	
	<cfset oMetaData.introspectDB()>
</cfif>

<cfif FileExists(expandPath('./scaffolding/templates/EXT2.0/custom/config.cfm'))>
	<cfinclude template="../../../../scaffolding/templates/EXT2.0/custom/config.cfm">
</cfif>

<cfsetting enablecfoutputonly="No">