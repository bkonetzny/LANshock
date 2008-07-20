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

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	<cfinvokeargument name="teamid" value="#attributes.teamid#">
</cfinvoke>

<cfparam name="attributes.delete_accepted" default="false">

<cfif attributes.form_submitted AND session.userloggedin>

	<cfscript>
		// validation
		if(session.userid NEQ stTeam.leaderid) ArrayAppend(aError, request.content.error_team_player_delete_mustbeleader);
		if(attributes.userid EQ stTeam.leaderid) ArrayAppend(aError, request.content.error_team_player_delete_cantbeleader);
		
		if(qTournament.status NEQ "signup") ArrayAppend(aError, request.content.error_team_player_delete_wrongtournamentstatus);
		else if(NOT attributes.delete_accepted) ArrayAppend(aError, request.content.error_team_player_delete_accept);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="removePlayer">
			<cfinvokeargument name="teamid" value="#attributes.teamid#">
			<cfinvokeargument name="userid" value="#attributes.userid#">
		</cfinvoke>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#attributes.teamid#')#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">