<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_se_matchdetails.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.edit_results" default="false">

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
			<cfscript>
				keyTeam = 'team1';
				
				if(qTournament.teamsize EQ 1) sUrl = "#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch[keyTeam].leaderid#')#";
				else sUrl = "#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&teamid=#stMatch[keyTeam].id#&tournamentid=#qTournament.id#')#";
				
				if(stMatch.winner EQ keyTeam){
					sNamePre = '<strong>';
					sNamePost = '</strong>';
					teamstatus = request.content.type_se_status_team_won;
					image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_green.png';
				}
				else{
					sNamePre = '';
					sNamePost = '';
					if(len(stMatch.winner)){
						image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_red.png';
						teamstatus = request.content.type_se_status_team_lost;
					}
					else{
						image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_orange.png';
						teamstatus = '';
					}
				}
			</cfscript>
			#sNamePre#<cfif stMatch[keyTeam].id EQ 0>#request.content.unknown_team#<cfelse><a href="#sUrl#">#stMatch[keyTeam].name#</a></cfif>#sNamePost#<br>
			<img src="#image#" vspace="3"><br>
			#teamstatus#
		</div>
		<div style="float: left; width: 50%; text-align: center;">
			<cfscript>
				keyTeam = 'team2';
				
				if(qTournament.teamsize EQ 1) sUrl = "#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stMatch[keyTeam].leaderid#')#";
				else sUrl = "#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&teamid=#stMatch[keyTeam].id#&tournamentid=#qTournament.id#')#";
				
				if(stMatch.winner EQ keyTeam){
					sNamePre = '<strong>';
					sNamePost = '</strong>';
					teamstatus = request.content.type_se_status_team_won;
					image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_green.png';
				}
				else{
					sNamePre = '';
					sNamePost = '';
					if(len(stMatch.winner)){
						image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_red.png';
						teamstatus = request.content.type_se_status_team_lost;
					}
					else{
						image = '#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/bullet_orange.png';
						teamstatus = '';
					}
				}
			</cfscript>
			#sNamePre#<cfif stMatch[keyTeam].id EQ 0>#request.content.unknown_team#<cfelse><a href="#sUrl#">#stMatch[keyTeam].name#</a></cfif>#sNamePost#<br>
			<img src="#image#" vspace="3"><br>
			#teamstatus#
		</div>
		<div class="clearer"></div>
	</cfif>

	<cfif (qTournament.status EQ 'playing' AND stMatch.status EQ 'play' AND ListFind('#stMatch.team1.id#,#stMatch.team2.id#',qTeamCurrentUser.id)) OR (session.oUser.checkPermissions('manage') AND stMatch.status EQ 'admincheck')>
		<cfif attributes.edit_results>
			<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
				<div class="hidden">
					<input type="hidden" name="form_submitted4" value="true"/>
					<input type="hidden" name="tournamentid" value="#qTournament.id#"/>
					<input type="hidden" name="matchid" value="#stMatch.id#"/>
					<input type="hidden" name="edit_results" value="true"/>
				</div>
	
				<fieldset class="inlineLabels">
					<legend>#request.content.type_se_matchdetails_results#</legend>
					
					<cfset iResultCountOriginal = StructCount(stResults)>
					<cfloop from="1" to="#qTournament.matchcount#" index="idx">
						<cfscript>
							if(StructKeyExists(stResults,idx)){
								stResults[idx].team1_result = stResults[idx].team1_result;
								stResults[idx].team2_result = stResults[idx].team2_result;
							}
							else{
								stResults[idx] = StructNew();
								stResults[idx].team1_result = '';
								stResults[idx].team2_result = '';
							}
						</cfscript>
						<div class="ctrlHolder">
							<label for="dummyteams"><em>*</em> Round #idx#</label>
							<input type="text" class="textInput" name="round_#idx#_team1" value="#stResults[idx].team1_result#" style="width: 50px;"/>
							<span style="float: left;">#request.content.type_se_resultdelimiter#</span>
							<input type="text" class="textInput" name="round_#idx#_team2" value="#stResults[idx].team2_result#" style="width: 50px;"/>
						</div>
					</cfloop>
			
				</fieldset>
				
				<cfif iResultCountOriginal GTE qTournament.matchcount>
	
					<fieldset class="inlineLabels">
						<legend>#request.content.type_se_additional_rounds#</legend>
						
						<cfloop from="#qTournament.matchcount+1#" to="#StructCount(stResults)+1#" index="idx2">
							<cfscript>
								if(StructKeyExists(stResults,idx2)){
									stResults[idx2].team1_result = stResults[idx2].team1_result;
									stResults[idx2].team2_result = stResults[idx2].team2_result;
								}
								else{
									stResults[idx2] = StructNew();
									stResults[idx2].team1_result = '';
									stResults[idx2].team2_result = '';
								}
							</cfscript>
							<div class="ctrlHolder">
								<label for="dummyteams"><em>*</em> Round #idx2#</label>
								<input type="text" class="textInput" name="round_#idx2#_team1" value="#stResults[idx2].team1_result#" style="width: 50px;"/>
								<span style="float: left;">#request.content.type_se_resultdelimiter#</span>
								<input type="text" class="textInput" name="round_#idx2#_team2" value="#stResults[idx2].team2_result#" style="width: 50px;"/>
							</div>
						</cfloop>
				
					</fieldset>
					
				</cfif>
				
				<div class="buttonHolder">
					<button type="submit" class="submitButton" name="finish">#request.content.type_se_submit_results_finish#</button>
					<button type="submit" class="resetButton">#request.content.type_se_submit_results_more#</button>
				</div>
			</form>
		<cfelse>
			<cfif stMatch.results.recordcount>
				<h4>#request.content.type_se_matchdetails_results#</h4>
				
				<p>#request.content.type_se_results_to_be_checked#</p>
				
				<table class="vlist">
					<tr>
						<th></th>
						<td align="center">Team 1 : Team 2</td>
					</tr>
					<cfloop query="stMatch.results">
						<tr>
							<th>Round #stMatch.results.currentrow#</th>
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
			<cfelse>
				<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
					<div class="hidden">
						<input type="hidden" name="edit_results" value="true"/>
						<input type="hidden" name="tournamentid" value="#qTournament.id#"/>
						<input type="hidden" name="matchid" value="#stMatch.id#"/>
					</div>
					
					<div class="buttonHolder">
						<button type="submit" class="submitButton">#request.content.type_se_submit_results#</button>
					</div>
				</form>
			</cfif>
		</cfif>
	<cfelse>
		<h4>#request.content.type_se_matchdetails_results#</h4>
	
		<table class="vlist">
			<tr>
				<th></th>
				<td align="center">Team 1 : Team 2</td>
			</tr>
			<cfloop query="stMatch.results">
				<tr>
					<th>Round #stMatch.results.currentrow#</th>
					<td align="center">#team1_result# #request.content.type_se_resultdelimiter# #team2_result#</td>
				</tr>
			</cfloop>
		</table>
	</cfif>

	<cfif session.oUser.checkPermissions('manage') AND stMatch.status EQ 'admincheck'>
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
				<button type="submit" class="submitButton" onclick="$('##winner').val('team1');"<cfif stMatch.winner EQ 'team1'> disabled="disabled"</cfif>>#request.content.type_se_matchdetails_team1_winner#</button>
				<button type="submit" class="resetButton" onclick="$('##winner').val('');"<cfif NOT len(stMatch.winner)> disabled="disabled"</cfif>>#request.content.type_se_matchdetails_no_winner#</button>
				<button type="submit" class="submitButton" onclick="$('##winner').val('team2');"<cfif stMatch.winner EQ 'team2'> disabled="disabled"</cfif>>#request.content.type_se_matchdetails_team2_winner#</button>
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