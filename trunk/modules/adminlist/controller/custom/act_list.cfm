<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_login_validation.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "name|ASC">
<cfset stFilter.stJoins.core_security_users_roles_rel = "role_id">
<cfset stFilter.stFields['core_security_users_roles_rel|role_id'] = StructNew()>
<cfset stFilter.stFields['core_security_users_roles_rel|role_id'].mode = 'isEqual'>
<cfset stFilter.stFields['core_security_users_roles_rel|role_id'].value = 1>

<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getRecords" returnvariable="qUsers">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">