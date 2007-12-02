<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/mySettings.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfinvoke component="team" method="getMemberData" returnvariable="qUserMemberData">
	<cfinvokeargument name="id" value="#request.session.userid#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">