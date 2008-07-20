<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	<cfinvokeargument name="teamid" value="#attributes.teamid#">
</cfinvoke>

<cfif session.userid EQ stTeam.leaderid>

	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="changePlayerStatus">
		<cfinvokeargument name="teamid" value="#attributes.teamid#">
		<cfinvokeargument name="userid" value="#attributes.userid#">
		<cfinvokeargument name="status" value="#attributes.status#">
	</cfinvoke>

</cfif>

<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#attributes.teamid#')#" addtoken="false">

<cfsetting enablecfoutputonly="No">