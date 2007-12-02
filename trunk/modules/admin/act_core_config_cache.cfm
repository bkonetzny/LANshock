<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_core_config_cache.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.languagefiles" default="#application.lanshock.settings.cache.languagefiles#">
<cfparam name="attributes.circuitfiles" default="#application.lanshock.settings.cache.circuitfiles#">

<cfif attributes.form_submitted>
	<cfinclude template="act_core_config.pre.inc.cfm">

	<cfset stModuleConfigNew.cache.languagefiles = attributes.languagefiles>
	<cfset stModuleConfigNew.cache.circuitfiles = attributes.circuitfiles>
	
	<cfinclude template="act_core_config.post.inc.cfm">
</cfif>

<cfsetting enablecfoutputonly="No">