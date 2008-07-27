<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_se_ranking.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
<h4>#request.content.type_se_ranking_headline#</h4>

<!--- <cfif session.oUser.checkPermissions('manage') AND qTournament.status EQ 'done'>
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&calculateRanking=true')#">Ranking neu berechnen</a></li>
	</ul>
</cfif> --->

<table>
	<tr>
		<th>Position</th>
		<th>Player / Team</th>
		<th>Match Win/Lose</th>
		<th>Points Win/Lose</th>
	</tr>
	<cfloop query="qRanking">
		<tr>
			<td>#qRanking.pos#.</td>
			<td><cfif qTournament.teamsize GT 1>
					<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#qRanking.teamid#')#">#qRanking.name#</a><br/>
				<cfelse>
					<a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qRanking.leaderid#')#">#qRanking.name#</a><br/>
				</cfif></td>
			<td><span class="stats_win">#qRanking.stats_win#</span> / <span class="stats_lose">#qRanking.stats_lose#</span></td>
			<td><span class="stats_win">#qRanking.points_win#</span> / <span class="stats_lose">#qRanking.points_lose#</span></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">