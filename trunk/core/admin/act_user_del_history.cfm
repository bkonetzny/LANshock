<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetDeletedUser">
	SELECT *
	FROM user_deleted	
	ORDER BY dt_deleted DESC
</cfquery>

<cfsetting enablecfoutputonly="No">