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
<div class="headline">#request.content.delete_tournament_headline# #qTournament.name#</div>
<br><br>
#request.content.delete_tournament_hint#
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

<table align="center">
	<form action="#myself##myfusebox.thiscircuit#.tournaments_delete&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<tr>
		<td><input type="checkbox" name="delete_accepted" id="delete_accepted" value="true"></td>
		<td><label for="delete_accepted">#request.content.i_accept_the_delete#</label></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="Submit" value="#request.content.form_delete#"> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#myself##myfusebox.thiscircuit#.tournaments_edit&#request.session.UrlToken#')"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">