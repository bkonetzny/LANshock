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
<cfset bRefreshView = 0>

<cfoutput>
	<style>
		.match_plan * a {text-decoration: none;}
		.team_name {display: block;}
		.team_delimiter {display: block; color: white;}
		.team_wildcard {display: block; color: white;}
		
		.match_status_open_marker {border: 1px solid red;}
		.match_status_submitted_marker {border: 1px solid orange;}
		.match_status_checked_marker {border: 1px solid green;}
		.team_winner {font-weight: bold; color: green;}
		.team_loser {color: red;}
		.team_marker {background-color: green; color: white; font-weight: bold;}
		.team_marker_box {background-color: orange;}
	</style>

	<script type="text/javascript">
		<cfif session.oUser.checkPermissions('manage')>
			var bMarkersMatchStatus = false;
			function showMatchStatus(){
				if(!bMarkersMatchStatus){
					$('div.match_status_open').addClass('match_status_open_marker');
					$('div.match_status_submitted').addClass('match_status_submitted_marker');
					$('div.match_status_checked').addClass('match_status_checked_marker');
					bMarkersMatchStatus = true;
				}
				else {
					$('div.match_status_open').removeClass('match_status_open_marker');
					$('div.match_status_submitted').removeClass('match_status_submitted_marker');
					$('div.match_status_checked').removeClass('match_status_checked_marker');
					bMarkersMatchStatus = false;
				}
			}
		</cfif>
		
		var bMarkersTeam = false;
		function markTeam(id){
			if(!bMarkersTeam){
				$('span.team_'+id).addClass('team_marker');
				$('div.team_'+id+'_box').addClass('team_marker_box');
				bMarkersTeam = true;
			}
			else {
				$('span.team_'+id).removeClass('team_marker');
				$('div.team_'+id+'_box').removeClass('team_marker_box');
				bMarkersTeam = false;
			}
		}
	</script>
	
	<h4>#request.content.type_se_match_headline#</h4>

	<cfif qTeamCurrentUser.recordcount OR session.oUser.checkPermissions('manage')>
	<ul class="options">
		<cfif session.oUser.checkPermissions('manage')>
			<cfif qTournament.status EQ 'warmup'>
				<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&reset_matches=true')#">Reset all matches</a></li>
				<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&randomize_first_round=true')#">#request.content.type_se_match_randomize_first_round#</a></li>
			<cfelseif qTournament.status EQ 'playing'>
				<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&calculateMatches=true')#">Paarungen berechnen</a></li>
			</cfif>
			<li><a href="##" onclick="showMatchStatus();return false;">#request.content.type_se_match_markstatus#</a></li>
		</cfif>
		<cfif qTeamCurrentUser.recordcount>
			<li><a href="##" onclick="markTeam('#qTeamCurrentUser.id#');return false;">#request.content.type_se_match_markteam#</a></li>
		</cfif>
	</ul>
	</cfif>
</cfoutput>

<cfif NOT application.lanshock.oCache.exists(sCacheKey)>
	<cfsavecontent variable="sMatchTree">
		<cfoutput>
		<table cellpadding="0" cellspacing="0" class="match_plan">
			<tr>
				<cfloop from="1" to="#iRowCount#" index="col">
					<td valign="top">
						<div class="rowheader">
							#request.content.type_se_match_key_winnerbracket# #col-1#
						</div>
						<!--- spacersettings --->
						<cfset top = true>
						<cfif col LT 3>
							<cfset spacerheight = 25>
						<!--- <cfelseif col EQ iRowCount>
							<cfset spacerheight = spacerheight + 25> --->
						<cfelse>
							<cfset spacerheight = (spacerheight * 2) + 25>
						</cfif>
						<table cellpadding="0" cellspacing="0" class="match_row<cfif col MOD 2> match_row_odd<cfelse> match_row_even</cfif>">
							<tr>
								<td>
									<table cellpadding="0" cellspacing="0" class="match">
										<cfloop from="1" to="#iBrackets#" index="row">
											<cfif iDivider gt 1>
												<tr>
													<td colspan="2" style="height: #spacerheight#px;"></td>
													<td class="decorator"><cfif not top><img src="#stImageDir.module#/type_se/px.gif" width="1" height="#spacerheight#" alt="" border="0" vspace="0" hspace="0"></cfif></td>
												</tr>
											</cfif>
											<tr class="match_container">
												<td class="decorator"><cfif iDivider gt 1><img src="#stImageDir.module#/type_se/middle.gif" width="8" height="50" alt="" border="0"/></cfif></td>
												<td class="match_box match_box_status_">
													#stHtmlMatches['#col#_#row#']#
												</td>
												<td class="decorator"><cfif col NEQ iRowCount><cfif top><img src="#stImageDir.module#/type_se/top_left.gif" width="8" height="50" alt="" border="0"/><cfelse><img src="#stImageDir.module#/type_se/bottom_left.gif" width="8" height="50" alt="" border="0"></cfif></cfif></td>
											</tr>
											<cfif iDivider gt 1>
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
										<!--- spacersettings --->
										<cfif iDivider EQ 1>
											<cfset iDivider = 2>
										<cfelse>
											<cfset iDivider = iDivider * 2>
										</cfif>
									</table>
								</td>
							</tr>
						</table>
						<cfset iBrackets = iBrackets / 2>
					</td>
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

<cfsetting enablecfoutputonly="No">