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

<cfparam name="attributes.type" default="#application.lanshock.settings.sessionmanagement.type#">
<cfparam name="attributes.timeout" default="#application.lanshock.settings.sessionmanagement.timeout#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT isNumeric(attributes.timeout)) ArrayAppend(aError,"<!--- TODO: $$$ ---> timeout");
	</cfscript>

	<cfif NOT ArrayLen(aError)>
		<cfinclude template="act_core_config.pre.inc.cfm">

		<cfset stModuleConfigNew.sessionmanagement.type = attributes.type>
		<cfset stModuleConfigNew.sessionmanagement.timeout = attributes.timeout>
		
		<cfinclude template="act_core_config.post.inc.cfm">
	</cfif>
</cfif>

<cfsetting enablecfoutputonly="No">