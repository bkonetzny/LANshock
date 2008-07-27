<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_de_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfset iTeams = 2^Ceiling(LogN(qTournament.currentteams,2))>
<cfset iBrackets = iTeams>
<cfset iRowCount = 0>

<cfloop condition="#iBrackets# GTE 2">
	<cfset iRowCount = iRowCount + 1>
	<cfset iBrackets = iBrackets / 2>
</cfloop>

<cfset iRowCountL = (iRowCount - 1) * 2>
<cfset iBrackets = 1>

<cfif iTeams GT 2>
	<cfset iRowCount = iRowCount + 1>
</cfif>

<cfset iDivider = 1>

<cfoutput>
	<h4>#request.content.type_de_match_headline#</h4>

	<cfif session.oUser.checkPermissions('manage')
			OR (qTeamCurrentUser.recordcount AND NOT ListFindNoCase('signup,warmup',qTournament.status))>
		<ul class="options">
			<cfif session.oUser.checkPermissions('manage')>
				<cfif qTournament.status EQ 'warmup'>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&randomize_first_round=true')#">#request.content.type_de_match_randomize_first_round#</a></li>
				<cfelseif qTournament.status EQ 'playing'>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&calculateMatches=true')#">Paarungen berechnen</a></li>
				</cfif>
				<cfif NOT ListFindNoCase('signup,warmup',qTournament.status)>
					<li><a href="##" onclick="LANshock.Modules.oTournament.oTypeDE.showMatchStatus();return false;">#request.content.type_de_match_markstatus#</a></li>
				</cfif>
			</cfif>
			<cfif qTeamCurrentUser.recordcount AND NOT ListFindNoCase('signup,warmup',qTournament.status)>
				<li><a href="##" onclick="LANshock.Modules.oTournament.oTypeDE.markTeam('#qTeamCurrentUser.id#');return false;">#request.content.type_de_match_markteam#</a></li>
			</cfif>
		</ul>
	</cfif>
</cfoutput>

<cfif NOT StructIsEmpty(stHtmlMatches)>
	<cfif NOT application.lanshock.oCache.exists(sCacheKey)>
		<cfsavecontent variable="sMatchTree">
			<cfoutput>
				<cfif iTeams LTE 2>
					<!--- todo: restyle --->
					<table cellpadding="0" cellspacing="0" align="center">
						<tr>
							<td height="50">&nbsp;</td>
							<td style="border: 1px solid gray;" class="alternate" align="center" valign="middle" width="100" height="50">
								#stHtmlMatches['1_1']#
							</td>
							<td height="50">&nbsp;</td>
						</tr>
					</table>
				<cfelse>
					<!--- spacersettings --->
					<cfif iRowCountL LTE 2>
						<cfset spacerheight_top = 25>
					<cfelse>
						<cfset spacerheight_top = 50 * (iRowCountL - 2) / 2>
					</cfif>
					<cfset spacerheight_max = (iTeams / 2 + 1) * 50>

					<table cellpadding="0" cellspacing="0" class="match_plan">
						<tr>
							<cfloop from="1" to="#iRowCountL#" index="col">
								<!--- spacersettings --->
								<cfset top = true>
								<cfset key_loserbracket = iRowCountL-col+1>
								
								<cfif col GTE iRowCountL-1>
									<cfset spacerheight_top = 25>
								<cfelseif col MOD 2>
									<cfset spacerheight_top = 50 * (iRowCountL - col - 1) / 2>
								</cfif>
								
								<cfset spacerheight_middle = 0>
								
								<cfif iRowCountL GT 6 AND col GTE 3 AND key_loserbracket GTE 5>
									<cfset spacerheight_middle = spacerheight_top - 50>
								</cfif>
								
								<cfif NOT col MOD 2>
									<cfset multiplicator = 2>
								<cfelse>
									<cfset multiplicator = 1>
								</cfif>
								
								<cfif key_loserbracket LTE 4>
									<cfset spacerheight = 25 * key_loserbracket - 25>
								<cfelse>
									<cfset spacerheight = (spacerheight_max - spacerheight_top - (spacerheight_middle * (iBrackets - 1)) - (iBrackets * 50 * multiplicator)) / (iBrackets * 2)>
								</cfif>
								<td valign="top">
									<div class="rowheader">
										#request.content.type_de_match_key_loserbracket# #key_loserbracket#
									</div>
									<table cellpadding="0" cellspacing="0" class="match_row<cfif col MOD 2> match_row_odd<cfelse> match_row_even</cfif>">
										<tr>
											<td>
												<table cellpadding="0" cellspacing="0" class="match">
													<tr>
														<td colspan="3" style="height: #spacerheight_top#px;"></td>
													</tr>
													<cfloop from="1" to="#iBrackets#" index="row">
														<cfif col NEQ iRowCountL>
															<tr>
																<td class="decorator_l"><cfif col MOD 2 AND NOT top><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"/></cfif></td>
																<td colspan="2" style="height: #spacerheight#px;"></td>
															</tr>
														</cfif>
														<tr class="match_container">
															<td class="decorator_l"><cfif iDivider GT 1><cfif top OR NOT col MOD 2><img src="#stImageDir.module#/type_de/top_right.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"/><cfelse><img src="#stImageDir.module#/type_de/bottom_right.gif" width="8" height="50" alt="" border="0"/></cfif></cfif></td>
															<td class="match_box match_box_status_">
																#stHtmlMatches['#col#_#row#']#
															</td>
															<td class="decorator"><img src="#stImageDir.module#/type_de/middle.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"/></td>
														</tr>
														<cfif NOT col MOD 2>
															<tr>
																<td class="decorator_l"><img src="#stImageDir.module#/type_de/bottom_right.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"/></td>
																<td colspan="2" style="height: #spacerheight#px;" class="hint_l">#request.content.type_de_match_loser_from# #request.content.type_de_match_key_winnerbracket# #iRowCount-col/2-1#.#iBrackets+1-row#</td>
															</tr>
														</cfif>
														<cfif col NEQ iRowCountL>
															<tr>
																<td class="decorator_l"><cfif col MOD 2 AND top AND col NEQ 1><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"/></cfif></td>
																<td colspan="2" style="height: #spacerheight#px;"></td>
															</tr>
														</cfif>
														<cfif spacerheight_middle GT 0>
															<tr>
																<td class="decorator_l"><cfif col MOD 2 AND top AND col NEQ 1><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight_middle#" alt="" border="0" vspace="0" hspace="0"/></cfif></td>
																<td colspan="2" style="height: #spacerheight_middle#px;"></td>
															</tr>
														</cfif>
														<!--- spacersettings --->
														<cfif top>
															<cfset top = false>
														<cfelse>
															<cfset top = true>
														</cfif>
													</cfloop>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<cfif NOT col MOD 2>
									<cfset iBrackets = iBrackets * 2>
								</cfif>
								<!--- spacersettings --->
								<cfif iDivider EQ 1>
									<cfset iDivider = 2>
								<cfelse>
									<cfset iDivider = iDivider * 2>
								</cfif>
							</cfloop>
							
							<!--- Winner Bracket --->
							
							<!--- defaults for winner bracket --->
							<!--- spacersettings --->
							<cfset iDivider = 1>
							<cfset iBrackets = iTeams / 2>
							
							<cfloop from="1" to="#iRowCount#" index="col">
								<!--- spacersettings --->
								<cfset top = true>
								<cfif col LT 3>
									<cfset spacerheight = 25>
								<cfelseif col EQ iRowCount>
									<cfset spacerheight = spacerheight + 25>
								<cfelse>
									<cfset spacerheight = (spacerheight * 2) + 25>
								</cfif>
								<cfif col EQ iRowCount>
									<cfset iBrackets = 1>
								</cfif>
								<td valign="top">
									<div class="rowheader">
										#request.content.type_de_match_key_winnerbracket# #col-1#
									</div>
									<table cellpadding="0" cellspacing="0" class="match_row<cfif col MOD 2> match_row_odd<cfelse> match_row_even</cfif>">
										<tr>
											<td>
												<table cellpadding="0" cellspacing="0" class="match">
													<cfloop from="1" to="#iBrackets#" index="row">
														<cfif iDivider gt 1>
															<tr>
																<td colspan="2" style="height: #spacerheight#px;" class="hint_matchtitle"><cfif col NEQ iRowCount>#request.content.type_de_match_key_winnerbracket# #col-1#.#row#</cfif></td>
																<td class="decorator"><cfif not top><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"/></cfif></td>
															</tr>
														</cfif>
														<tr class="match_container">
															<td class="decorator"><cfif iRowCountL GT 0><cfif iDivider GT 1><img src="#stImageDir.module#/type_de/middle.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"/><cfelseif top><img src="#stImageDir.module#/type_de/top_right.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"/><cfelse><img src="#stImageDir.module#/type_de/bottom_right.gif" width="8" height="50" alt="" border="0"/></cfif></cfif></td>
															<td class="match_box match_box_status_">
																#stHtmlMatches['#col+iRowCountL#_#row#']#
															</td>
															<td class="decorator"><cfif col NEQ iRowCount><cfif top><img src="#stImageDir.module#/type_de/top_left.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"/><cfelse><img src="#stImageDir.module#/type_de/bottom_left.gif" width="8" height="50" alt="" border="0"/></cfif></cfif></td>
														</tr>
														<cfif col EQ iRowCount-1>
															<tr>
																<td colspan="2" style="height: 50px;" class="hint_w">#request.content.type_de_match_winner_from#</td>
																<td class="decorator"><img src="#stImageDir.module#/type_de/bottom_left.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"></td>
															</tr>
														</cfif>
														<cfif iDivider gt 1 AND col NEQ iRowCount>
															<tr>
																<td colspan="2" style="height: #spacerheight#px;"></td>
																<td class="decorator"><cfif top AND col EQ iRowCount><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"/></cfif><cfif top AND col NEQ iRowCount-1 AND col NEQ iRowCount><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"/></cfif></td>
															</tr>
														</cfif>
														<!--- spacersettings --->
														<cfif top>
															<cfset top = false>
														<cfelse>
															<cfset top = true>
														</cfif>
													</cfloop>
												</table>
											</td>
										</tr>
									</table>
								</td>
								<cfset iBrackets = iBrackets / 2>
								<!--- spacersettings --->
								<cfif iDivider EQ 1>
									<cfset iDivider = 2>
								<cfelse>
									<cfset iDivider = iDivider * 2>
								</cfif>
							</cfloop>
						</tr>
					</table>
				</cfif>
			</cfoutput>
		</cfsavecontent>
	
		<cfset application.lanshock.oCache.set(sCacheKey,sMatchTree)>
	</cfif>
	
	<cfoutput>
		#application.lanshock.oCache.get(sCacheKey)#
	</cfoutput>
	
	<!--- todo: enable caching --->
	<cfset application.lanshock.oCache.drop(sCacheKey)>
</cfif>

<cfsetting enablecfoutputonly="No">