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
<div class="headline2">#request.content.team_join_headline# #stTeam.name#</div>
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
	<form action="#myself##myfusebox.thiscircuit#.team_join&teamid=#stTeam.id#&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<cfif ListFind(stTeam.autoacceptids, request.session.userid)>
		<tr>
			<td colspan="2">#request.content.team_join_autojoin_found#</td>
		</tr>
	</cfif>
	<tr>
		<td><input type="checkbox" name="join_accepted" id="join_accepted" value="true"></td>
		<td><label for="join_accepted">#request.content.i_accept_join#</label></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="Submit" value="#request.content.team_join_submit#"> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#myself##myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#')"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">