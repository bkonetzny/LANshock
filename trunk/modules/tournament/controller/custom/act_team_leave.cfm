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

<cfparam name="attributes.leave_accepted" default="false">

<cfif attributes.form_submitted AND session.userloggedin>

	<cfif qTournament.status NEQ "signup">
		<cfset ArrayAppend(aError, request.content.error_leave_wrongtournamentstatus)>
	<cfelseif NOT attributes.leave_accepted>
		<cfset ArrayAppend(aError, request.content.error_leave_accept)>
	</cfif>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="leaveTeam">
			<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
			<cfinvokeargument name="teamid" value="#attributes.teamid#">
			<cfinvokeargument name="userid" value="#session.userid#">
		</cfinvoke>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#')#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">