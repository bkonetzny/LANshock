<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/admin/raw_files/controller/custom/act_core_config_profilesettings.cfm $
$LastChangedDate: 2008-05-12 14:49:49 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 298 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">
	
<!--- get config --->
<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.configmanager" method="getConfig" returnvariable="stModuleConfigNew">
	<cfinvokeargument name="module" value="user">
</cfinvoke>

<cfparam name="attributes.registration_active" default="#stModuleConfigNew.registration_active#">
<cfparam name="attributes.edit_personal_data" default="#stModuleConfigNew.userprofile.edit_personal_data#">
<cfparam name="attributes.edit_nickname" default="#stModuleConfigNew.userprofile.edit_nickname#">

<cfif attributes.form_submitted>
	<cfinclude template="act_core_config.pre.inc.cfm">

	<cfset stModuleConfigNew.settings.userprofile.edit_personal_data = attributes.edit_personal_data>
	<cfset stModuleConfigNew.settings.userprofile.edit_nickname = attributes.edit_nickname>
	<cfset stModuleConfigNew.settings.registration_active = attributes.registration_active>
	
	<!--- set config --->
	<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.configmanager" method="setConfig">
		<cfinvokeargument name="module" value="user">
		<cfinvokeargument name="data" value="#stModuleConfigNew#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.core_config&#session.urltoken#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">