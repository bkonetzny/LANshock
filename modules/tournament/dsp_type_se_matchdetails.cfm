<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.edit_results" default="false">

<cfoutput>
	<div class="headline2">#request.content.type_se_matchdetails_headline#</div>
	<table align="center" width="80%">
		<cfif stMatch.status EQ 'empty' AND request.session.isAdmin>
			<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" method="post">
				<input type="hidden" name="matchid" value="#stMatch.id#">
				<input type="hidden" name="form_submitted" value="true">
				<tr>
					<td align="center"><select name="team1">
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
									<option value="#stTeams[idx].id#"<cfif stMatch.team1.id EQ stTeams[idx].id> selected</cfif>><cfif qTournament.teamsize EQ 1>#stTeams[idx].leadername#<cfelse>#stTeams[idx].name#</cfif></option>
								</cfif>
							</cfloop>
							</optgroup>
						</cfif>
						<optgroup label="#request.content.type_se_matchdetails_selectbx_allteams#">
						<cfloop from="1" to="#ArrayLen(StructSort(stTeams,'textnocase','ASC','name'))#" index="idx">
							<option value="#stTeams[idx].id#"<cfif stMatch.team1.id EQ stTeams[idx].id AND NOT ListFind(lWinners,stTeams[idx].id)> selected</cfif>>#stTeams[idx].name#</option>
						</cfloop>
						</optgroup>
					</select></td>
					<td align="center"><select name="team2">
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
									<option value="#stTeams[idx].id#"<cfif stMatch.team2.id EQ stTeams[idx].id> selected</cfif>><cfif qTournament.teamsize EQ 1>#stTeams[idx].leadername#<cfelse>#stTeams[idx].name#</cfif></option>
								</cfif>
							</cfloop>
							</optgroup>
						</cfif>
						<optgroup label="#request.content.type_se_matchdetails_selectbx_allteams#">
						<cfloop from="1" to="#ArrayLen(StructSort(stTeams,'textnocase','ASC','name'))#" index="idx">
							<option value="#stTeams[idx].id#"<cfif stMatch.team2.id EQ stTeams[idx].id AND NOT ListFind(lWinners,stTeams[idx].id)> selected</cfif>>#stTeams[idx].name#</option>
						</cfloop>
						</optgroup>
					</select></td>
				</tr>
				<tr>
					<td align="center" colspan="2"><input type="submit" value="#request.content.type_se_matchdetails_saveassign#"></td>
				</tr>
			</form>
		<cfelse>
			<tr>
				<td align="center" width="50%">
					<cfscript>
						keyTeam = 'team1';
						
						if(qTournament.teamsize EQ 1) sUrl = '#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stMatch[keyTeam].leaderid#&#request.session.UrlToken#';
						else sUrl = '#myself##myfusebox.thiscircuit#.team_details&teamid=#stMatch[keyTeam].id#&tournamentid=#qTournament.id#&#request.session.urltoken#';
						
						if(stMatch.winner EQ keyTeam){
							sNamePre = '<strong>';
							sNamePost = '</strong>';
							teamstatus = request.content.type_se_status_team_won;
							image = '#stImageDir.general#/status_led_green.gif';
						}
						else{
							sNamePre = '';
							sNamePost = '';
							if(len(stMatch.winner)){
								image = '#stImageDir.general#/status_led_red.gif';
								teamstatus = request.content.type_se_status_team_lost;
							}
							else{
								image = '#stImageDir.general#/status_led_orange.gif';
								teamstatus = '';
							}
						}
					</cfscript>
					#sNamePre#<cfif stMatch[keyTeam].id EQ 0>#request.content.unknown_team#<cfelse><a href="#sUrl#">#stMatch[keyTeam].name#</a></cfif>#sNamePost#<br>
					<img src="#image#" vspace="3"><br>
					#teamstatus#
					</td>
				<td align="center" width="50%">
					<cfscript>
						keyTeam = 'team2';
						
						if(qTournament.teamsize EQ 1) sUrl = '#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stMatch[keyTeam].leaderid#&#request.session.UrlToken#';
						else sUrl = '#myself##myfusebox.thiscircuit#.team_details&teamid=#stMatch[keyTeam].id#&tournamentid=#qTournament.id#&#request.session.urltoken#';
						
						if(stMatch.winner EQ keyTeam){
							sNamePre = '<strong>';
							sNamePost = '</strong>';
							teamstatus = request.content.type_se_status_team_won;
							image = '#stImageDir.general#/status_led_green.gif';
						}
						else{
							sNamePre = '';
							sNamePost = '';
							if(len(stMatch.winner)){
								image = '#stImageDir.general#/status_led_red.gif';
								teamstatus = request.content.type_se_status_team_lost;
							}
							else{
								image = '#stImageDir.general#/status_led_orange.gif';
								teamstatus = '';
							}
						}
					</cfscript>
					#sNamePre#<cfif stMatch[keyTeam].id EQ 0>#request.content.unknown_team#<cfelse><a href="#sUrl#">#stMatch[keyTeam].name#</a></cfif>#sNamePost#<br>
					<img src="#image#" vspace="3"><br>
					#teamstatus#
					</td>
			</tr>
		</cfif>
		<tr>
			<td colspan="2" align="center">
				&nbsp;<br>
				<table>
					<tr>
						<td valign="top">
							<fieldset>
								<legend>#request.content.type_se_matchdetails_info#</legend>
								<table width="100%">
									<tr>
										<td>#request.content.type_se_matchdetails_info_status#</td>
										<td align="center"><span style="color: <cfif qTournament.status EQ 'playing'>green<cfelse>red</cfif>">#request.content['tournament_status_' & qTournament.status]#</span></td>
									</tr>
									<tr>
										<td>#request.content.type_se_matchdetails_info_matchstatus#</td>
										<td align="center">
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
											<td>#request.content.type_se_matchdetails_info_result1#</td>
											<td align="center">
												<cfif len(stMatch.submittedby_userid)>
													<a style="color: green" href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stMatch.submittedby_userid#&#request.session.UrlToken#" title="#UDF_DateTimeFormat(stMatch.submittedby_dt)#">#GetUsernameByID(stMatch.submittedby_userid)#</a>
												<cfelse>
													<span style="color: orange">---</span>
												</cfif></td>
										</tr>
										<tr>
											<td>#request.content.type_se_matchdetails_info_result2#</td>
											<td align="center">
												<cfif len(stMatch.checkedby_userid)>
													<a style="color: green" href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stMatch.checkedby_userid#&#request.session.UrlToken#" title="#UDF_DateTimeFormat(stMatch.checkedby_dt)#">#GetUsernameByID(stMatch.checkedby_userid)#</a>
												<cfelse>
													<span style="color: orange">---</span>
												</cfif></td>
										</tr>
									<cfelse>
										<tr>
											<td>#request.content.type_se_matchdetails_info_result1#</td>
											<td align="center">
												<cfif len(stMatch.submittedby_userid)>
													<a style="color: green" href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stMatch.submittedby_userid#&#request.session.UrlToken#" title="#UDF_DateTimeFormat(stMatch.submittedby_dt)#">#GetUsernameByID(stMatch.submittedby_userid)#</a>
												<cfelse>
													<span style="color: orange">---</span>
												</cfif></td>
										</tr>
										<tr>
											<td>#request.content.type_se_matchdetails_info_result2#</td>
											<td align="center">
												<cfif len(stMatch.checkedby_userid)>
													<a style="color: green" href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stMatch.checkedby_userid#&#request.session.UrlToken#" title="#UDF_DateTimeFormat(stMatch.checkedby_dt)#">#GetUsernameByID(stMatch.checkedby_userid)#</a>
												<cfelse>
													<span style="color: orange">---</span>
												</cfif></td>
										</tr>
									</cfif>
									<tr>
										<td>#request.content.type_se_matchdetails_info_result3#</td>
										<td align="center">
											<cfif len(stMatch.checkedby_admin)>
												<a style="color: green" href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stMatch.checkedby_admin#&#request.session.UrlToken#" title="#UDF_DateTimeFormat(stMatch.checkedby_admin_dt)#">#GetUsernameByID(stMatch.checkedby_admin)#</a>
											<cfelse>
												<span style="color: orange">---</span>
											</cfif></td>
									</tr>
								</table>
							</fieldset>
						</td>
						<cfif request.session.isAdmin>
							<td valign="top">
								<fieldset>
									<legend>#request.content.type_se_matchdetails_statuschange#</legend>
									<cfset urlstring = '#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#stMatch.id#&form_submitted2=true&#request.session.urltoken#&status='>
									<table width="100%">
										<tr>
											<td>
												<cfif stMatch.status EQ 'empty'>
													<strong class="link_extended">#request.content.type_se_matchdetails_status_save_teams#</strong>
												<cfelse>
													<a href="#urlstring#empty" class="link_extended">#request.content.type_se_matchdetails_status_save_teams#</a>
												</cfif>
											</td>
										</tr>
										<tr>
											<td>
												<cfif stMatch.status EQ 'play'>
													<strong class="link_extended">#request.content.type_se_matchdetails_status_playing#</strong>
												<cfelse>
													<a href="#urlstring#play" class="link_extended">#request.content.type_se_matchdetails_status_playing#</a>
												</cfif>
											</td>
										</tr>
										<tr>
											<td>
												<cfif stMatch.status EQ 'admincheck'>
													<strong class="link_extended">#request.content.type_se_matchdetails_status_admincheck#</strong>
												<cfelse>
													<a href="#urlstring#admincheck" class="link_extended">#request.content.type_se_matchdetails_status_admincheck#</a>
												</cfif>
											</td>
										</tr>
										<tr>
											<td>
												<cfif stMatch.status EQ 'done'>
													<strong class="link_extended">#request.content.type_se_matchdetails_status_done#</strong>
												<cfelse>
													<a href="#urlstring#done" class="link_extended">#request.content.type_se_matchdetails_status_done#</a>
												</cfif>
											</td>
										</tr>
										<tr>
											<td><a href="#urlstring#reset" class="link_extended">#request.content.type_se_matchdetails_status_reset#</a></td>
										</tr>
									</table>
								</fieldset>
							</td>
						</cfif>
					</tr>
				</table>
			</td>
		</tr>
		<cfif request.session.isAdmin AND stMatch.status EQ 'admincheck'>
			<tr>
				<td colspan="2" align="center"><br>&nbsp;<br>#request.content.type_se_matchdetails_set_winner#
					<table>
						<tr>
							<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" method="post">
							<input type="hidden" name="matchid" value="#stMatch.id#">
							<input type="hidden" name="form_submitted3" value="true">
							<input type="hidden" name="winner" value="team1">
							<td align="center"><input type="submit" value="#request.content.type_se_matchdetails_team1_winner#"<cfif stMatch.winner EQ 'team1'> disabled</cfif>></td>
							</form>
							<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" method="post">
							<input type="hidden" name="matchid" value="#stMatch.id#">
							<input type="hidden" name="form_submitted3" value="true">
							<input type="hidden" name="winner" value="">
							<td align="center"><input type="submit" value="#request.content.type_se_matchdetails_no_winner#"<cfif NOT len(stMatch.winner)> disabled</cfif>></td>
							</form>
							<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" method="post">
							<input type="hidden" name="matchid" value="#stMatch.id#">
							<input type="hidden" name="form_submitted3" value="true">
							<input type="hidden" name="winner" value="team2">
							<td align="center"><input type="submit" value="#request.content.type_se_matchdetails_team2_winner#"<cfif stMatch.winner EQ 'team2'> disabled</cfif>></td>
							</form>
						</tr>
					</table>
				</td>
			</tr>
		</cfif>
		<tr>
			<td colspan="2" align="center"><div class="headline2">#request.content.type_se_matchdetails_results#</div></td>
		</tr>
		<cfif (qTournament.status EQ 'playing' AND stMatch.status EQ 'play' AND ListFind('#stMatch.team1.id#,#stMatch.team2.id#',qTeamCurrentUser.id)) OR (request.session.isAdmin AND stMatch.status EQ 'admincheck')>
			<cfif attributes.edit_results>
				<tr>
					<td colspan="2" align="center">
						<table>
							<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" method="post">
							<input type="hidden" name="form_submitted4" value="true">
							<input type="hidden" name="matchid" value="#stMatch.id#">
							<input type="hidden" name="edit_results" value="true">
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
								<tr>
									<td align="right"><input type="text" name="round_#idx#_team1" value="#stResults[idx].team1_result#" style="width: 50px;"></td>
									<td align="center">#request.content.type_se_resultdelimiter#</td>
									<td><input type="text" name="round_#idx#_team2" value="#stResults[idx].team2_result#" style="width: 50px;"></td>
								</tr>
							</cfloop>
							
							<cfif iResultCountOriginal GTE qTournament.matchcount>
								<tr>
									<td colspan="3" align="center">#request.content.type_se_additional_rounds#</td>
								</tr>
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
									<tr>
										<td align="right"><input type="text" name="round_#idx2#_team1" value="#stResults[idx2].team1_result#" style="width: 50px;"></td>
										<td align="center">#request.content.type_se_resultdelimiter#</td>
										<td><input type="text" name="round_#idx2#_team2" value="#stResults[idx2].team2_result#" style="width: 50px;"></td>
									</tr>
								</cfloop>
							</cfif>
							<tr>
								<td colspan="3" align="center">&nbsp;<br><input type="submit" value="#request.content.type_se_submit_results_more#"></td>
							</tr>
							<tr>
								<td colspan="3" align="center">&nbsp;<br><input type="submit" name="finish" value="#request.content.type_se_submit_results_finish#"></td>
							</tr>
							</form>
						</table>
					</td>
				</tr>
			<cfelse>
				<cfif stMatch.results.recordcount>
					<tr>
						<td colspan="2" align="center">#request.content.type_se_results_to_be_checked#</td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<table>
								<cfloop query="stMatch.results">
									<tr>
										<td align="right">#team1_result#</td>
										<td>#request.content.type_se_resultdelimiter#</td>
										<td>#team2_result#</td>
									</tr>
								</cfloop>
							</table>
						</td>
					</tr>
					<cfif ListFind('#stMatch.team1.id#,#stMatch.team2.id#',qTeamCurrentUser.id) AND qTeamCurrentUser.id NEQ stMatch.submittedby_teamid>
						<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" method="post">
						<input type="hidden" name="form_submitted5" value="true">
						<input type="hidden" name="matchid" value="#stMatch.id#">
						<tr>
							<td colspan="2" align="center">&nbsp;<br><input type="submit" name="check1" value="#request.content.type_se_submit_results_check1#"> <input type="submit" name="check0" value="#request.content.type_se_submit_results_check0#"></td>
						</tr>
						</form>
					</cfif>
				<cfelse>
					<tr>
						<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" method="post">
						<input type="hidden" name="edit_results" value="true">
						<input type="hidden" name="matchid" value="#stMatch.id#">
						<td colspan="2" align="center">
							<input type="submit" value="#request.content.type_se_submit_results#">
						</td>
						</form>
					</tr>
				</cfif>
			</cfif>
		</cfif>
		<cfif stMatch.status EQ 'done' OR (stMatch.status EQ 'play' AND request.session.isAdmin)>
			<tr>
				<td colspan="2" align="center">
					<table>
						<cfloop query="stMatch.results">
							<tr>
								<td align="right">#team1_result#</td>
								<td>#request.content.type_se_resultdelimiter#</td>
								<td>#team2_result#</td>
							</tr>
						</cfloop>
					</table>
				</td>
			</tr>
		</cfif>
	</table>
	
	#stComments.html#
</cfoutput>

<cfsetting enablecfoutputonly="No">