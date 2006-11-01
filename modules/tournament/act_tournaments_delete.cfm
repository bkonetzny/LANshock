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

<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
	<cfinvokeargument name="id" value="#attributes.tournamentid#">
</cfinvoke>

<cfparam name="attributes.delete_accepted" default="false">

<cfif attributes.form_submitted AND request.session.userloggedin>

	<cfscript>
		// validation
		if(NOT attributes.delete_accepted) ArrayAppend(aError, request.content.error_delete_accept);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
		
		<cfinclude template="act_type_#qTournament.type#_delete.cfm">

		<cfinvoke component="tournaments" method="deleteTournament">
			<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.tournaments_edit&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">