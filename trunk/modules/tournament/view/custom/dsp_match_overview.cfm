<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/view/custom/dsp_mytournaments.cfm $
$LastChangedDate: 2008-07-20 20:27:36 +0200 (So, 20 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 420 $
--->

<cfoutput>
<h3>Offene Matches</h3>

<h4>Kontrollieren</h4>

<cfif qMatchesAdminCheck.recordcount>
	<table>
		<tr>
			<th>#request.content.tournament_name#</th>
			<th>Team 1</th>
			<th>Team 2</th>
			<th>Optionen</th>
		</tr>
		<cfloop query="qMatchesAdminCheck">
			<tr>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#qMatchesAdminCheck.tournamentid#')#">#qMatchesAdminCheck.name#</a></td>
				<td>#qMatchesAdminCheck.team1_name#</td>
				<td>#qMatchesAdminCheck.team2_name#</td>
				<td>Match-ID: #qMatchesAdminCheck.id#</td>
			</tr>
		</cfloop>
	</table>
<cfelse>
	<p>Es gibt keine best&auml;tigten Spiele die kontrolliert werden m&uuml;ssen.</p>
</cfif>

<h4>Spielen</h4>

<cfif qMatchesPlay.recordcount>
	<table>
		<tr>
			<th>#request.content.tournament_name#</th>
			<th>Team 1</th>
			<th>Team 2</th>
			<th>Optionen</th>
		</tr>
		<cfloop query="qMatchesPlay">
			<tr>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#qMatchesPlay.tournamentid#')#">#qMatchesPlay.name#</a></td>
				<td>#qMatchesPlay.team1_name#</td>
				<td>#qMatchesPlay.team2_name#</td>
				<td>Match-ID: #qMatchesPlay.id#</td>
			</tr>
		</cfloop>
	</table>
<cfelse>
	<p>Es gibt keine offenen Paarungen die gespielt werden m&uuml;ssen.</p>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">