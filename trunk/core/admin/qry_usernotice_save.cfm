<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.notice" default="">
<cfparam name="attributes.userid" default="0">

<cfinvoke component="#request.lanshock.environment.componentpath#core.user.user" method="updateHistory">
	<cfinvokeargument name="userid" value="#attributes.userid#">
	<cfinvokeargument name="status" value="status_notice_changed">
</cfinvoke>

<cfquery datasource="#application.lanshock.environment.datasource#">
	UPDATE user
	SET notice = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.notice#">
	WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.userid#">
</cfquery>

<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#attributes.userid#&#request.session.UrlToken#" addtoken="no">

<cfsetting enablecfoutputonly="No">