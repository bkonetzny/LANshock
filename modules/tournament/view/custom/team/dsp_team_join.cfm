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

<cfif ListFind(stTeam.autoacceptids, session.userid)>
	<p>#request.content.team_join_autojoin_found#</p>
</cfif>

<form class="uniForm" action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
		<input type="hidden" name="tournamentid" value="#attributes.tournamentid#"/>
		<input type="hidden" name="teamid" value="#stTeam.id#"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.team_join_headline# #stTeam.name#</legend>
		<div class="ctrlHolder">
			<label for="join_accepted" class="inlineLabel"><input type="checkbox" name="join_accepted" id="join_accepted" value="true"/> <em>*</em> #request.content.i_accept_join#</label>
		</div>
	</fieldset>

	<div class="buttonHolder">
		<button type="submit" class="submitButton">#request.content.team_join_submit#</button>
		<button type="cancel" class="cancelButton" onclick="javascript:document.location.href('#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#')#');return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">