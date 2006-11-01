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

<cfset queryobject = stTeam.players>
<cfquery dbtype="query" name="qPlayerOld">
	SELECT id, userid, status
	FROM queryobject
	WHERE userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.userid#">
</cfquery>
<cfquery dbtype="query" name="qPlayerNew">
	SELECT id, userid, status
	FROM queryobject
	WHERE userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.rearrange_users#">
</cfquery>

<cfif request.session.userid EQ stTeam.leaderid>

	<cfinvoke component="team" method="changePlayerStatus">
		<cfinvokeargument name="teamid" value="#attributes.teamid#">
		<cfinvokeargument name="userid" value="#qPlayerOld.userid#">
		<cfinvokeargument name="status" value="#qPlayerNew.status#">
	</cfinvoke>

	<cfinvoke component="team" method="changePlayerStatus">
		<cfinvokeargument name="teamid" value="#attributes.teamid#">
		<cfinvokeargument name="userid" value="#qPlayerNew.userid#">
		<cfinvokeargument name="status" value="#qPlayerOld.status#">
	</cfinvoke>

</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.team_details&teamid=#attributes.teamid#&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">