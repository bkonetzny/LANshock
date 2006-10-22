<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="admin" method="getAdminRights" returnvariable="stSecurity">
	<cfinvokeargument name="userid" value="#attributes.userid#">
</cfinvoke>

<cfset stModule = duplicate(application.module)>

<cfsetting enablecfoutputonly="No">