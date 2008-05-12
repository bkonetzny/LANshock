<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/admin/raw_files/controller/custom/act_core_config_layout.cfm $
$LastChangedDate: 2008-05-12 14:49:49 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 298 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.template" default="#application.lanshock.settings.layout.template#">
<cfparam name="attributes.avatar_mode" default="#application.lanshock.settings.layout.avatar.mode#">

<cfif attributes.form_submitted>
	<cfinclude template="act_core_config.pre.inc.cfm">

	<cfset stModuleConfigNew.settings.layout.template = attributes.template>
	<cfset stModuleConfigNew.settings.layout.avatar.mode = attributes.avatar_mode>
	
	<cfinclude template="act_core_config.post.inc.cfm">
</cfif>

<cfdirectory action="list" directory="#application.lanshock.oRuntime.getEnvironment().sBasePath#templates/" name="qTemplates" sort="name ASC">

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.smileyset" method="getSmileySetList" returnvariable="qSmileySets">

<cfsetting enablecfoutputonly="No">