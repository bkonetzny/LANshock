<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_user_del_history.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfquery datasource="#application.lanshock.environment.datasource#" name="qGetDeletedUser">
	SELECT *
	FROM user_deleted	
	ORDER BY dt_deleted DESC
</cfquery>

<cfsetting enablecfoutputonly="No">