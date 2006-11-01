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

<cfparam name="attributes.name" default="#request.content.teamname_prefix##GetUsernameByID(request.session.userid)##request.content.teamname_suffix#">
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

<cfif attributes.form_submitted AND request.session.userloggedin>

	<cfif stModuleConfig.groupmaxsignups>
		<cfset aUserGroupIDs = ArrayNew(1)>
		
		<cfinvoke component="tournaments" method="getUserTournaments" returnvariable="qUserTournaments">
			<cfinvokeargument name="userid" value="#request.session.userid#">
		</cfinvoke>
		
		<cfloop list="#ValueList(qUserTournaments.groupid)#" index="idx">
			<cfparam name="aUserGroupIDs['#idx#']" default="0">
			<cfset aUserGroupIDs[idx] = aUserGroupIDs[idx] + 1>
		</cfloop>
		
		<cfinvoke component="tournaments" method="getGroup" returnvariable="qGroup">
			<cfinvokeargument name="id" value="#qTournament.groupid#">
		</cfinvoke>
		
		<cfparam name="aUserGroupIDs['#qGroup.id#']" default="0">
	</cfif>
	
	<cfif stModuleConfig.coinsystem>
		<cfset iUserCoins = stModuleConfig.coinsystem_usercoins>
		
		<cfinvoke component="tournaments" method="getUserTournaments" returnvariable="qUserTournaments">
			<cfinvokeargument name="userid" value="#request.session.userid#">
		</cfinvoke>

		<cfloop list="#ValueList(qUserTournaments.coins)#" index="idx">
			<cfset iUserCoins = iUserCoins - idx>
		</cfloop>
		
		<cfset iUserCoins = iUserCoins - qTournament.coins>
	</cfif>

	<cfscript>
		// validation
		if(qTournament.teamsize EQ 1) attributes.name = "SINGLEPLAYER_" & GetUsernameByID(request.session.userid);
		
		if(NOT len(attributes.name)) ArrayAppend(aError, request.content.error_team_name);
		if(NOT attributes.rules_accepted) ArrayAppend(aError, request.content.error_team_rules);
		if(qTournament.status NEQ "signup") ArrayAppend(aError, request.content.error_signup_wrongtournamentstatus);
		if(stModuleConfig.groupmaxsignups AND qGroup.maxsignups NEQ 0 AND aUserGroupIDs[qGroup.id] GTE qGroup.maxsignups) ArrayAppend(aError, request.content.error_signup_maxsignups_reached);
		if(stModuleConfig.coinsystem AND iUserCoins LT 0) ArrayAppend(aError, request.content.error_signup_not_enough_coins);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="team" method="createTeam" returnvariable="teamid">
			<cfinvokeargument name="name" value="#attributes.name#">
			<cfinvokeargument name="leaderid" value="#request.session.userid#">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="leagueid" value="#attributes.leagueid#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.team_details&teamid=#teamid#&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">