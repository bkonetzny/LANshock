<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif qTournament.teamsize EQ 1>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTournament.id#')#" addtoken="false">
</cfif>

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	<cfinvokeargument name="teamid" value="#attributes.teamid#">
</cfinvoke>

<cfparam name="attributes.join_accepted" default="false">

<cfif attributes.form_submitted AND session.userloggedin>

	<cfif stModuleConfig.groupmaxsignups>
		<cfset aUserGroupIDs = ArrayNew(1)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getUserTournaments" returnvariable="qUserTournaments">
			<cfinvokeargument name="userid" value="#session.userid#">
		</cfinvoke>
		
		<cfloop list="#ValueList(qUserTournaments.groupid)#" index="idx">
			<cfparam name="aUserGroupIDs['#idx#']" default="0">
			<cfset aUserGroupIDs[idx] = aUserGroupIDs[idx] + 1>
		</cfloop>
		
		<cfset stFilter = StructNew()>
		<cfset stFilter.lSortFields = "name|DESC">
		<cfset stFilter.stFields.id = StructNew()>
		<cfset stFilter.stFields.id.mode = 'isEqual'>
		<cfset stFilter.stFields.id.value = qTournament.groupid>
		
		<cfinvoke component="#application.lanshock.oFactory.load('tournament_group','reactorGateway')#" method="getRecords" returnvariable="qGroup">
			<cfinvokeargument name="stFilter" value="#stFilter#">
		</cfinvoke>
		
		<cfparam name="aUserGroupIDs['#qGroup.id#']" default="0">
	</cfif>
	
	<cfif stModuleConfig.coinsystem>
		<cfset iUserCoins = stModuleConfig.coinsystem_usercoins>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getUserTournaments" returnvariable="qUserTournaments">
			<cfinvokeargument name="userid" value="#session.userid#">
		</cfinvoke>

		<cfloop list="#ValueList(qUserTournaments.coins)#" index="idx">
			<cfset iUserCoins = iUserCoins - idx>
		</cfloop>
		
		<cfset iUserCoins = iUserCoins - qTournament.coins>
	</cfif>

	<cfscript>
		// validation
		if(qTournament.status NEQ "signup") ArrayAppend(aError, request.content.error_join_wrongtournamentstatus);
		else if(NOT attributes.join_accepted) ArrayAppend(aError, request.content.error_join_accept);
		if(stModuleConfig.groupmaxsignups AND qGroup.maxsignups NEQ 0 AND aUserGroupIDs[qGroup.id] GTE qGroup.maxsignups) ArrayAppend(aError, request.content.error_signup_maxsignups_reached);
		if(stModuleConfig.coinsystem AND iUserCoins LT 0) ArrayAppend(aError, error_signup_not_enough_coins);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="joinTeam">
			<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
			<cfinvokeargument name="teamid" value="#attributes.teamid#">
			<cfinvokeargument name="userid" value="#session.userid#">
		</cfinvoke>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#attributes.teamid#')#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">