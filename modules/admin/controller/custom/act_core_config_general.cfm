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

<cfparam name="application.lanshock.settings.google_maps_key" default="">

<cfparam name="attributes.appname" default="#application.lanshock.settings.appname#">
<cfparam name="attributes.language" default="#application.lanshock.settings.language#">
<cfparam name="attributes.startpage" default="#application.lanshock.settings.startpage#">
<cfparam name="attributes.startpage_type" default="custom">
<cfparam name="attributes.startpage_custom" default="#application.lanshock.settings.startpage#">
<cfparam name="attributes.google_maps_key" default="#application.lanshock.settings.google_maps_key#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.appname)) ArrayAppend(aError,"<!--- TODO: $$$ ---> appname");
	</cfscript>

	<cfif NOT ArrayLen(aError)>
		<cfinclude template="act_core_config.pre.inc.cfm">

		<cfset stModuleConfigNew.settings.appname = attributes.appname>
		<cfset stModuleConfigNew.settings.language = attributes.language>
		<cfif attributes.startpage_type EQ 'custom'>
			<cfset stModuleConfigNew.settings.startpage = attributes.startpage_custom>
		<cfelse>
			<cfset stModuleConfigNew.settings.startpage = attributes.startpage>
		</cfif>
		<cfset stModuleConfigNew.settings.google_maps_key = attributes.google_maps_key>
		
		<cfinclude template="act_core_config.post.inc.cfm">
	</cfif>
</cfif>

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<!--- set avaible actionstrings --->
<cfset lActionStrings = "fuseaction,method,do">
<cfset qNavigation = application.lanshock.oModules.getNavigation(lang=session.lang)>

<cfsavecontent variable="sSelectList">
<cfoutput>
	<option value=""></option>
	<cfoutput query="qNavigation" group="module">
		<optgroup label="#qNavigation.module#">
			<cfoutput>
			<option value="#qNavigation.module#.#qNavigation.action#"<cfif attributes.startpage EQ "#qNavigation.module#.#qNavigation.action#"> selected="selected"<cfset attributes.startpage_type = 'selected'></cfif>>#qNavigation.module#: #qNavigation.label#</option>
			</cfoutput>
		</optgroup>
	</cfoutput>
</cfoutput>
</cfsavecontent>

<cfsetting enablecfoutputonly="No">