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
<div class="headline">#request.content.tournamentoverview#</div>

<div class="headline2">#request.content.new_tournament#</div>

<table align="center">
	<form action="#myself##myfusebox.thiscircuit#.tournaments_edit_settings&#request.session.UrlToken#" method="post">
	<input type="hidden" name="type" value="#attributes.type#">
	<tr>
		<td valign="top">#request.content.tournament_type#<br>
			<strong><cftry>#request.content['tournament_type_' & attributes.type]#<cfcatch>#attributes.type#</cfcatch></cftry></strong>
			</td>
	</tr>
	<tr>
		<td valign="top">#request.content.tournament_export_league#<br>
			<table>
				<tr>
					<td><input type="radio" name="export_league" id="league_noleague" value="" checked></td>
					<td><label for="league_noleague">#request.content.tournament_export_league_#</label></td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td><input type="radio" name="export_league" id="league_wwcl" value="wwcl"></td>
					<td><label for="league_wwcl">#request.content.tournament_export_league_wwcl#</label></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.wwcl.net" target="_blank">http://www.wwcl.net</a></td>
					<td><img src="#UDF_Module('webPath')#export/wwcl.gif"></td>
				</tr>
				<tr>
					<td><input type="radio" name="export_league" id="league_ngl" value="ngl"></td>
					<td><label for="league_ngl">#request.content.tournament_export_league_ngl#</label></td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.ngl-europe.com" target="_blank">http://www.ngl-europe.com</a></td>
					<td><img src="#UDF_Module('webPath')#export/ngl.gif"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="center"><input type="Submit" value="#request.content.tournament_edit_nextbutton#"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">