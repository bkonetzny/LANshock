<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_se_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>	
	<h4>#request.content.type_se_match_headline#</h4>

	<cfif session.oUser.checkPermissions('manage')
			OR (qTeamCurrentUser.recordcount AND NOT ListFindNoCase('signup,warmup',qTournament.status))>
		<ul class="options">
			<cfif session.oUser.checkPermissions('manage') AND NOT ListFindNoCase('signup,warmup',qTournament.status)>
				<li><a href="##" onclick="LANshock.Modules.oTournament.oTypeRR.showMatchStatus();return false;">#request.content.type_se_match_markstatus#</a></li>
			</cfif>
			<cfif qTeamCurrentUser.recordcount AND NOT ListFindNoCase('signup,warmup',qTournament.status)>
				<li><a href="##" onclick="LANshock.Modules.oTournament.oTypeRR.markTeam('#qTeamCurrentUser.id#');return false;">#request.content.type_se_match_markteam#</a></li>
			</cfif>
		</ul>
	</cfif>
</cfoutput>

<cfif NOT StructIsEmpty(stHtmlMatches)>
	<cfif NOT application.lanshock.oCache.exists(sCacheKey)>
		<cfset qTeams2 = duplicate(qTeams)>
		<cfset lTeamsSet = ''>
		
		<cfsavecontent variable="sMatchTree">
			<cfoutput>
				<table cellpadding="0" cellspacing="0" class="match_plan">
					<tr>
						<td></td>
						<cfloop query="qTeams2">
							<cfif qTeams2.currentrow NEQ 1>
								<td>#qTeams2.name#</td>
							</cfif>
						</cfloop>
					</tr>
					<cfloop query="qTeams">
						<cfif qTeams.currentrow NEQ qTeams.recordcount>
							<tr>
								<td>#qTeams.name#</td>
								<cfloop query="qTeams2">
									<cfif qTeams2.currentrow NEQ 1>
										<cfif qTeams.id NEQ qTeams2.id AND NOT ListFindNoCase(lTeamsSet,qTeams2.id)>
											<td class="match_box">#stHtmlMatches['#qTeams.id#_#qTeams2.id#']#</td>
										<cfelse>
											<td>-</td>
										</cfif>
									</cfif>
								</cfloop>
							</tr>
						</cfif>
						<cfset lTeamsSet = ListAppend(lTeamsSet,qTeams.id)>
					</cfloop>
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