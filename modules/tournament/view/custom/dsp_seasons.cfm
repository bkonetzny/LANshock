<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_tournaments.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
<h3>#request.content.tournamentsystem#</h3>

<table>
	<tr>
		<th>Season</th>
		<th>Start</th>
		<th>End</th>
	</tr>
	<cfloop query="qSeasons">
		<tr>
			<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.tournaments&season=#qSeasons.id#')#">#qSeasons.name#</a></td>
			<td>#session.oUser.DateTimeFormat(qSeasons.dt_start)#</td>
			<td>#session.oUser.DateTimeFormat(qSeasons.dt_end)#</td>
		</tr>
		<tr>
			<td colspan="3">#qSeasons.description#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">