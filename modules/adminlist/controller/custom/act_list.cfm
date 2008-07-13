<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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