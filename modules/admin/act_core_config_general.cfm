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
<cfparam name="attributes.actionstring" default="#application.lanshock.settings.actionstring#">
<cfparam name="attributes.startpage" default="#application.lanshock.settings.startpage#">
<cfparam name="attributes.startpage_type" default="custom">
<cfparam name="attributes.startpage_custom" default="#application.lanshock.settings.startpage#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.appname)) ArrayAppend(aError,"<!--- TODO: $$$ ---> appname");
	</cfscript>

	<cfif NOT ArrayLen(aError)>
		<cfinclude template="act_core_config.pre.inc.cfm">

		<cfset stModuleConfigNew.appname = attributes.appname>
		<cfset stModuleConfigNew.language = attributes.language>
		<cfset stModuleConfigNew.actionstring = attributes.actionstring>
		<cfif attributes.startpage_type EQ 'custom'>
			<cfset stModuleConfigNew.startpage = attributes.startpage_custom>
		<cfelse>
			<cfset stModuleConfigNew.startpage = attributes.startpage>
		</cfif>
		
		<cfinclude template="act_core_config.post.inc.cfm">
	</cfif>
</cfif>

<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<!--- set avaible actionstrings --->
<cfset lActionStrings = "fuseaction,method,do">

<cfsavecontent variable="sSelectList">
<cfoutput>
	<option value=""></option>
	<cfloop collection="#application.module#" item="idx">
		<optgroup label="#application.module[idx].name#">
			<cfif attributes.startpage EQ '#idx#.main'><cfset attributes.startpage_type = 'selected'></cfif>
			<option value="#idx#.main"<cfif attributes.startpage EQ '#idx#.main'> selected</cfif>>#application.module[idx].name#</option>
			<cfif NOT StructIsEmpty(application.module[idx].navigation)>
				<cfloop collection="#application.module[idx].navigation#" item="idx2">
					<cfif attributes.startpage EQ '#idx#.#application.module[idx].navigation[idx2].action#'><cfset attributes.startpage_type = 'selected'></cfif>
					<option value="#idx#.#application.module[idx].navigation[idx2].action#"<cfif attributes.startpage EQ '#idx#.#application.module[idx].navigation[idx2].action#'> selected</cfif>>#idx#.#application.module[idx].navigation[idx2].action#<cfif len(application.module[idx].navigation[idx2].reqstatus)> --- (#application.module[idx].navigation[idx2].reqstatus#)</cfif></option>
				</cfloop>
			</cfif>
		</optgroup>
	</cfloop>
</cfoutput>
</cfsavecontent>

<cfsetting enablecfoutputonly="No">