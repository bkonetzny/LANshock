<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/_tournament_header.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.tournamentid" default="0">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournamentData" returnvariable="qTournament">
	<cfinvokeargument name="id" value="#attributes.tournamentid#">
</cfinvoke>

<cfif session.oUser.isLoggedIn()>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamByUserID" returnvariable="qTeamCurrentUser">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
		<cfinvokeargument name="userid" value="#session.userid#">
	</cfinvoke>
<cfelse>
	<cfset qTeamCurrentUser = QueryNew('id,name')>
</cfif>

<cfif NOT qTournament.recordcount>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.tournaments')#" addtoken="false">
</cfif>

<cfoutput>
	<script type="text/javascript" src="#application.lanshock.oHelper.UDF_Module('webPath')#_shared/js/tournament.js"></script>
<script type="text/javascript" src="#application.lanshock.oHelper.UDF_Module('webPath')#_shared/js/type_#qTournament.type#.js"></script>
<link rel="stylesheet" href="#application.lanshock.oHelper.UDF_Module('webPath')#_shared/css/type_#qTournament.type#.css" type="text/css"/>

<h3>#qTournament.name#</h3>

<p>
	<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.tournaments')#">Zur Turnier&uuml;bersicht</a>
	<cfif myfusebox.thisfuseaction EQ 'matchdetails'>
		 | <a href="##" onclick="$('##tournament_info').toggle();return false;">Info einblenden</a>
	</cfif>
</p>

<div id="tournament_info"<cfif myfusebox.thisfuseaction EQ 'matchdetails'> style="display:none;"</cfif>>
	<cfif len(qTournament.infotext) OR len(qTournament.image)>
		<p><cfif len(qTournament.image)>
				<img src="#application.lanshock.oHelper.UDF_Module('webPath')#images/icons/#qTournament.image#" vspace="2"><br>
			</cfif>
			<cfif len(qTournament.infotext)>#qTournament.infotext#</cfif></p>
	</cfif>
	
	<table class="vlist">
		<tr>
			<th>#request.content.tournament_status#</th>
			<td><cfif NOT session.oUser.checkPermissions('manage')>
					#request.content['tournament_status_' & qTournament.status]#
				<cfelse>
					<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.tournament_changestatus&tournamentid=#qTournament.id#')#">#request.content['tournament_status_' & qTournament.status]#</a>
				</cfif></td>
		</tr>
		<tr>
			<th>#request.content.tournament_type#</th>
			<td>#request.content['tournament_type_' & qTournament.type]#</td>
		</tr>
		<tr>
			<th><cfif qTournament.teamsize EQ 1>#request.content.tournament_maxplayers#<cfelse>#request.content.tournament_maxteams#</cfif></th>
			<td>#qTournament.currentteams# / #qTournament.maxteams#</td>
		</tr>
		<tr>
			<th>#request.content.tournament_teamsize#</th>
			<td>#qTournament.teamsize# #request.content.players#</td>
		</tr>
		<cfif session.oUser.isLoggedIn()>
			<cfif qTournament.teamsize EQ 1>
				<tr>
					<th>#request.content.data_your_team#</th>
					<td><cfif qTeamCurrentUser.recordcount>
							#request.content.you_have_signup#
						<cfelseif qTournament.status EQ "signup">
							<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.signup&tournamentid=#qTournament.id#')#">#request.content.add_a_new_player#</a>
						<cfelse>
							#request.content.data_your_team_noteam#
						</cfif></td>
				</tr>
			<cfelse>
				<tr>
					<th>#request.content.data_your_team#</th>
					<td><cfif qTeamCurrentUser.recordcount>
							 <a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#qTournament.id#&teamid=#qTeamCurrentUser.id#')#">#HTMLEditFormat(qTeamCurrentUser.name)#</a>
						<cfelse>
							<cfif qTournament.status EQ "signup">
								<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.signup&tournamentid=#qTournament.id#')#">#request.content.add_a_new_team#</a>
							<cfelse>
								#request.content.data_your_team_noteam#
							</cfif>
						</cfif></td>
				</tr>
			</cfif>
		</cfif>
	</table>
</div>

<!--- <cfif len(ladminids)>
	<table>
		<tr>
			<th colspan="2"><!--- TODO: $$$ ---> Admins</th>
		</tr>
		<cfloop list="#ladminids#" index="idx">
			<tr>
				<td><cfif session.userloggedin AND session.userid NEQ idx><a href="javascript:LANshock.userSendMessage(#idx#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a> </cfif><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#idx#')#">#application.lanshock.oHelper.GetUsernameByID(idx)#</a></td>
				<td><cftry>
						<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.event.model.seatplan')#" method="getSeatLinkDataByUserID" returnvariable="stSeat">
							<cfinvokeargument name="userid" value="#idx#">
						</cfinvoke>
						<cfif NOT StructIsEmpty(stSeat)>
							<a href="#application.lanshock.oHelper.buildUrl('#stSeat.linkurl#')#">#stSeat.description#</a>
						<cfelse>
							#request.content.player_unknown_seat#
						</cfif>
						<cfcatch>#request.content.player_unknown_seat#</cfcatch>
					</cftry></td>
			</tr>
		</cfloop>
	</table>
</cfif> --->

<h4>Informationen</h4>
<table width="100%">
	<tr>
		<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#attributes.tournamentid#')#">#request.content.link_teams#</a></td>
		<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matches&tournamentid=#attributes.tournamentid#')#">#request.content.link_matches#</a></td>
		<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.ranking&tournamentid=#attributes.tournamentid#')#">#request.content.link_ranking#</a></td>
		<td align="center"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.rules&tournamentid=#attributes.tournamentid#')#">#request.content.link_rules#</a></td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">