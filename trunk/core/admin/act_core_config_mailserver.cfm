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

<cfparam name="attributes.server" default="#application.lanshock.settings.mailserver.server#">
<cfparam name="attributes.port" default="#application.lanshock.settings.mailserver.port#">
<cfparam name="attributes.username" default="#application.lanshock.settings.mailserver.username#">
<cfparam name="attributes.password" default="#application.lanshock.settings.mailserver.password#">
<cfparam name="attributes.from" default="#application.lanshock.settings.mailserver.from#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT len(attributes.server)) ArrayAppend(aError,"<!--- TODO: $$$ ---> server");
		if(NOT isNumeric(attributes.port)) ArrayAppend(aError,"<!--- TODO: $$$ ---> port");
		if(NOT len(attributes.username)) ArrayAppend(aError,"<!--- TODO: $$$ ---> username");
		if(NOT len(attributes.password)) ArrayAppend(aError,"<!--- TODO: $$$ ---> password");
		if(NOT len(attributes.from)) ArrayAppend(aError,"<!--- TODO: $$$ ---> from");
	</cfscript>

	<cfif NOT ArrayLen(aError)>
		<cfinclude template="act_core_config.pre.inc.cfm">

		<cfset stModuleConfigNew.mailserver.server = attributes.server>
		<cfset stModuleConfigNew.mailserver.port = attributes.port>
		<cfset stModuleConfigNew.mailserver.username = attributes.username>
		<cfset stModuleConfigNew.mailserver.password = attributes.password>
		<cfset stModuleConfigNew.mailserver.from = attributes.from>
		
		<cfinclude template="act_core_config.post.inc.cfm">
	</cfif>
</cfif>

<cfsetting enablecfoutputonly="No">