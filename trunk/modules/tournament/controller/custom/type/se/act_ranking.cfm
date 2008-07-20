<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_se_ranking.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfinvoke component="#application.lanshock.oFactory.load(bCache=false,sObject='lanshock.modules.tournament.model.type_se')#" method="calculateRanking">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="getRanking" returnvariable="qRanking">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">