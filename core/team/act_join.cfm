<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.id" default="">

<cfif NOT isNumeric(attributes.id)>
	<cflocation url="#myself##myfusebox.thiscircuit#.list&#request.session.UrlToken#" addtoken="false">
<cfelseif isNumeric(qUserMemberData.team_id)>
	<cflocation url="#myself##myfusebox.thiscircuit#.details&id=#attributes.id#&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfinvoke component="team" method="getTeam" returnvariable="qTeam">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif qTeam.recordcount>
	<cfinvoke component="team" method="setTeamMember">
		<cfinvokeargument name="team_id" value="#attributes.id#">
		<cfinvokeargument name="user_id" value="#request.session.userid#">
		<cfinvokeargument name="status" value="request">
		<cfinvokeargument name="rights" value="">
	</cfinvoke>
</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.details&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">