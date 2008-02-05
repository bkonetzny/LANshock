<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_core_config_security.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.cron_hashkey" default="#application.lanshock.settings.security.cron_hashkey#">
<cfparam name="attributes.check_sessionhijack" default="#application.lanshock.settings.security.check_sessionhijack#">
<cfparam name="attributes.check_useraccess_module" default="#application.lanshock.settings.security.check_useraccess_module#">

<cfif attributes.form_submitted>
	<cfinclude template="act_core_config.pre.inc.cfm">

	<cfif len(attributes.cron_hashkey)>
		<cfset stModuleConfigNew.settings.security.cron_hashkey = hash(attributes.cron_hashkey)>
	</cfif>
	<cfset stModuleConfigNew.settings.security.check_sessionhijack = attributes.check_sessionhijack>
	<cfset stModuleConfigNew.settings.security.check_useraccess_module = attributes.check_useraccess_module>
	
	<cfinclude template="act_core_config.post.inc.cfm">
</cfif>

<cfsetting enablecfoutputonly="No">