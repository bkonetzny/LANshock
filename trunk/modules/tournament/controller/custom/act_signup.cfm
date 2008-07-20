<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfparam name="attributes.name" default="#request.content.teamname_prefix##session.oUser.getDataValue('name')##request.content.teamname_suffix#">
<cfif len(qTournament.export_league)>
	<cfswitch expression="#qTournament.export_league#">
		<cfcase value="wwcl">
			<cfif qTournament.teamsize EQ 1>
				<cfparam name="attributes.leagueid" default="P">
			<cfelse>
				<cfparam name="attributes.leagueid" default="C">
			</cfif>
		</cfcase>
		<cfcase value="ngl">
			<cfparam name="attributes.leagueid" default="">
		</cfcase>
	</cfswitch>
<cfelse>
	<cfparam name="attributes.leagueid" default="">
</cfif>
<cfparam name="attributes.rules_accepted" default="false">


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
		if(qTournament.teamsize EQ 1) attributes.name = "SINGLEPLAYER_" & application.lanshock.oHelper.GetUsernameByID(session.userid);
		
		if(NOT len(attributes.name)) ArrayAppend(aError, request.content.error_team_name);
		if(NOT attributes.rules_accepted) ArrayAppend(aError, request.content.error_team_rules);
		if(qTournament.status NEQ "signup") ArrayAppend(aError, request.content.error_signup_wrongtournamentstatus);
		if(stModuleConfig.groupmaxsignups AND qGroup.maxsignups NEQ 0 AND aUserGroupIDs[qGroup.id] GTE qGroup.maxsignups) ArrayAppend(aError, request.content.error_signup_maxsignups_reached);
		if(stModuleConfig.coinsystem AND iUserCoins LT 0) ArrayAppend(aError, request.content.error_signup_not_enough_coins);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="createTeam" returnvariable="teamid">
			<cfinvokeargument name="name" value="#attributes.name#">
			<cfinvokeargument name="leaderid" value="#session.userid#">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="leagueid" value="#attributes.leagueid#">
		</cfinvoke>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#teamid#')#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">