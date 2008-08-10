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
<h4>#request.content.team_player_delete_headline# #application.lanshock.oHelper.GetUsernameByID(attributes.userid)#</h4>

<cfif ArrayLen(aError)>
	<div class="errorBox">
		<h3>#request.content.error#</h3>
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<table align="center">
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_player_delete&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="userid" value="#attributes.userid#">
	<tr>
		<td><input type="checkbox" name="delete_accepted" id="delete_accepted" value="true"></td>
		<td><label for="delete_accepted">#request.content.i_accept_team_player_delete#</label></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="Submit" value="#request.content.team_player_delete_submit#"> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#stTeam.id#')#')"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">