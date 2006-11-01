<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
<div class="headline">#request.content.tournamentsystem#</div>

<div align="center">
	<cfif stModuleConfig.layout.listview.user_change>
		#request.content.tournaments_view#<br>
		<a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&view=1&#request.session.urltoken#" class="link_extended">#request.content.tournaments_view_detailed#</a> | <a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&view=2&#request.session.urltoken#" class="link_extended">#request.content.tournaments_view_classic#</a> | <a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&view=3&#request.session.urltoken#" class="link_extended">#request.content.tournaments_view_slim#</a>
	</cfif>
	<cfif request.session.userloggedin AND stModuleConfig.coinsystem>
		<br><br><br>#request.content.coins_user_amount_avaible# <strong>#iUserCoins#</strong> / #stModuleConfig.coinsystem_usercoins#
	</cfif>
</div>

<cfswitch expression="#attributes.view#">

	<cfcase value="1">
		<table width="90%" align="center" cellpadding="10" cellspacing="0">
		<cfloop query="qGroups">
			<cfparam name="aUserGroupIDs[id]" default="0">
			<tr>
				<td><div class="headline2">#name#</div><br>
					<cfif len(description)>#HTMLEditFormat(description)#<br>&nbsp;</cfif>	
					<cfif stModuleConfig.groupmaxsignups AND request.session.userloggedin><br>&nbsp;#request.content.group_signups_maxsignups# <strong>#aUserGroupIDs[id]#</strong> (<cfif maxsignups EQ 0>#request.content.group_maxsignups_nolimit#<cfelse>#maxsignups#</cfif>)</cfif></td>
			</tr>
			<cfset iCurrentGroup = id>
			<cfloop query="qTournaments">
				<cfif groupid EQ iCurrentGroup>
					<tr>
						<td class="alternate">
							<table width="100%">
								<tr>
									<td>
										<table>
											<tr>
												<td><cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
												<td><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#name#</a></td>
											</tr>
										</table>
									</td>
									<td align="right">&nbsp;<cfif len(export_league)><img src="#UDF_Module('webPath')#export/#export_league#.gif"></cfif></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="border-bottom: 1px solid grey; border-left: 1px solid grey; border-right: 1px solid grey;">
							<table width="100%">
								<tr>
									<td valign="top" align="center">#request.content.tournament_maxteams#<br><strong>#currentteams#</strong> / #maxteams#</td>
									<td valign="top">#request.content.tournament_teamsize#<br><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#teamsize# #request.content.players#<cfif teamsubstitute GT 0> (+ #teamsubstitute#)</cfif></a></td>
									<td valign="top">#request.content.tournament_type#<br><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_type_' & type]#</a></td>
									<td valign="top">#request.content.tournament_status#<br><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_status_' & status]#</a></td>
									<td valign="top">#request.content.tournament_estimatedstarttime#<br>
										<cfif DateCompare(starttime,now()) NEQ "-1" AND DateDiff('d',starttime,now()) LTE 31>
											#calcRemainingTime(starttime)#
										</cfif>
										#UDF_DateTimeFormat(starttime)#</td>
								</tr>
								<cfif stModuleConfig.coinsystem>
									<tr>
										<td colspan="5"><br><br>#request.content.coins_needed_for_tournament# #coins#</td>
									</tr>
								</cfif>
							</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
				</cfif>
			</cfloop>
		</cfloop>
		</table>
	</cfcase>

	<cfcase value="2">
		<table class="list">
		<cfloop query="qGroups">
			<cfparam name="aUserGroupIDs[id]" default="0">
			<tr>
				<td class="empty" colspan="<cfif stModuleConfig.coinsystem>8<cfelse>7</cfif>"><div class="headline2">#name#</div><br>
					<cfif len(description)>#HTMLEditFormat(description)#<br>&nbsp;</cfif>	
					<cfif stModuleConfig.groupmaxsignups AND request.session.userloggedin><br>&nbsp;#request.content.group_signups_maxsignups# <strong>#aUserGroupIDs[id]#</strong> (<cfif maxsignups EQ 0>#request.content.group_maxsignups_nolimit#<cfelse>#maxsignups#</cfif>)</cfif></td>
			</tr>
			<tr>
				<th class="empty">&nbsp;</th>
				<th>#request.content.tournament_name#</th>
				<th>#request.content.tournament_maxteams#</th>
				<th>#request.content.tournament_teamsize#</th>
				<th>#request.content.tournament_type#</th>
				<cfif stModuleConfig.coinsystem>
					<th>#request.content.coins#</th>
				</cfif>
				<th>#request.content.tournament_status#</th>
				<th>#request.content.tournament_estimatedstarttime#</th>
			</tr>
			<cfset iCurrentGroup = id>
			<cfloop query="qTournaments">
				<cfif groupid EQ iCurrentGroup>
					<tr>
						<td class="empty"><cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
						<td><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#"><cfif len(export_league)><img src="#UDF_Module('webPath')#export/#export_league#_small.gif"> </cfif>#name#</a></td>
						<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#"><strong>#currentteams#</strong> / #maxteams#</a></td>
						<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#teamsize# #request.content.players#<cfif teamsubstitute GT 0> (+ #teamsubstitute#)</cfif></a></td>
						<td><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_type_' & type]#</a></td>
						<cfif stModuleConfig.coinsystem>
							<td align="right">#coins#</td>
						</cfif>
						<td align="center"><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_status_' & status]#</a></td>
						<td align="center">
							<cfif DateCompare(starttime,now()) NEQ "-1" AND DateDiff('d',starttime,now()) LTE 31>
								#calcRemainingTime(starttime)#
							</cfif>
							#UDF_DateTimeFormat(starttime)#</td>
					</tr>
				</cfif>
			</cfloop>
		</cfloop>
		</table>
	</cfcase>

	<cfcase value="3">
		<table class="list">
		<cfloop query="qGroups">
			<cfparam name="aUserGroupIDs[id]" default="0">
			<tr>
				<td class="empty" colspan="<cfif stModuleConfig.coinsystem>7<cfelse>6</cfif>"><div class="headline2">#name#</div><br>
					<cfif len(description)>#HTMLEditFormat(description)#<br>&nbsp;</cfif>	
					<cfif stModuleConfig.groupmaxsignups AND request.session.userloggedin><br>&nbsp;#request.content.group_signups_maxsignups# <strong>#aUserGroupIDs[id]#</strong> (<cfif maxsignups EQ 0>#request.content.group_maxsignups_nolimit#<cfelse>#maxsignups#</cfif>)</cfif></td>
			</tr>
			<tr>
				<th class="empty">&nbsp;</th>
				<th>#request.content.tournament_name#</th>
				<th>#request.content.tournament_maxteams#</th>
				<th>#request.content.tournament_teamsize#</th>
				<th>#request.content.tournament_type#</th>
				<cfif stModuleConfig.coinsystem>
					<th>#request.content.coins#</th>
				</cfif>
				<th>#request.content.tournament_status#</th>
			</tr>
			<cfset iCurrentGroup = id>
			<cfloop query="qTournaments">
				<cfif groupid EQ iCurrentGroup>
					<tr>
						<td class="empty"><cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#" width="16" height="16"><cfelse><img src="#stImageDir.general#/spacer.gif" width="16" height="16"></cfif></td>
						<td><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#name#</a></td>
						<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#"><strong>#currentteams#</strong> / #maxteams#</a></td>
						<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#teamsize# #request.content.players#<cfif teamsubstitute GT 0> (+ #teamsubstitute#)</cfif></a></td>
						<td><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_type_' & type]#</a></td>
						<cfif stModuleConfig.coinsystem>
							<td align="right">#coins#</td>
						</cfif>
						<td align="center"><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_status_' & status]#</a></td>
					</tr>
				</cfif>
			</cfloop>
		</cfloop>
		</table>
	</cfcase>

</cfswitch>

</cfoutput>

<cfsetting enablecfoutputonly="No">