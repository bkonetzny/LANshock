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
<h3>#request.content.mytournaments_headline#</h3>

<cfif session.oUser.checkPermissions('manage')>
	<h4>Admin bei folgenden Turnieren</h4>
	
	<table>
		<tr>
			<th class="empty">&nbsp;</th>
			<th>#request.content.tournament_name#</th>
			<th>#request.content.tournament_maxteams#</th>
			<th>#request.content.tournament_teamsize#</th>
			<th>#request.content.tournament_type#</th>
			<th>#request.content.tournament_status#</th>
			<th>#request.content.tournament_estimatedstarttime#</th>
		</tr>
		<cfloop query="qTournaments">
			<cfif ListFind(ladminids,session.userid)>
			<tr>
				<td class="empty"><cfif len(image)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#id#')#">#HTMLEditFormat(name)#</a></td>
				<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#id#')#"><strong>#currentteams#</strong> / #maxteams#</a></td>
				<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#id#')#">#teamsize# #request.content.players#<cfif teamsubstitute GT 0> (+ #teamsubstitute#)</cfif></a></td>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#id#')#">#request.content['tournament_type_' & type]#</a></td>
				<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#id#')#">#request.content['tournament_status_' & status]#</a></td>
				<td align="center">
					<cfif DateCompare(starttime,now()) NEQ "-1" AND DateDiff('d',starttime,now()) LTE 31>
						#calcRemainingTime(starttime)#
					</cfif>
					#session.oUser.DateTimeFormat(starttime)#</td>
			</tr>
			</cfif>
		</cfloop>
	</table>

	<h4>Spieler bei folgenden Turnieren</h4>

	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
		User wechseln <select name="user_id">
			<cfloop query="qUsers">
				<option value="#id#"<cfif attributes.user_id EQ id> selected</cfif>>#name#</option>
			</cfloop>
		</select>
	
		<input type="submit" value="#request.content.form_save#">
	</form>
</cfif>

<table>
	<tr>
		<th class="empty">&nbsp;</th>
		<th>#request.content.tournament_name#</th>
		<th>#request.content.data_your_team#</th>
		<th>#request.content.tournament_type#</th>
		<th>#request.content.tournament_status#</th>
		<th>#request.content.tournament_estimatedstarttime#</th>
	</tr>
	<cfloop query="qMyTournaments">
		<tr>
			<td class="empty"><cfif len(image)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
			<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#id#')#">#HTMLEditFormat(name)#</a></td>
			<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#id#&teamid=#teamid#')#"><cfif teamsize EQ 1>#playername#<cfelse>#teamname#</cfif></a></td>
			<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#id#')#">#request.content['tournament_type_' & type]#</a></td>
			<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#id#')#">#request.content['tournament_status_' & status]#</a></td>
			<td align="center">
				<cfif day(starttime) EQ day(now()) AND DateCompare(starttime,now()) NEQ "-1">
					#calcRemainingTime(starttime)#
				</cfif>
				#session.oUser.DateTimeFormat(starttime)#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">