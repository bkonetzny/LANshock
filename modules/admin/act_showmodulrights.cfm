<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_showmodulrights.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfinvoke component="admin" method="getAdminRights" returnvariable="stSecurity">
	<cfinvokeargument name="userid" value="#attributes.userid#">
</cfinvoke>

<cfset stModule = duplicate(application.module)>

<cfsetting enablecfoutputonly="No">