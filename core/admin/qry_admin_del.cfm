<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->
 
<cfquery datasource="#application.lanshock.environment.datasource#">
	DELETE FROM admin
	WHERE id = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#attributes.admin_id#" maxlength="11">
</cfquery>

<cflocation url="#myself##myfusebox.thiscircuit#.admin&#request.session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">