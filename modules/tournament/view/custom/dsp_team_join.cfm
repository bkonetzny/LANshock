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
<h4>#request.content.team_join_headline# #stTeam.name#</h4>

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
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_join')#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="tournamentid" value="#attributes.tournamentid#">
	<input type="hidden" name="teamid" value="#stTeam.id#">
	<cfif ListFind(stTeam.autoacceptids, session.userid)>
		<tr>
			<td colspan="2">#request.content.team_join_autojoin_found#</td>
		</tr>
	</cfif>
	<tr>
		<td><input type="checkbox" name="join_accepted" id="join_accepted" value="true"></td>
		<td><label for="join_accepted">#request.content.i_accept_join#</label></td>
	</tr>
	<tr>
		<td colspan="2" align="center"><input type="Submit" value="#request.content.team_join_submit#"> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#')#')"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">