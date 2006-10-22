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

<cfparam name="attributes.show_plain_error" default="#application.lanshock.settings.debug.show_plain_error#">
<cfparam name="attributes.mail_error" default="#application.lanshock.settings.debug.mail_error#">
<cfparam name="attributes.error_email" default="#application.lanshock.settings.debug.error_email#">

<cfif attributes.form_submitted>
	<cfinclude template="act_core_config.pre.inc.cfm">

	<cfset stModuleConfigNew.debug.show_plain_error = attributes.show_plain_error>
	<cfset stModuleConfigNew.debug.mail_error = attributes.mail_error>
	<cfset stModuleConfigNew.debug.error_email = attributes.error_email>
	
	<cfinclude template="act_core_config.post.inc.cfm">
</cfif>

<cfsetting enablecfoutputonly="No">