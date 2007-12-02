<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/act_details.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfparam name="attributes.id" default="#qUserMemberData.team_id#">

<cfif NOT isNumeric(attributes.id) OR NOT attributes.id GT 0>
	<cflocation url="#myself##myfusebox.thiscircuit#.list&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfinvoke component="team" method="getTeam" returnvariable="qTeam">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif NOT qTeam.recordcount>
	<cflocation url="#myself##myfusebox.thiscircuit#.list&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfinvoke component="team" method="getTeamMembers" returnvariable="qTeamMembers">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">