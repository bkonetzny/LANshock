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
	
	iBrackets = iTeams / 2;

	// spacersettings
	iDivider = 1;
	
	// rendersettings
	bRefreshView = 0;
</cfscript>

<cfoutput>
	<div class="headline2">#request.content.type_se_match_headline#</div>
	<cfif request.session.isAdmin>
		<div align="center">
			<cfif qTournament.status EQ 'warmup'>
				<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&randomize_first_round=true&tournamentid=#qTournament.id#&#request.session.urltoken#" class="link_extended">#request.content.type_se_match_randomize_first_round#</a><br>
			</cfif>
			<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&showstatus=false&tournamentid=#qTournament.id#&#request.session.urltoken#" class="link_extended">#request.content.type_se_match_markstatus#</a><br>
		</div>
	</cfif>
	<cfif qTeamCurrentUser.recordcount>
		<div align="center">&nbsp;<br><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&markteam=#qTeamCurrentUser.id#&tournamentid=#qTournament.id#&#request.session.urltoken#" class="link_extended">#request.content.type_se_match_markteam#</a></div>
	</cfif>
	<br><br>
	<table cellpadding="0" cellspacing="0" align="center">
		<tr>
			<cfloop from="1" to="#iRowCount#" index="col">
				<td valign="top">
					<!--- spacersettings --->
					<cfscript>
						top = true;
						if(col LT 3) spacerheight = 25;
						// else if(col EQ iRowCount) spacerheight = spacerheight + 25;
						else spacerheight = (spacerheight * 2) + 25;
					</cfscript>
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td>#request.content.type_se_match_key_winnerbracket# #col-1#<br>
								<img src="#stImageDir.general#/spacer.gif" width="110" height="0" alt="" border="0" vspace="0" hspace="0"></td>
						</tr>
						<tr>
							<td>
								<table cellpadding="0" cellspacing="0">
									<cfloop from="1" to="#iBrackets#" index="row">
										<cfif iDivider gt 1>
											<tr>
												<td>&nbsp;</td>
												<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></td>
												<td align="right"><cfif not top><img src="#stImageDir.module#/type_se/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
											</tr>
										</cfif>
										<tr>
											<td height="50"><cfif iDivider gt 1><img src="#stImageDir.module#/type_se/middle.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"></cfif></td>
											<td style="border: 1px solid gray;" class="alternate" align="center" valign="middle" width="100" height="50">
												<cfset keyCurrentRowCol = '#col#_#row#'>
												<cfif StructKeyExists(stHtmlMatches,keyCurrentRowCol)>
													#stHtmlMatches[keyCurrentRowCol]#
												<cfelse>
													#stHtmlMatches['blank']#
													<cfinvoke component="type_se" method="createMatch">
														<cfinvokeargument name="tournamentid" value="#qTournament.id#">
														<cfinvokeargument name="col" value="#col#">
														<cfinvokeargument name="row" value="#row#">
													</cfinvoke>
													<cfset bRefreshView = 1>
												</cfif>
											</td>
											<td height="50"><cfif col NEQ iRowCount><cfif top><img src="#stImageDir.module#/type_se/top_left.gif" width="8" height="50" alt="" border="0" vspace="0" hspace="0"><cfelse><img src="#stImageDir.module#/type_se/bottom_left.gif" width="8" height="50" alt="" border="0"></cfif></cfif></td>
										</tr>
										<cfif iDivider gt 1>
											<tr>
												<td>&nbsp;</td>
												<td align="center"><img src="#stImageDir.general#/spacer.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></td>
												<td align="right"><cfif top AND col EQ iRowCount-1><img src="#stImageDir.module#/type_se/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif><cfif top AND col NEQ iRowCount-1 AND col NEQ iRowCount><img src="#stImageDir.module#/type_se/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
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
</cfoutput>

<cfif bRefreshView>
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">