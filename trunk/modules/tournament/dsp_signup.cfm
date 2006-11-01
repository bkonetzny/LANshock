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
<div class="headline2">#request.content.signup_headline#</div>

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

<table>
	<form action="#myself##myfusebox.thiscircuit#.signup&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<cfif qTournament.teamsize NEQ 1>
		<tr>
			<td colspan="2">#request.content.team_name#<br>
				<input type="text" name="name" maxlength="255" value="#HTMLEditFormat(attributes.name)#"></td>
		</tr>
	</cfif>
	<cfif len(qTournament.export_league)>
		<tr>
			<td colspan="2">#request.content['team_id_' & qTournament.export_league]#<br>
				<input type="text" name="leagueid" maxlength="255" value="#HTMLEditFormat(attributes.leagueid)#"></td>
		</tr>
	</cfif>
	<tr>
		<td><input type="checkbox" name="rules_accepted" id="rules_accepted" value="true"></td>
		<td><label for="rules_accepted">#request.content.i_accept_the_rules#</label></td>
	</tr>
	<tr>
		<td colspan="2"><input type="Submit" value="#request.content.signup_submit#"> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#myself##myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#')"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">