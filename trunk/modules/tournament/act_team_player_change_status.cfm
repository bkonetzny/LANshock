<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="team" method="getTeamData" returnvariable="stTeam">
	<cfinvokeargument name="teamid" value="#attributes.teamid#">
</cfinvoke>

<cfif request.session.userid EQ stTeam.leaderid>

	<cfinvoke component="team" method="changePlayerStatus">
		<cfinvokeargument name="teamid" value="#attributes.teamid#">
		<cfinvokeargument name="userid" value="#attributes.userid#">
		<cfinvokeargument name="status" value="#attributes.status#">
	</cfinvoke>

</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.team_details&teamid=#attributes.teamid#&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">