<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	iTeams = qTournament.currentteams;
	iTeams = 2^Ceiling(LogN(iTeams,2));
	iBrackets = iTeams;
	iRowCount = 0;
	
	while(iBrackets GTE 2){
		iRowCount = iRowCount + 1;
		iBrackets = iBrackets / 2;
	}

	iRowCountL = (iRowCount - 1) * 2;
	iBrackets = 1;
	if(iTeams GT 2) iRowCount = iRowCount + 1;
	
	// spacersettings
	iDivider = 1;
	
	// rendersettings
	bRefreshView = 0;
</cfscript>

<cfoutput>
	<div class="headline2">#request.content.type_de_match_headline#</div>
	<cfif request.session.isAdmin>
		<div align="center">
			<cfif qTournament.status EQ 'warmup'>
				<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&randomize_first_round=true&tournamentid=#qTournament.id#&#request.session.urltoken#" class="link_extended">#request.content.type_de_match_randomize_first_round#</a><br>
			</cfif>
			<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&showstatus=false&tournamentid=#qTournament.id#&#request.session.urltoken#" class="link_extended">#request.content.type_de_match_markstatus#</a><br>
		</div>
	</cfif>
	<cfif qTeamCurrentUser.recordcount>
		<div align="center"><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&markteam=#qTeamCurrentUser.id#&tournamentid=#qTournament.id#&#request.session.urltoken#" class="link_extended">#request.content.type_de_match_markteam#</a></div>
	</cfif>
	<br><br>

	<cfif iTeams LTE 2>
		<table cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td height="50">&nbsp;</td>
				<td style="border: 1px solid gray;" class="alternate" align="center" valign="middle" width="100" height="50">
					<cfset keyCurrentRowCol = '1_1'>
					<cfif StructKeyExists(stHtmlMatches,keyCurrentRowCol)>
						#stHtmlMatches[keyCurrentRowCol]#
					<cfelse>
						#stHtmlMatches['blank']#
						<cfinvoke component="type_de" method="createMatch">
							<cfinvokeargument name="tournamentid" value="#qTournament.id#">
							<cfinvokeargument name="col" value="1">
							<cfinvokeargument name="row" value="1">
						</cfinvoke>
						<cfset bRefreshView = 1>
					</cfif>
				</td>
				<td height="50">&nbsp;</td>
			</tr>
		</table>
	<cfelse>
		<table cellpadding="0" cellspacing="0" align="center">
			<tr>
				<!--- spacersettings --->
				<cfscript>
					if(iRowCountL LTE 2) spacerheight_top = 25;
					else spacerheight_top = 50 * (iRowCountL - 2) / 2;
					
					spacerheight_max = (iTeams / 2 + 1) * 50;
				</cfscript>
				<cfloop from="1" to="#iRowCountL#" index="col">
					<!--- spacersettings --->
					<cfscript>
						top = true;
						key_loserbracket = iRowCountL-col+1;
											
						if(col GTE iRowCountL-1) spacerheight_top = 25;
						else if(col MOD 2) spacerheight_top = 50 * (iRowCountL - col - 1) / 2;
						
						spacerheight_middle = 0;
						
						if(iRowCountL GT 6 AND col GTE 3 AND key_loserbracket GTE 5) spacerheight_middle = spacerheight_top - 50;
						
						if(NOT col MOD 2) multiplicator = 2;
						else multiplicator = 1;
						
						if(key_loserbracket LTE 4) spacerheight = 25 * key_loserbracket - 25;
						else spacerheight = (spacerheight_max - spacerheight_top - (spacerheight_middle * (iBrackets - 1)) - (iBrackets * 50 * multiplicator)) / (iBrackets * 2);
					</cfscript>
					<td valign="top">
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>#request.content.type_de_match_key_loserbracket# #key_loserbracket#<br>
									<img src="#stImageDir.general#/spacer.gif" width="110" height="0" alt="" border="0" vspace="0" hspace="0"></td>
							</tr>
							<tr>
								<td>
									<table cellpadding="0" cellspacing="0">
										<tr>
											<td>&nbsp;</td>
											<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight_top#" alt="" border="0" vspace="0" hspace="0"></td>
											<td>&nbsp;</td>
										</tr>
										<cfloop from="1" to="#iBrackets#" index="row">
											<cfif col NEQ iRowCountL>
												<tr>
													<td><cfif col MOD 2 AND NOT top><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
													<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></td>
													<td>&nbsp;</td>
												</tr>
											</cfif>
											<tr>
												<td height="50"><cfif iDivider GT 1><cfif top OR NOT col MOD 2><img src="#stImageDir.module#/type_de/top_right.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"><cfelse><img src="#stImageDir.module#/type_de/bottom_right.gif" width="8" height="50" alt="" border="0"></cfif></cfif></td>
												<td style="border: 1px solid gray;" class="alternate" align="center" valign="middle" width="100" height="50">
													<cfset keyCurrentRowCol = '#col#_#row#'>
													<cfif StructKeyExists(stHtmlMatches,keyCurrentRowCol)>
														#stHtmlMatches[keyCurrentRowCol]#
													<cfelse>
														#stHtmlMatches['blank']#
														<cfinvoke component="type_de" method="createMatch">
															<cfinvokeargument name="tournamentid" value="#qTournament.id#">
															<cfinvokeargument name="col" value="#col#">
															<cfinvokeargument name="row" value="#row#">
														</cfinvoke>
														<cfset bRefreshView = 1>
													</cfif>
												</td>
												<td height="50"><img src="#stImageDir.module#/type_de/middle.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"></td>
											</tr>
											<cfif NOT col MOD 2>
												<tr>
													<td height="50"><img src="#stImageDir.module#/type_de/bottom_right.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"></td>
													<td valign="middle" align="center" width="100" height="50">
														<span style="color: gray; font-size: 10px;">#request.content.type_de_match_loser_from# #request.content.type_de_match_key_winnerbracket# #iRowCount-col/2-1#.#iBrackets+1-row#</span>
													</td>
													<td height="50">&nbsp;</td>
												</tr>
											</cfif>
											<cfif col NEQ iRowCountL>
												<tr>
													<td><cfif col MOD 2 AND top AND col NEQ 1><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
													<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></td>
													<td>&nbsp;</td>
												</tr>
											</cfif>
											<cfif spacerheight_middle GT 0>
											<tr>
												<td><cfif col MOD 2 AND top AND col NEQ 1><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight_middle#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
												<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight_middle#" alt="" border="0" vspace="0" hspace="0"></td>
												<td>&nbsp;</td>
											</tr>
											</cfif>
											<!--- spacersettings --->
											<cfscript>
												if(top) top = false;
												else top = true;
											</cfscript>
										</cfloop>
										<!--- spacersettings --->
										<cfscript>
											if(iDivider EQ 1) iDivider = 2;
											else iDivider = iDivider * 2;
										</cfscript>
									</table>
								</td>
							</tr>
						</table>
						</td>
						<cfif NOT col MOD 2>
							<cfset iBrackets = iBrackets * 2>
						</cfif>
				</cfloop>
				
				<!--- Winner Bracket --->
				
				<!--- defaults for winner bracket --->
				<cfscript>
					// spacersettings
					iDivider = 1;
					iBrackets = iTeams / 2;
				</cfscript>
				
				<cfloop from="1" to="#iRowCount#" index="col">
					<td valign="top">
						<!--- spacersettings --->
						<cfscript>
							top = true;
							if(col LT 3) spacerheight = 25;
							else if(col EQ iRowCount) spacerheight = spacerheight + 25;
							else spacerheight = (spacerheight * 2) + 25;
							
							if(col EQ iRowCount) iBrackets = 1;
						</cfscript>
						<table cellpadding="0" cellspacing="0">
							<tr>
								<td>#request.content.type_de_match_key_winnerbracket# #col-1#<br>
									<img src="#stImageDir.general#/spacer.gif" width="110" height="0" alt="" border="0" vspace="0" hspace="0"></td>
							</tr>
							<tr>
								<td>
									<table cellpadding="0" cellspacing="0">
										<cfloop from="1" to="#iBrackets#" index="row">
											<cfif iDivider gt 1>
												<tr>
													<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></td>
													<td align="center" valign="bottom"><cfif col NEQ iRowCount><span style="color: gray; font-size: 10px;">#request.content.type_de_match_key_winnerbracket# #col-1#.#row#</span></cfif></td>
													<td align="right"><cfif not top><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
												</tr>
											</cfif>
											<tr>
												<td height="50"><cfif iRowCountL GT 0><cfif iDivider GT 1><img src="#stImageDir.module#/type_de/middle.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"><cfelseif top><img src="#stImageDir.module#/type_de/top_right.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"><cfelse><img src="#stImageDir.module#/type_de/bottom_right.gif" width="8" height="50" alt="" border="0"></cfif></cfif></td>
												<td style="border: 1px solid gray;" class="alternate" align="center" valign="middle" width="100" height="50">
													<cfset keyCurrentRowCol = '#col+iRowCountL#_#row#'>
													<cfif StructKeyExists(stHtmlMatches,keyCurrentRowCol)>
														#stHtmlMatches[keyCurrentRowCol]#
													<cfelse>
														#stHtmlMatches['blank']#
														<cfinvoke component="type_de" method="createMatch">
															<cfinvokeargument name="tournamentid" value="#qTournament.id#">
															<cfinvokeargument name="col" value="#col+iRowCountL#">
															<cfinvokeargument name="row" value="#row#">
														</cfinvoke>
														<cfset bRefreshView = 1>
													</cfif>
												</td>
												<td height="50"><cfif col NEQ iRowCount><cfif top><img src="#stImageDir.module#/type_de/top_left.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"><cfelse><img src="#stImageDir.module#/type_de/bottom_left.gif" width="8" height="50" alt="" border="0"></cfif></cfif></td>
											</tr>
											<cfif col EQ iRowCount-1>
												<tr>
													<td height="50">&nbsp;</td>
													<td valign="middle" align="center" width="100" height="50">
														<span style="color: gray; font-size: 10px;">#request.content.type_de_match_winner_from#</span>
													</td>
													<td height="50"><img src="#stImageDir.module#/type_de/bottom_left.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"></td>
												</tr>
											</cfif>
											<cfif iDivider gt 1 AND col NEQ iRowCount>
												<tr>
													<td>&nbsp;</td>
													<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></td>
													<td align="right"><cfif top AND col EQ iRowCount><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif><cfif top AND col NEQ iRowCount-1 AND col NEQ iRowCount><img src="#stImageDir.module#/type_de/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
												</tr>
											</cfif>
											<!--- spacersettings --->
											<cfscript>
												if(top) top = false;
												else top = true;
											</cfscript>
										</cfloop>
										<!--- spacersettings --->
										<cfscript>
											if(iDivider EQ 1) iDivider = 2;
											else iDivider = iDivider * 2;
										</cfscript>
									</table>
								</td>
							</tr>
						</table>
						<cfset iBrackets = iBrackets / 2></td>
				</cfloop>
			</tr>
		</table>
	</cfif>
	
</cfoutput>

<cfif bRefreshView>
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">