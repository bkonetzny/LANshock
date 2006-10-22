<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="team" method="getMemberData" returnvariable="qUserMemberData">
	<cfinvokeargument name="id" value="#request.session.userid#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">