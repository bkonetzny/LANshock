<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/act_setpassword.cfm $
$LastChangedDate: 2006-10-23 00:39:57 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 51 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.password" default="false">

<cfset sConfigFile = application.lanshock.oRuntime.getEnvironment().sStoragePath & 'secure/config/lanshock/config.ini.cfm'>

<cfif attributes.form_submitted AND len(attributes.password)>
	
	<cfset stRuntimeConfig.lanshock.password = attributes.password>
	
	<cfset application.lanshock.oRuntime.setRuntimeConfig(stRuntimeConfig)>

	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login')#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">