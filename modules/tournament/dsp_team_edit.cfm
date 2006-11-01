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
<div class="headline2">#request.content.team_edit_headline# #stTeam.name#</div>
<br><br>

<cfif ArrayLen(aError)>
	<div class="errorBox">
		#request.content.error#
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<div align="center">
	<a href="#myself##myfusebox.thiscircuit#.team_details&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#" class="link_extended">#request.content.team_details#</a>
</div>

<br><br>

<table align="center">
	<form action="#myself##myfusebox.thiscircuit#.team_edit&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<cfif qTournament.teamsize NEQ 1>
	<tr>
		<td>#request.content.team_edit_teamname#<br>
			<input type="text" name="teamname" value="#HTMLEditFormat(attributes.teamname)#" style="width: 200px;"></td>
	</tr>
	</cfif>
	<cfif len(qTournament.export_league)>
		<tr>
			<td>#request.content['team_id_' & qTournament.export_league]#<br>
				<input type="text" name="leagueid" value="#HTMLEditFormat(attributes.leagueid)#" style="width: 200px;"></td>
		</tr>
	</cfif>
	<tr>
		<td><input type="Submit" name="changeDetails" value="#request.content.form_save#"></td>
	</tr>
	<cfif qTournament.teamsize NEQ 1>
	<tr>
		<td align="center">
			<table>
				<tr>
					<td>#request.content.team_edit_accept_manual#<br>
						<select name="ids_manual" multiple size="10" style="width: 150px;">
							<cfloop query="qUser">
								<cfif NOT ListFind(attributes.autoacceptids, id)><option value="#id#">#HTMLEditFormat(name)#</option></cfif>
							</cfloop>
						</select></td>
					<td><input type="Submit" name="addUsers" value="#request.content.team_edit_submit_addusers#"><br>
						&nbsp;<br>
						<input type="Submit" name="removeUsers" value="#request.content.team_edit_submit_removeusers#"></td>
					<td>#request.content.team_edit_accept_auto#<br>
						<select name="ids_auto" multiple size="10" style="width: 150px;">
							<cfloop query="qUser">
								<cfif ListFind(attributes.autoacceptids, id)><option value="#id#">#HTMLEditFormat(name)#</option></cfif>
							</cfloop>
						</select></td>
				</tr>
			</table>
		</td>
	</tr>
	</cfif>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">