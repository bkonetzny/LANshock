<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfquery datasource="#request.lanshock.environment.datasource#" name="qUserLanguageRoles">
	SELECT * FROM developertools_languagefiles_roles
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.session.userid#">
</cfquery>

<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<cfsetting enablecfoutputonly="No">