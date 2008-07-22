<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_tournament_changestatus.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
<div class="headline2">#request.content.tournaments_changestatus_headline#</div>
<br><br>

<table width="90%" align="center">
	<cfloop list="#stGlobalVars.statuslist#" index="idx">
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=#idx#&#session.UrlToken#" class="link_extended">#request.content['tournament_status_' & idx]#</a><br>
				#request.content['tournament_status_' & idx & '_txt']#<br>&nbsp;</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">