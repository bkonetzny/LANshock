<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_se_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfif sStatusNew EQ 'warmup'
	AND sStatusOld EQ 'signup'>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="createAllMatches">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>
</cfif>

<cfif sStatusNew EQ 'done'>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="calculateRanking">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>
</cfif>

<cfsetting enablecfoutputonly="No">