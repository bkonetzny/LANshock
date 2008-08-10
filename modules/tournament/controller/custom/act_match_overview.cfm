<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/controller/custom/act_matches.cfm $
$LastChangedDate: 2008-07-20 20:27:36 +0200 (So, 20 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 420 $
--->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type')#" method="getMatchesByStatus" returnvariable="qMatchesPlay">
	<cfinvokeargument name="season_id" value="1">
	<cfinvokeargument name="status" value="play">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type')#" method="getMatchesByStatus" returnvariable="qMatchesAdminCheck">
	<cfinvokeargument name="season_id" value="1">
	<cfinvokeargument name="status" value="admincheck">
</cfinvoke>

<cfsetting enablecfoutputonly="No">

Type: "expression" | Message: "invalid call of the function updateMatch, 8th Argument (submittedby_teamid) is of invalid type, can't cast Object type [String] to a value of type [numeric]" | Detail: "" | QueryString: "fuseaction=tournament.matchdetails&/" | Referer: "http://192.168.88.10/tournament.matchdetails/tournamentid/23/matchid/906/" | UserAgent: "Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.0.1) Gecko/2008070208 Firefox/3.0.1"