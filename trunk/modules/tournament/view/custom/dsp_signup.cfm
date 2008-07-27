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
<h3>#request.content.signup_headline#</h3>

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

<form class="uniForm" action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
		<input type="hidden" name="tournamentid" value="#attributes.tournamentid#"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.signup_headline#</legend>
		<cfif qTournament.teamsize NEQ 1>
			<div class="ctrlHolder">
				<label for="name"><em>*</em> #request.content.team_name#</label>
				<input type="text" class="textInput" name="name" id="name" value="#HTMLEditFormat(attributes.name)#" maxlength="20"/>
			</div>
		</cfif>
		<cfif len(qTournament.export_league)>
			<div class="ctrlHolder">
				<label for="leagueid">#request.content['team_id_' & qTournament.export_league]#</label>
				<input type="text" class="textInput" name="leagueid" id="leagueid" value="#HTMLEditFormat(attributes.leagueid)#" maxlength="20"/>
			</div>
		</cfif>
		<div class="ctrlHolder">
			<label for="rules_accepted" class="inlineLabel"><input type="checkbox" name="rules_accepted" id="rules_accepted" value="true"/> <em>*</em> #request.content.i_accept_the_rules#</label>
		</div>
	</fieldset>

	<div class="buttonHolder">
		<button type="submit" class="submitButton">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" onclick="javascript:document.location.href('#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#')#');return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">