<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/qry_userpassword_change.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.password" default="">
<cfparam name="attributes.userid" default="0">

<cfif len(attributes.password)>

	<cfinvoke component="#request.lanshock.environment.componentpath#core.user.user" method="updateHistory">
		<cfinvokeargument name="userid" value="#attributes.userid#">
		<cfinvokeargument name="status" value="status_password_changed">
	</cfinvoke>
	
	<cfquery datasource="#application.lanshock.environment.datasource#">
		UPDATE user
		SET pwd = <cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(hash(attributes.password))#">
		WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.userid#">
	</cfquery>

</cfif>

<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#attributes.userid#&#session.UrlToken#" addtoken="no">

<cfsetting enablecfoutputonly="No">