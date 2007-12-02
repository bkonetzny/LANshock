<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/qry_admin_del.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->
 
<cfquery datasource="#application.lanshock.environment.datasource#">
	DELETE FROM admin
	WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.admin_id#" maxlength="11">
</cfquery>

<cflocation url="#myself##myfusebox.thiscircuit#.admin&#request.session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">