<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/qry_admin_new.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.form_submitted" default="false">

<cfif attributes.form_submitted>

	<cfparam name="attributes.lAdminIDs" default="">

	<cfloop list="#attributes.lAdminIDs#" index="user_id">
		<cfquery datasource="#application.lanshock.environment.datasource#">
			INSERT INTO admin (user)
			VALUES (<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#user_id#" maxlength="11">)
		</cfquery>
	</cfloop>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.admin&#session.UrlToken#" addtoken="false">

</cfif>

<cfquery datasource="#application.lanshock.environment.datasource#" name="qAdmins">
	SELECT user
	FROM admin
</cfquery>

<cfset lAdminIDS = ValueList(qAdmins.user)>

<cfquery datasource="#application.lanshock.environment.datasource#" name="qNonAdmins">
	SELECT id, name
	FROM user
	WHERE id NOT IN(#lAdminIDS#)
	ORDER BY name
</cfquery>

<cfsetting enablecfoutputonly="No">