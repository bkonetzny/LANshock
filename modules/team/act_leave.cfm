<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/act_leave.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfif NOT isNumeric(qUserMemberData.team_id)>
	<cflocation url="#myself##myfusebox.thiscircuit#.list&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfinvoke component="team" method="setTeamMember">
	<cfinvokeargument name="team_id" value="#qUserMemberData.team_id#">
	<cfinvokeargument name="user_id" value="#request.session.userid#">
	<cfinvokeargument name="status" value="delete">
	<cfinvokeargument name="rights" value="">
</cfinvoke>

<cflocation url="#myself##myfusebox.thiscircuit#.details&id=#qUserMemberData.team_id#&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">