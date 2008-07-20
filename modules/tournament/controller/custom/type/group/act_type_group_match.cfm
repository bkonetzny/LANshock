<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_group_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.markteam" default="">
<cfparam name="attributes.grouphandler_add" default="false">
<cfparam name="attributes.grouphandler_delete" default="0">
<cfparam name="attributes.randomize_first_round" default="false">

<cfif session.oUser.checkPermissions('manage')>
	<cfparam name="attributes.showstatus" default="true">
<cfelse>
	<cfset attributes.showstatus = false>
</cfif>

<cfif attributes.grouphandler_add AND ListFind('signup,warmup',qTournament.status)>
	<cfinvoke component="type_group" method="setGroup">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="name" value="#attributes.group_name#">
	</cfinvoke>
</cfif>

<cfif attributes.grouphandler_delete AND ListFind('signup,warmup',qTournament.status)>
	<cfinvoke component="type_group" method="deleteGroup">
		<cfinvokeargument name="id" value="#attributes.grouphandler_delete#">
	</cfinvoke>
	<cfset attributes.randomize_first_round = true>
</cfif>

<cfinvoke component="type_group" method="getGroups" returnvariable="qGroups">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfif attributes.randomize_first_round AND qTournament.status EQ 'warmup'>

	<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
		DELETE FROM tournament_type_group_groups_teams
		WHERE groupid IN (<cfqueryparam cfsqltype="cf_sql_integer" value="#ValueList(qGroups.id)#" list="true">)
	</cfquery>
	
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeams" returnvariable="stTeams">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
	</cfinvoke>
	
	<cfscript>
		lGroupIDs = ValueList(qGroups.id);
		lTeamIDs = '';
		cnt = 0;
	</cfscript>

	<cfloop collection="#stTeams#" item="idx">
		<cfset lTeamIDs = ListAppend(lTeamIDs,stTeams[idx].id)>
	</cfloop>
	
	<cfset lTeamIDs = ListRandom(lTeamIDs)>
	
	<cfloop list="#lTeamIDs#" index="idxTeamID">

		<cfscript>
			if(cnt LT ListLen(lGroupIDs)) cnt = cnt + 1;
			else cnt = 1;

			iGroupID = ListGetAt(lGroupIDs,cnt);
		</cfscript>

		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			INSERT INTO tournament_type_group_groups_teams (groupid, teamid)
			VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#iGroupID#">,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#idxTeamID#">)
		</cfquery>
		
	</cfloop>

</cfif>

<cfinvoke component="type_group" method="getGroups" returnvariable="qGroups">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfinvoke component="type_group" method="getMatches" returnvariable="qMatches">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">