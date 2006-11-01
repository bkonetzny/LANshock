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
<div class="headline">#request.content.mytournaments_headline#</div>

<cfif request.session.isAdmin>
	<div class="headline2">Admin bei folgenden Turnieren</div>
	
	<table class="list">
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
			<cfif ListFind(ladminids,request.session.userid)>
			<tr>
				<td class="empty"><cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
				<td><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#HTMLEditFormat(name)#</a></td>
				<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#"><strong>#currentteams#</strong> / #maxteams#</a></td>
				<td align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#teamsize# #request.content.players#<cfif teamsubstitute GT 0> (+ #teamsubstitute#)</cfif></a></td>
				<td><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_type_' & type]#</a></td>
				<td align="center"><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_status_' & status]#</a></td>
				<td align="center">
					<cfif DateCompare(starttime,now()) NEQ "-1" AND DateDiff('d',starttime,now()) LTE 31>
						#calcRemainingTime(starttime)#
					</cfif>
					#UDF_DateTimeFormat(starttime)#</td>
			</tr>
			</cfif>
		</cfloop>
	</table>

	<div class="headline2">Spieler bei folgenden Turnieren</div>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
		User wechseln <select name="user_id">
			<cfloop query="qUsers">
				<option value="#id#"<cfif attributes.user_id EQ id> selected</cfif>>#name#</option>
			</cfloop>
		</select>
	
		<input type="submit" value="#request.content.form_save#">
	</form>
</cfif>

<table class="list">
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
			<td class="empty"><cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
			<td><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#id#&#request.session.urltoken#">#HTMLEditFormat(name)#</a></td>
			<td><a href="#myself##myfusebox.thiscircuit#.team_details&teamid=#teamid#&tournamentid=#id#&#request.session.urltoken#"><cfif teamsize EQ 1>#playername#<cfelse>#teamname#</cfif></a></td>
			<td><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_type_' & type]#</a></td>
			<td align="center"><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#id#&#request.session.urltoken#">#request.content['tournament_status_' & status]#</a></td>
			<td align="center">
				<cfif day(starttime) EQ day(now()) AND DateCompare(starttime,now()) NEQ "-1">
					#calcRemainingTime(starttime)#
				</cfif>
				#UDF_DateTimeFormat(starttime)#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">