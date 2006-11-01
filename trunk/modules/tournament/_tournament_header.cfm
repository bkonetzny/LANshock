<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.tournamentid" default="0">

<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournament">
	<cfinvokeargument name="id" value="#attributes.tournamentid#">
</cfinvoke>

<cfif request.session.userloggedin>
	<cfinvoke component="team" method="getTeamByUserID" returnvariable="qTeamCurrentUser">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
		<cfinvokeargument name="userid" value="#request.session.userid#">
	</cfinvoke>
<cfelse>
	<cfset qTeamCurrentUser = QueryNew('id,name')>
</cfif>

<cfif NOT qTournament.recordcount>
	<cflocation url="#myself##myfusebox.thiscircuit#.tournaments&#request.session.urltoken#" addtoken="false">
</cfif>

<cfoutput query="qTournament">
<div class="headline">#name#</div>
<br>
<div align="center">
<cfif request.session.isAdmin>
	<a href="#myself##myfusebox.thiscircuit#.tournament_changestatus&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#" class="link_extended">#request.content.tournaments_changestatus_headline#</a>
	&nbsp;&nbsp;&nbsp;
	<a href="#myself##myfusebox.thiscircuit#.tournaments_edit_settings&id=#id#&#request.session.UrlToken#" class="link_extended">#request.content.edit_tournament#</a>
	<br><br>
</cfif>
<cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#" vspace="2"><br></cfif>
<span class="text_big">#name#</span>

<cfif len(infotext)>
	<br>&nbsp;<br>#infotext#<br>&nbsp;<br>
</cfif>

<table class="list">
	<tr>
		<th align="center">#request.content.tournament_status#</th>
		<th align="center">#request.content.tournament_type#</th>
		<th align="center"><cfif qTournament.teamsize EQ 1>#request.content.tournament_maxplayers#<cfelse>#request.content.tournament_maxteams#</cfif></th>
		<th align="center">#request.content.tournament_teamsize#</th>
	</tr>
	<tr>
		<td align="center">
			#request.content['tournament_status_' & status]#
			<cfif request.session.isAdmin>
				<strong><a href="#myself##myfusebox.thiscircuit#.tournament_changestatus&tournamentid=#attributes.tournamentid#&#request.session.UrlToken#">#request.content.tournament_changestatus#</a></strong>
			</cfif></td>
		<td align="center">#request.content['tournament_type_' & type]#</td>
		<td align="center">#currentteams# / #maxteams#</td>
		<td align="center">#teamsize# #request.content.players#<cfif teamsubstitute GT 0> (+ #teamsubstitute#)</cfif></td>
	</tr>
</table>

<cfif len(ladminids)>
	<table class="list">
		<tr>
			<th colspan="2"><!--- TODO: $$$ ---> Admins</th>
		</tr>
		<cfloop list="#ladminids#" index="idx">
			<tr>
				<td><cfif request.session.userloggedin AND request.session.userid NEQ idx><a href="javascript:SendMsg(#idx#)"><img src="#stImageDir.general#/mail.gif" alt="" border="0"></a> </cfif><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#idx#&#request.session.UrlToken#">#GetUsernameByID(idx)#</a></td>
				<td><cftry>
						<cfinvoke component="#application.lanshock.environment.componentpath#modules.seatplan.seatplan" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#idx#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#myself##stSeat.linkurl#&#request.session.UrlToken#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry></td>
			</tr>
		</cfloop>
	</table>
</cfif>

<br>&nbsp;<br>
<table width="80%">
	<tr>
		<td width="25%" align="center"><a href="#myself##myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#&#request.session.urltoken#"><img src="#stImageDir.module#/teams.gif"><br>#request.content.link_teams#</a></td>
		<td width="25%" align="center"><a href="#myself##myfusebox.thiscircuit#.matches&tournamentid=#attributes.tournamentid#&#request.session.urltoken#"><img src="#stImageDir.module#/matches.gif"><br>#request.content.link_matches#</a></td>
		<td width="25%" align="center"><a href="#myself##myfusebox.thiscircuit#.ranking&tournamentid=#attributes.tournamentid#&#request.session.urltoken#"><img src="#stImageDir.module#/ranking.gif"><br>#request.content.link_ranking#</a></td>
		<td width="25%" align="center"><a href="#myself##myfusebox.thiscircuit#.rules&tournamentid=#attributes.tournamentid#&#request.session.urltoken#"><img src="#stImageDir.module#/rules.gif"><br>#request.content.link_rules#</a></td>
	</tr>
</table>
<cfif request.session.userloggedin><br><br>
	<cfif qTournament.teamsize EQ 1>
		<cfif qTeamCurrentUser.recordcount>
			#request.content.you_have_signup#
		<cfelseif status EQ "signup">
			<a href="#myself##myfusebox.thiscircuit#.signup&tournamentid=#attributes.tournamentid#&#request.session.urltoken#">#request.content.add_a_new_player#</a>
		<cfelse>
			#request.content.data_your_team_noteam#
		</cfif>
	<cfelse>
		#request.content.data_your_team#
		<cfif qTeamCurrentUser.recordcount>
			 <strong><a href="#myself##myfusebox.thiscircuit#.team_details&teamid=#qTeamCurrentUser.id#&tournamentid=#attributes.tournamentid#&#request.session.urltoken#">#HTMLEditFormat(qTeamCurrentUser.name)#</a></strong>
		<cfelse>
			<cfif status EQ "signup">
				<a href="#myself##myfusebox.thiscircuit#.signup&tournamentid=#attributes.tournamentid#&#request.session.urltoken#">#request.content.add_a_new_team#</a>
			<cfelse>
				#request.content.data_your_team_noteam#
			</cfif>
		</cfif>
	</cfif>
</cfif>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="No">