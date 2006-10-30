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
<cfparam name="attributes.language" default="">
<cfparam name="attributes.user_id" default="">
<cfparam name="attributes.delete" default="false">

<cfif attributes.form_submitted OR attributes.delete>
	<cfquery datasource="#request.lanshock.environment.datasource#">
		DELETE FROM developertools_languagefiles_roles
		WHERE language = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.language#">
		AND user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.user_id#">
	</cfquery>
	<cfif NOT attributes.delete>
		<cfquery datasource="#request.lanshock.environment.datasource#">
			INSERT INTO developertools_languagefiles_roles (language,user_id)
			VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.language#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.user_id#">)
		</cfquery>
	</cfif>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfquery datasource="#request.lanshock.environment.datasource#" name="qGetLanguageRoles">
	SELECT * FROM developertools_languagefiles_roles
	WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.session.userid#">
</cfquery>

<cfinvoke component="#application.lanshock.environment.componentpath#core.user.user" method="getUser" returnvariable="qUsers">

<cfquery dbtype="query" name="qUsers">
	SELECT * FROM qUsers
	ORDER BY name
</cfquery>

<cfsetting enablecfoutputonly="No">