<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
<div class="headline2">#request.content.tournaments_changestatus_headline#</div>
<br><br>

<table width="90%" align="center">
	<cfloop list="#stGlobalVars.statuslist#" index="idx">
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=#idx#&#request.session.UrlToken#" class="link_extended">#request.content['tournament_status_' & idx]#</a><br>
				#request.content['tournament_status_' & idx & '_txt']#<br>&nbsp;</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">