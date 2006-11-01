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
<div class="headline2">#request.content.team_leave_headline# #stTeam.name#</div>
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
	<form action="#myself##myfusebox.thiscircuit#.team_leave&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<tr>
		<td><input type="checkbox" name="leave_accepted" id="leave_accepted" value="true"></td>
		<td><label for="leave_accepted">#request.content.i_accept_leave#</label></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="Submit" value="#request.content.team_leave_submit#"> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#myself##myfusebox.thiscircuit#.team_details&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#')"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">