<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.bUpdateScaffoldingXml" default="false">
<cfparam name="attributes.sDeployModule" default="">
<cfparam name="attributes.bReload" default="false">

<cfinvoke component="#application.lanshock.oModules#" method="getModules" returnvariable="stScaffolding">
	<cfinvokeargument name="type" value="installed">
</cfinvoke>

<cfif attributes.bUpdateScaffoldingXml>
	<cfinvoke component="#application.lanshock.oFactory.load(sObject='lanshock.core.frameworks.scaffolder',bCache=false)#" method="createConfig"/>
	<cfset session.oUser.setCustomDataValue('notification_sHeadline','Updated scaffolding definitions.')>
	<cfset session.oUser.setCustomDataValue('notification_sType','info')>
</cfif>

<cfif len(attributes.sDeployModule)>
	<cfset directoryCopy(expandPath('storage/secure/scaffolding/modules/#attributes.sDeployModule#'),expandPath('modules/#attributes.sDeployModule#'))>
	<cfif attributes.bReload>
		<cfset application.lanshock.oApplication.reloadApplication()>
	</cfif>
	<cfset session.oUser.setCustomDataValue('notification_sHeadline','Deployed module #attributes.sDeployModule#.')>
	<cfset session.oUser.setCustomDataValue('notification_sType','success')>
</cfif>

<cfsetting enablecfoutputonly="No">