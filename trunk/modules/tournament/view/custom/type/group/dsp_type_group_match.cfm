<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_group_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.showGroupDetails" default="">
<cfif NOT ListFind('signup,warmup',qTournament.status) AND qGroups.recordcount EQ 1 AND attributes.showGroupDetails NEQ qGroups.id>
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&showGroupDetails=#qGroups.id#&#session.urltoken#" addtoken="false">
</cfif>

<cfoutput>
	<h4>#request.content.type_group_match_headline#</h4>
	<cfif session.oUser.checkPermissions('manage')>
		<div align="center">
			<cfif qTournament.status EQ 'warmup'>
				<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&randomize_first_round=true&tournamentid=#qTournament.id#&#session.urltoken#" class="link_extended">#request.content.type_group_match_randomize_groups#</a><br>
				<br>
			</cfif>
			<cfif ListFind('signup,warmup',qTournament.status)>
				<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&#session.urltoken#" method="post">
					<input type="hidden" name="grouphandler_add" value="true">
					#request.content.type_group_new_group#<input type="text" name="group_name"> <input type="submit" value="#request.content.form_save#">
				</form><br><br>
			</cfif>
		</div>
	</cfif>
	<br><br>
	<cfif listFind(ValueList(qGroups.id),attributes.showGroupDetails)>
		<cfloop query="qGroups">
			<cfif id EQ attributes.showGroupDetails>
				<cfinvoke component="type_group" method="getTeamsByGroupID" returnvariable="qTeams">
					<cfinvokeargument name="tournamentid" value="#qTournament.id#">
					<cfinvokeargument name="groupid" value="#id#">
				</cfinvoke>
				<strong>#name#</strong><br><br>
				<table cellpadding="0" cellspacing="5" align="center">
					<tr>
						<td colspan="2">&nbsp;</td>
						<cfloop query="qTeams">
							<td align="center" valign="bottom"><strong>#request.content.type_group_key_teamprefix##currentrow#</strong><br><img src="#stImageDir.general#/spacer.gif" width="30" height="1" border="0"></td>
						</cfloop>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
						<td align="center">#request.content.type_group_stats_key_win# #request.content.type_group_stats_key_seperator# #request.content.type_group_stats_key_loss# #request.content.type_group_stats_key_seperator# #request.content.type_group_stats_key_draw#</td>
					</tr>
					<cfloop query="qTeams">
						<cfscript>
							iStatsW = 0;
							iStatsL = 0;
							iStatsD = 0;
							iCurrentTeamID = id;
						</cfscript>
						<tr>
							<td><a href="#myself##myfusebox.thiscircuit#.team_details&teamid=#id#&tournamentid=#attributes.tournamentid#&#session.urltoken#">#name#</a></td>
							<td><strong>#request.content.type_group_key_teamprefix##currentrow#</strong></td>
							<cfloop query="qTeams">
								<cfif iCurrentTeamID EQ id>
									<td align="center">-</td>
								<cfelse>
									<cfquery dbtype="query" name="qMatchdata">
										SELECT *
										FROM qMatches
										WHERE (team1 = <cfqueryparam cfsqltype="cf_sql_integer" value="#iCurrentTeamID#"> 
												AND team2 = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">)
										OR (team2 = <cfqueryparam cfsqltype="cf_sql_integer" value="#iCurrentTeamID#"> 
												AND team1 = <cfqueryparam cfsqltype="cf_sql_integer" value="#id#">)
									</cfquery>
									
									<cfif NOT qMatchdata.recordcount>
										<cfinvoke component="type_group" method="createMatch">
											<cfinvokeargument name="tournamentid" value="#qTournament.id#">
											<cfinvokeargument name="team1" value="#iCurrentTeamID#">
											<cfinvokeargument name="team2" value="#id#">
										</cfinvoke>

										<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&showGroupDetails=#attributes.showGroupDetails#&#session.urltoken#" addtoken="false">
									</cfif>
									
									<cfscript>
										bStatsW = false;
										bStatsL = false;
										bStatsD = false;
										
										if(qMatchdata.winner EQ 'team1'){
											if(qMatchdata.team1 EQ iCurrentTeamID){
												iStatsW = iStatsW + 1;
												bStatsW = true;
											}
											else{
												iStatsL = iStatsL + 1;
												bStatsL = true;
											}
										}
										else if(qMatchdata.winner EQ 'team2'){
											if(qMatchdata.team2 EQ iCurrentTeamID){
												iStatsW = iStatsW + 1;
												bStatsW = true;
											}
											else{
												iStatsL = iStatsL + 1;
												bStatsL = true;
											}
										}
										else if(qMatchdata.winner EQ 'draw'){
											iStatsD = iStatsD + 1;
											bStatsD = true;
										}
									</cfscript>
									<td align="center" style="border: 1px solid gray; border-bottom: 4px solid <cfif bStatsW>green<cfelseif bStatsL>red<cfelseif bStatsD>orange<cfelse>##CCCCCC</cfif>;" title="#name#"><a href="#myself##myfusebox.thiscircuit#.matchdetails&tournamentid=#qTournament.id#&matchid=#qMatchdata.id#&#session.urltoken#">&nbsp;&nbsp;<cfif bStatsW>#request.content.type_group_stats_key_win#<cfelseif bStatsL>#request.content.type_group_stats_key_loss#<cfelseif bStatsD>#request.content.type_group_stats_key_draw#<cfelse>?</cfif>&nbsp;&nbsp;</a></td>
								</cfif>
							</cfloop>
							<td>&nbsp;</td>
							<td align="center"><span style="color: green;"><strong>#iStatsW#</strong></span> / <span style="color: red;"><strong>#iStatsL#</strong></span> / <span style="color: orange;">#iStatsD#</span></td>
						</tr>
					</cfloop>
				</table>
			</cfif>
		</cfloop>
	<cfelse>
		<table cellpadding="0" cellspacing="0" align="center" width="60%">
			<cfloop query="qGroups">
				<cfinvoke component="type_group" method="getTeamsByGroupID" returnvariable="qTeams">
					<cfinvokeargument name="tournamentid" value="#qTournament.id#">
					<cfinvokeargument name="groupid" value="#id#">
				</cfinvoke>
				<tr>
					<td colspan="2">&nbsp;<br>&nbsp;<br>&nbsp;<br></td>
				</tr>
				<tr>
					<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&showGroupDetails=#id#&#session.urltoken#"><strong>#name#</strong></a></td>
					<td align="right"><cfif ListFind('signup,warmup',qTournament.status)><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&grouphandler_delete=#id#&#session.urltoken#" title="#request.content.form_delete#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a></cfif></td>
				</tr>
				<tr>
					<td style="border: 1px dotted black;" colspan="2">
						<table>
							<cfloop query="qTeams">
								<tr>
									<td><a href="#myself##myfusebox.thiscircuit#.team_details&teamid=#id#&tournamentid=#attributes.tournamentid#&#session.urltoken#">#name#</a></td>
								</tr>
							</cfloop>
						</table>
					</td>
				</tr>
			</cfloop>
		</table>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">