<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_se_match.cfm $
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
	
<cfset iBrackets = iTeams / 2>
<cfset iDivider = 1>

<cfoutput>	
	<h4>#request.content.type_se_match_headline#</h4>

	<cfif session.oUser.checkPermissions('manage')
			OR (qTeamCurrentUser.recordcount AND NOT ListFindNoCase('signup,warmup',qTournament.status))>
		<ul class="options">
			<cfif session.oUser.checkPermissions('manage')>
				<cfif qTournament.status EQ 'warmup'>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&randomize_first_round=true')#">#request.content.type_se_match_randomize_first_round#</a></li>
				<cfelseif qTournament.status EQ 'playing'>
					<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&calculateMatches=true')#">Paarungen berechnen</a></li>
				</cfif>
				<cfif NOT ListFindNoCase('signup,warmup',qTournament.status)>
					<li><a href="##" onclick="LANshock.Modules.oTournament.oTypeSE.showMatchStatus();return false;">#request.content.type_se_match_markstatus#</a></li>
				</cfif>
			</cfif>
			<cfif qTeamCurrentUser.recordcount AND NOT ListFindNoCase('signup,warmup',qTournament.status)>
				<li><a href="##" onclick="LANshock.Modules.oTournament.oTypeSE.markTeam('#qTeamCurrentUser.id#');return false;">#request.content.type_se_match_markteam#</a></li>
			</cfif>
		</ul>
	</cfif>
</cfoutput>

<cfif NOT StructIsEmpty(stHtmlMatches)>
	<cfif NOT application.lanshock.oCache.exists(sCacheKey)>
		<cfsavecontent variable="sMatchTree">
			<cfoutput>
			<table cellpadding="0" cellspacing="0" class="match_plan">
				<tr>
					<cfloop from="1" to="#iRowCount#" index="col">
						<!--- spacersettings --->
						<cfset top = true>
						<cfif col LT 3>
							<cfset spacerheight = 25>
						<!--- <cfelseif col EQ iRowCount>
							<cfset spacerheight = spacerheight + 25> --->
						<cfelse>
							<cfset spacerheight = (spacerheight * 2) + 25>
						</cfif>
						<td valign="top">
							<div class="rowheader">
								#request.content.type_se_match_key_winnerbracket# #col-1#
							</div>
							<table cellpadding="0" cellspacing="0" class="match_row<cfif col MOD 2> match_row_odd<cfelse> match_row_even</cfif>">
								<tr>
									<td>
										<table cellpadding="0" cellspacing="0" class="match">
											<cfloop from="1" to="#iBrackets#" index="row">
												<cfif iDivider GT 1>
													<tr>
														<td colspan="2" style="height: #spacerheight#px;"></td>
														<td class="decorator"><cfif NOT top><img src="#stImageDir.module#/type_se/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"/></cfif></td>
													</tr>
												</cfif>
												<tr class="match_container">
													<td class="decorator"><cfif iDivider GT 1><img src="#stImageDir.module#/type_se/middle.gif" width="8" height="50" alt="" border="0"/></cfif></td>
													<td class="match_box">
														#stHtmlMatches['#col#_#row#']#
													</td>
													<td class="decorator"><cfif col NEQ iRowCount><cfif top><img src="#stImageDir.module#/type_se/top_left.gif" width="8" height="50" alt="" border="0"/><cfelse><img src="#stImageDir.module#/type_se/bottom_left.gif" width="8" height="50" alt="" border="0"/></cfif></cfif></td>
												</tr>
												<cfif iDivider GT 1>
													<tr>
														<td colspan="2" style="height: #spacerheight#px;"></td>
														<td class="decorator"><cfif top AND col EQ iRowCount-1><img src="#stImageDir.module#/type_se/px.gif" width="1" height="#spacerheight#" alt=""/></cfif><cfif top AND col NEQ iRowCount-1 AND col NEQ iRowCount><img src="#stImageDir.module#/type_se/px.gif" width="1" height="#spacerheight#" alt=""/></cfif></td>
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