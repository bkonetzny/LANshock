<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.tournamentid" default="">
<cfparam name="attributes.status" default="">
<cfparam name="attributes.form_submitted" default="false">

<cfif ListFind(stGlobalVars.statuslist,attributes.status)>

	<cfinvoke component="tournaments" method="setTournamentStatus">
		<cfinvokeargument name="id" value="#attributes.tournamentid#">
		<cfinvokeargument name="status" value="#attributes.status#">
	</cfinvoke>

	<cflocation url="#myself##myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">