<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_core_config_general.cfm $
$LastChangedDate: 2007-07-08 13:01:39 +0200 (So, 08 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 96 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.appname" default="#application.lanshock.settings.appname#">
<cfparam name="attributes.language" default="#application.lanshock.settings.language#">
<cfparam name="attributes.startpage" default="#application.lanshock.settings.startpage#">
<cfparam name="attributes.startpage_type" default="custom">
<cfparam name="attributes.startpage_custom" default="#application.lanshock.settings.startpage#">

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
		
		<cfinclude template="act_core_config.post.inc.cfm">
	</cfif>
</cfif>

<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

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