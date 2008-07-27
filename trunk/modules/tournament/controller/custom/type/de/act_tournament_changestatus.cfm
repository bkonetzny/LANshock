<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_se_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfset sRelocate = ''>

<cfif sStatusOld EQ 'signup' AND sStatusNew EQ 'warmup'>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_de')#" method="createAllMatches">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>
	
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_de')#" method="randomizeFirstRound">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
	</cfinvoke>
	
	<cfset sRelocate = 'matches'>
</cfif>

<cfif sStatusNew EQ 'done'>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_de')#" method="calculateRanking">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>
	
	<cfset sRelocate = 'ranking'>
</cfif>

<cfif sStatusNew EQ 'playing'>
	<cfset sRelocate = 'matches'>
</cfif>

<cfif len(sRelocate)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#sRelocate#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">