<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.template" default="#application.lanshock.settings.layout.template#">
<cfparam name="attributes.smileyset" default="#application.lanshock.settings.layout.smileyset#">
<cfparam name="attributes.escapehtml" default="#application.lanshock.settings.layout.converttext.escapehtml#">
<cfparam name="attributes.pseudocode" default="#application.lanshock.settings.layout.converttext.pseudocode#">
<cfparam name="attributes.avatar_mode" default="#application.lanshock.settings.layout.avatar.mode#">
<cfparam name="attributes.avatar_height" default="#application.lanshock.settings.layout.avatar.height#">
<cfparam name="attributes.avatar_width" default="#application.lanshock.settings.layout.avatar.width#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT isNumeric(attributes.avatar_height)) ArrayAppend(aError,"<!--- TODO: $$$ ---> avatar_height");
		if(NOT isNumeric(attributes.avatar_width)) ArrayAppend(aError,"<!--- TODO: $$$ ---> avatar_width");
	</cfscript>

	<cfif NOT ArrayLen(aError)>
		<cfinclude template="act_core_config.pre.inc.cfm">
	
		<cfset stModuleConfigNew.settings.layout.template = attributes.template>
		<cfset stModuleConfigNew.settings.layout.smileyset = attributes.smileyset>
		<cfset stModuleConfigNew.settings.layout.converttext.escapehtml = attributes.escapehtml>
		<cfset stModuleConfigNew.settings.layout.converttext.pseudocode = attributes.pseudocode>
		<cfset stModuleConfigNew.settings.layout.avatar.mode = attributes.avatar_mode>
		<cfset stModuleConfigNew.settings.layout.avatar.height = attributes.avatar_height>
		<cfset stModuleConfigNew.settings.layout.avatar.width = attributes.avatar_width>
		
		<cfinclude template="act_core_config.post.inc.cfm">
	</cfif>
</cfif>

<cfdirectory action="LIST" directory="#application.lanshock.oRuntime.getEnvironment().sBasePath#templates/" name="qTemplates" sort="name ASC">

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.smileyset" method="getSmileySetList" returnvariable="qSmileySets">

<cfsetting enablecfoutputonly="No">