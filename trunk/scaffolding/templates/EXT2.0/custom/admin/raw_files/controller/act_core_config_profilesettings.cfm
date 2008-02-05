<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_core_config_profilesettings.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">
	
<!--- get config --->
<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="getConfig" returnvariable="stModuleConfigNew">
	<cfinvokeargument name="module" value="#request.lanshock.settings.modulePrefix.core#user">
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
	<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="setConfig">
		<cfinvokeargument name="module" value="#request.lanshock.settings.modulePrefix.core#user">
		<cfinvokeargument name="data" value="#stModuleConfigNew#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.core_config&#session.urltoken#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">