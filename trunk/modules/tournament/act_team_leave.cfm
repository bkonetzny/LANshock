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
	<cflocation url="#myself##myfusebox.thiscircuit#.teams&tournamentid=#qTournament.id#&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfinvoke component="team" method="getTeamData" returnvariable="stTeam">
	<cfinvokeargument name="teamid" value="#attributes.teamid#">
</cfinvoke>

<cfparam name="attributes.leave_accepted" default="false">

<cfif attributes.form_submitted AND request.session.userloggedin>

	<cfscript>
		// validation
		if(qTournament.status NEQ "signup") ArrayAppend(aError, request.content.error_leave_wrongtournamentstatus);
		else if(NOT attributes.leave_accepted) ArrayAppend(aError, request.content.error_leave_accept);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="team" method="leaveTeam">
			<cfinvokeargument name="teamid" value="#attributes.teamid#">
			<cfinvokeargument name="userid" value="#request.session.userid#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">