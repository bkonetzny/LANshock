<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_tournament_changestatus.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.tournamentid" default="">
<cfparam name="attributes.status" default="">
<cfparam name="attributes.form_submitted" default="false">

<cfif ListFind(stGlobalVars.statuslist,attributes.status)>
	
	<cfset oTournament = application.lanshock.oFactory.load('tournament_tournament','reactorRecord')>
	<cfset oTournament.setID(attributes.tournamentid)>
	<cfset oTournament.load()>
	<cfset sStatusOld = oTournament.getStatus()>
	<cfset oTournament.setStatus(attributes.status)>
	<cfset oTournament.save()>
	
	<cfset sStatusNew = attributes.status>
	
	<cfinclude template="type/#qTournament.type#/act_tournament_changestatus.cfm">

	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#')#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">