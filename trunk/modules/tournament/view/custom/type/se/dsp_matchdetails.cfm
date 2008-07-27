<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_se_matchdetails.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
	<cfif session.oUser.checkPermissions('manage')>
		<h4>#request.content.type_se_matchdetails_statuschange#</h4>
		<cfset urlstring = "#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#stMatch.id#&form_submitted2=true&status=')#">
		<ul class="options">
			<cfif stMatch.status EQ 'empty'>
				<li><strong>#request.content.type_se_matchdetails_status_save_teams#</strong></li>
			<cfelse>
				<li><a href="#urlstring#empty">#request.content.type_se_matchdetails_status_save_teams#</a></li>
			</cfif>
			<cfif stMatch.status EQ 'play'>
				<li><strong>#request.content.type_se_matchdetails_status_playing#</strong></li>
			<cfelse>
				<li><a href="#urlstring#play">#request.content.type_se_matchdetails_status_playing#</a></li>
			</cfif>
			<cfif stMatch.status EQ 'admincheck'>
				<li><strong>#request.content.type_se_matchdetails_status_admincheck#</strong></li>
			<cfelse>
				<li><a href="#urlstring#admincheck">#request.content.type_se_matchdetails_status_admincheck#</a></li>
			</cfif>
			<cfif stMatch.status EQ 'done'>
				<li><strong>#request.content.type_se_matchdetails_status_done#</strong></li>
			<cfelse>
				<li><a href="#urlstring#done">#request.content.type_se_matchdetails_status_done#</a></li>
			</cfif>
			<li><a href="#urlstring#reset">#request.content.type_se_matchdetails_status_reset#</a></li>
		</ul>
	</cfif>

	<h4>#request.content.type_se_matchdetails_headline#</h4>
	
	<cfif stMatch.status EQ 'empty' AND session.oUser.checkPermissions('manage')>
		<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
			<div class="hidden">
				<input type="hidden" name="form_submitted" value="true"/>
				<input type="hidden" name="tournamentid" value="#qTournament.id#"/>
				<input type="hidden" name="matchid" value="#stMatch.id#"/>
			</div>

			<fieldset class="inlineLabels">
				<legend>Assign Teams</legend>
		
				<div class="ctrlHolder">
					<label for="profile_name"><em>*</em> Team 1</label>
					<select name="team1">
						<option value=""></option>
						<cfif isDefined("idTeam1")>
							<optgroup label="#request.content.type_se_matchdetails_selectbx_winnersofrelatedpreround#">
							<cfloop list="#ListSort(StructKeyList(stTeams),'textnocase','asc')#" index="idx">
								<cfif idTeam1 EQ stTeams[idx].id>
									<option value="#stTeams[idx].id#"><cfif qTournament.teamsize EQ 1>#stTeams[idx].leadername#<cfelse>#stTeams[idx].name#</cfif></option>
								</cfif>
							</cfloop>
							</optgroup>
						</cfif>
						<cfif len(lWinners)>
							<optgroup label="#request.content.type_se_matchdetails_selectbx_allwinnersofpreround#">
							<cfloop list="#ListSort(StructKeyList(stTeams),'textnocase','asc')#" index="idx">
								<cfif ListFind(lWinners,stTeams[idx].id)>
									<option value="#stTeams[idx].id#"<cfif stMatch.team1.id EQ stTeams[idx].id> selected="selected"</cfif>><cfif qTournament.teamsize EQ 1>#stTeams[idx].leadername#<cfelse>#stTeams[idx].name#</cfif></option>
								</cfif>
							</cfloop>
							</optgroup>
						</cfif>
						<optgroup label="#request.content.type_se_matchdetails_selectbx_allteams#">
						<cfloop from="1" to="#ArrayLen(StructSort(stTeams,'textnocase','ASC','name'))#" index="idx">
							<option value="#stTeams[idx].id#"<cfif stMatch.team1.id EQ stTeams[idx].id AND NOT ListFind(lWinners,stTeams[idx].id)> selected</cfif>>#stTeams[idx].name#</option>
						</cfloop>
						</optgroup>
					</select>
				</div>
				
				<div class="ctrlHolder">
					<label for="profile_email"><em>*</em> Team 2</label>
					<select name="team2">
						<option value=""></option>
						<cfif isDefined("idTeam2")>
							<optgroup label="#request.content.type_se_matchdetails_selectbx_winnersofrelatedpreround#">
							<cfloop list="#ListSort(StructKeyList(stTeams),'textnocase','asc')#" index="idx">
								<cfif idTeam2 EQ stTeams[idx].id>
									<option value="#stTeams[idx].id#"><cfif qTournament.teamsize EQ 1>#stTeams[idx].leadername#<cfelse>#stTeams[idx].name#</cfif></option>
								</cfif>
							</cfloop>
							</optgroup>
						</cfif>
						<cfif len(lWinners)>
							<optgroup label="#request.content.type_se_matchdetails_selectbx_allwinnersofpreround#">
							<cfloop list="#ListSort(StructKeyList(stTeams),'textnocase','asc')#" index="idx">
								<cfif ListFind(lWinners,stTeams[idx].id)>
									<option value="#stTeams[idx].id#"<cfif stMatch.team2.id EQ stTeams[idx].id> selected="selected"</cfif>><cfif qTournament.teamsize EQ 1>#stTeams[idx].leadername#<cfelse>#stTeams[idx].name#</cfif></option>
								</cfif>
							</cfloop>
							</optgroup>
						</cfif>
						<optgroup label="#request.content.type_se_matchdetails_selectbx_allteams#">
						<cfloop from="1" to="#ArrayLen(StructSort(stTeams,'textnocase','ASC','name'))#" index="idx">
							<option value="#stTeams[idx].id#"<cfif stMatch.team2.id EQ stTeams[idx].id AND NOT ListFind(lWinners,stTeams[idx].id)> selected</cfif>>#stTeams[idx].name#</option>
						</cfloop>
						</optgroup>
					</select>
				</div>
		
			</fieldset>
			
			<div class="buttonHolder">
				<button type="submit" class="submitButton">#request.content.type_se_matchdetails_saveassign#</button>
			</div>
		</form>
	<cfelse>
		<div style="float: left; width: 50%; text-align: center;">
			<cfset keyTeam = 'team1'>
				
			<cfif qTournament.teamsize EQ 1>
				<cfset sUrl = application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch[keyTeam].leaderid#')>
			<cfelse>
				<cfset sUrl = application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&teamid=#stMatch[keyTeam].id#&tournamentid=#qTournament.id#')>
			</cfif>
				
			<cfif stMatch.winner EQ keyTeam>
				<cfset sNamePre = '<strong>'>
				<cfset sNamePost = '</strong>'>
				<cfset teamstatus = request.content.type_se_status_team_won>
				<cfset image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_green.png'>
			<cfelse>
				<cfset sNamePre = ''>
				<cfset sNamePost = ''>
				<cfif len(stMatch.winner)>
					<cfset image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_red.png'>
					<cfset teamstatus = request.content.type_se_status_team_lost>
				<cfelse>
					<cfset image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_orange.png'>
					<cfset teamstatus = ''>
				</cfif>
			</cfif>

			#sNamePre#<cfif stMatch[keyTeam].id EQ 0>#request.content.unknown_team#<cfelse><a href="#sUrl#">#stMatch[keyTeam].name#</a></cfif>#sNamePost#<br>
			<img src="#image#" vspace="3" alt=""/><br/>
			#teamstatus#
		</div>
		<div style="float: left; width: 50%; text-align: center;">
			<cfset keyTeam = 'team2'>
				
			<cfif qTournament.teamsize EQ 1>
				<cfset sUrl = application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch[keyTeam].leaderid#')>
			<cfelse>
				<cfset sUrl = application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&teamid=#stMatch[keyTeam].id#&tournamentid=#qTournament.id#')>
			</cfif>
				
			<cfif stMatch.winner EQ keyTeam>
				<cfset sNamePre = '<strong>'>
				<cfset sNamePost = '</strong>'>
				<cfset teamstatus = request.content.type_se_status_team_won>
				<cfset image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_green.png'>
			<cfelse>
				<cfset sNamePre = ''>
				<cfset sNamePost = ''>
				<cfif len(stMatch.winner)>
					<cfset image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_red.png'>
					<cfset teamstatus = request.content.type_se_status_team_lost>
				<cfelse>
					<cfset image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_orange.png'>
					<cfset teamstatus = ''>
				</cfif>
			</cfif>

			#sNamePre#<cfif stMatch[keyTeam].id EQ 0>#request.content.unknown_team#<cfelse><a href="#sUrl#">#stMatch[keyTeam].name#</a></cfif>#sNamePost#<br>
			<img src="#image#" vspace="3" alt=""/><br/>
			#teamstatus#
		</div>
		<div class="clearer"></div>
	</cfif>

	<cfif stMatch.qResults.recordcount>
		<h4>#request.content.type_se_matchdetails_results#</h4>
		
		<cfif len(stMatch.checkedby_userid)>
			<p><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/accept.png" alt="" /> Ergebnisse sind von beiden Teams best&auml;tigt.</p>
		<cfelse>
			<p><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/error.png" alt="" /> #request.content.type_se_results_to_be_checked#</p>
		</cfif>
		
		<table class="vlist">
			<tr>
				<th></th>
				<td align="center">Team 1 : Team 2</td>
			</tr>
			<cfloop query="stMatch.qResults">
				<tr>
					<th>Round #stMatch.qResults.currentrow#</th>
					<td align="center">#team1_result# #request.content.type_se_resultdelimiter# #team2_result#</td>
				</tr>
			</cfloop>
		</table>

		<cfif ListFind('#stMatch.team1.id#,#stMatch.team2.id#',qTeamCurrentUser.id) AND qTeamCurrentUser.id NEQ stMatch.submittedby_teamid>
			<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
				<div class="hidden">
					<input type="hidden" name="form_submitted5" value="true"/>
					<input type="hidden" name="tournamentid" value="#qTournament.id#"/>
					<input type="hidden" name="matchid" value="#stMatch.id#"/>
				</div>
				
				<div class="buttonHolder">
					<button name="check1" type="submit" class="submitButton">#request.content.type_se_submit_results_check1#</button>
					<button name="check0" type="submit" class="cancelButton">#request.content.type_se_submit_results_check0#</button>
				</div>
			</form>
		</cfif>
	</cfif>

	<cfif (qTournament.status EQ 'playing' AND stMatch.status EQ 'play' AND ListFind('#stMatch.team1.id#,#stMatch.team2.id#',qTeamCurrentUser.id)) OR (session.oUser.checkPermissions('manage') AND stMatch.status EQ 'admincheck')>
		<form id="form_results" style="display: none;" action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm" onsubmit="return LANshock.Modules.oTournament.oTypeSE.checkResultsForm();">
			<div class="hidden">
				<input type="hidden" name="form_submitted4" value="true"/>
				<input type="hidden" name="tournamentid" value="#qTournament.id#"/>
				<input type="hidden" name="matchid" value="#stMatch.id#"/>
			</div>

			<fieldset class="inlineLabels">
				<legend>#request.content.type_se_matchdetails_results#</legend>

				<cfloop query="stMatch.qResults">
					<div class="ctrlHolder">
						<label for="dummyteams"><em>*</em> Round #stMatch.qResults.currentrow#</label>
						<input type="text" class="textInput" id="round_#stMatch.qResults.currentrow#_team1" name="round_#stMatch.qResults.currentrow#_team1" value="#stMatch.qResults.team1_result#" style="width: 50px;" maxlength="5"/>
						<span style="float: left;">#request.content.type_se_resultdelimiter#</span>
						<input type="text" class="textInput" id="round_#stMatch.qResults.currentrow#_team2" name="round_#stMatch.qResults.currentrow#_team2" value="#stMatch.qResults.team2_result#" style="width: 50px;" maxlength="5"/>
					</div>
				</cfloop>
				
				<cfif stMatch.qResults.recordcount LT qTournament.matchcount>
					<cfset iStart = stMatch.qResults.recordcount+1>
					<cfloop from="#iStart#" to="#qTournament.matchcount#" index="idx">
						<div class="ctrlHolder">
							<label for="dummyteams"><em>*</em> Round #idx#</label>
							<input type="text" class="textInput" id="round_#idx#_team1" name="round_#idx#_team1" value="" style="width: 50px;" maxlength="5"/>
							<span style="float: left;">#request.content.type_se_resultdelimiter#</span>
							<input type="text" class="textInput" id="round_#idx#_team2" name="round_#idx#_team2" value="" style="width: 50px;" maxlength="5"/>
						</div>
					</cfloop>
				</cfif>
		
			</fieldset>
			
			<div class="buttonHolder">
				<button type="submit" class="submitButton">#request.content.form_save#</button>
				<button type="reset" class="resetButton">#request.content.form_reset#</button>
				<button type="cancel" class="cancelButton" onclick="$('##form_results').toggle();$('##form_results_pre').toggle();return false;">#request.content.form_cancel#</button>
			</div>
		</form>

		<form id="form_results_pre" action="##" method="post" class="uniForm">
			<div class="buttonHolder">
				<button type="submit" class="submitButton" onclick="$('##form_results').toggle();$('##form_results_pre').toggle();return false;">#request.content.type_se_submit_results#</button>
			</div>
		</form>
	</cfif>

	<cfif qTournament.status EQ 'playing' AND session.oUser.checkPermissions('manage') AND stMatch.status EQ 'admincheck'>
		<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
			<div class="hidden">
				<input type="hidden" name="form_submitted3" value="true"/>
				<input type="hidden" name="tournamentid" value="#qTournament.id#"/>
				<input type="hidden" name="matchid" value="#stMatch.id#"/>
				<input type="hidden" name="winner" id="winner" value="team1"/>
			</div>

			<fieldset class="inlineLabels">
				<legend>#request.content.type_se_matchdetails_set_winner#</legend>
			</fieldset>
			
			<div class="buttonHolder">
				<button type="submit" class="submitButton" onclick="$('##winner').val('team1');"<!--- <cfif stMatch.winner EQ 'team1'> disabled="disabled"</cfif> --->>#request.content.type_se_matchdetails_team1_winner#</button>
				<button type="submit" class="resetButton" onclick="$('##winner').val('NULL');"<!--- <cfif NOT len(stMatch.winner)> disabled="disabled"</cfif> --->>#request.content.type_se_matchdetails_no_winner#</button>
				<button type="submit" class="submitButton" onclick="$('##winner').val('team2');"<!--- <cfif stMatch.winner EQ 'team2'> disabled="disabled"</cfif> --->>#request.content.type_se_matchdetails_team2_winner#</button>
			</div>
		</form>
	</cfif>

	<h4>#request.content.type_se_matchdetails_info#</h4>
	<table class="vlist">
		<tr>
			<th>#request.content.type_se_matchdetails_info_status#</th>
			<td><span style="color: <cfif qTournament.status EQ 'playing'>green<cfelse>red</cfif>">#request.content['tournament_status_' & qTournament.status]#</span></td>
		</tr>
		<tr>
			<th>#request.content.type_se_matchdetails_info_matchstatus#</th>
			<td>
				<cfswitch expression="#stMatch.status#">
					<cfcase value="empty"><span style="color: orange">#request.content.type_se_matchdetails_status_save_teams#</span></cfcase>
					<cfcase value="play"><span style="color: green">#request.content.type_se_matchdetails_status_playing#</span></cfcase>
					<cfcase value="admincheck"><span style="color: orange">#request.content.type_se_matchdetails_status_admincheck#</span></cfcase>
					<cfcase value="done"><span style="color: green">#request.content.type_se_matchdetails_status_done#</span></cfcase>
				</cfswitch>
			</td>
		</tr>
		<cfif qTournament.teamsize EQ 1>
			<tr>
				<th>#request.content.type_se_matchdetails_info_result1#</th>
				<td>
					<cfif len(stMatch.submittedby_userid)>
						<a style="color: green" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch.submittedby_userid#')#" title="#session.oUser.DateTimeFormat(stMatch.submittedby_dt)#">#application.lanshock.oHelper.GetUsernameByID(stMatch.submittedby_userid)#</a>
					<cfelse>
						<span style="color: orange">---</span>
					</cfif></td>
			</tr>
			<tr>
				<th>#request.content.type_se_matchdetails_info_result2#</th>
				<td>
					<cfif len(stMatch.checkedby_userid)>
						<a style="color: green" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch.checkedby_userid#')#" title="#session.oUser.DateTimeFormat(stMatch.checkedby_dt)#">#application.lanshock.oHelper.GetUsernameByID(stMatch.checkedby_userid)#</a>
					<cfelse>
						<span style="color: orange">---</span>
					</cfif></td>
			</tr>
		<cfelse>
			<tr>
				<th>#request.content.type_se_matchdetails_info_result1#</th>
				<td>
					<cfif len(stMatch.submittedby_userid)>
						<a style="color: green" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch.submittedby_userid#')#" title="#session.oUser.DateTimeFormat(stMatch.submittedby_dt)#">#application.lanshock.oHelper.GetUsernameByID(stMatch.submittedby_userid)#</a>
					<cfelse>
						<span style="color: orange">---</span>
					</cfif></td>
			</tr>
			<tr>
				<th>#request.content.type_se_matchdetails_info_result2#</th>
				<td>
					<cfif len(stMatch.checkedby_userid)>
						<a style="color: green" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch.checkedby_userid#')#" title="#session.oUser.DateTimeFormat(stMatch.checkedby_dt)#">#application.lanshock.oHelper.GetUsernameByID(stMatch.checkedby_userid)#</a>
					<cfelse>
						<span style="color: orange">---</span>
					</cfif></td>
			</tr>
		</cfif>
		<tr>
			<th>#request.content.type_se_matchdetails_info_result3#</th>
			<td>
				<cfif len(stMatch.checkedby_admin)>
					<a style="color: green" href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch.checkedby_admin#')#" title="#session.oUser.DateTimeFormat(stMatch.checkedby_admin_dt)#">#application.lanshock.oHelper.GetUsernameByID(stMatch.checkedby_admin)#</a>
				<cfelse>
					<span style="color: orange">---</span>
				</cfif></td>
		</tr>
	</table>
	
	#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">