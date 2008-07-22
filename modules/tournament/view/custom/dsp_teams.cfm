<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset lTeams = ListSort(StructKeyList(stTeams),'numeric','ASC')>

<cfoutput>
<h4>#request.content.teams_headline#</h4>

<cfif qTournament.status EQ "signup" AND session.userloggedin AND NOT qTeamCurrentUser.recordcount>
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.signup&tournamentid=#attributes.tournamentid#')#">#request.content.add_a_new_team#</a></li>
	</ul>
</cfif>

<cfif qTournament.status EQ "signup">
	<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams')#" method="post" class="uniForm">
		<div class="hidden">
			<input type="hidden" name="form_submitted_dummyteams" value="true"/>
			<input type="hidden" name="tournamentid" value="#qTournament.id#"/>
		</div>
		
		<fieldset class="inlineLabels">
			<legend><strong>DEBUG: </strong>Delete Current Teams -> Create Dummy Teams</legend>
			
			<div class="ctrlHolder">
				<label for="dummyteams"><em>*</em> Maximum Teams</label>
				<input type="text" class="textInput" name="dummyteams" id="dummyteams" value="#qTournament.maxteams#"/>
			</div>

		</fieldset>
		<div class="buttonHolder">
			<button type="submit" class="submitButton">#request.content.form_save#</button>
		</div>
	</form>
</cfif>

<cfif qTournament.teamsize GT 1>
	<cfif ListLen(lTeams)>
		<table>
			<tr>
				<th>#request.content.teams_team#</th>
				<th>#request.content.teams_members#</th>
				<th>#request.content.teamleader#</th>
				<th>#request.content.teams_leaderseat#</th>
			</tr>
			<cfloop list="#lTeams#" index="item">
				<cfset queryobject = stTeams[item].players>
				<cfquery dbtype="query" name="qPlayersReady">
					SELECT id, userid, status
					FROM queryobject
					WHERE status = 'ready'
				</cfquery>
				<cfquery dbtype="query" name="qPlayersWaiting">
					SELECT id, userid, status
					FROM queryobject
					WHERE status = 'waiting'
				</cfquery>
				<tr>
					<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#stTeams[item].id#')#">#HTMLEditFormat(stTeams[item].name)#</a></td>
					<td align="center">#qPlayersReady.recordcount# (#qPlayersWaiting.recordcount#)</td>
					<td><cfif session.userloggedin AND session.userid NEQ stTeams[item].leaderid><a href="javascript:LANshock.userSendMessage(#stTeams[item].leaderid#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a></cfif>
						<a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stTeams[item].leaderid#')#">#stTeams[item].leadername#</a></td>
					<td>
						<cftry>
							<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.event.model.seatplan')#" method="getSeatLinkDataByUserID" returnvariable="stSeat">
								<cfinvokeargument name="userid" value="#stTeams[item].leaderid#">
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
	</cfif>
<cfelse>
	<cfif qTournament.status EQ "signup" AND session.userloggedin AND qTeamCurrentUser.recordcount>
		<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_delete&tournamentid=#attributes.tournamentid#&teamid=#qTeamCurrentUser.id#')#">#request.content.delete_this_team#</a><br>
		#request.content.delete_this_team_hint#
	</cfif>
	<cfif ListLen(lTeams)>
		<table>
			<tr>
				<th colspan="2">#request.content.teamleader#</th>
				<th>#request.content.teams_leaderseat#</th>
			</tr>
			<cfloop list="#lTeams#" index="item">
				<tr>
					<td><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stTeams[item].leaderid#')#">#stTeams[item].leadername#</a></td>
					<td align="right"><cfif session.userloggedin AND session.userid NEQ stTeams[item].leaderid><a href="javascript:LANshock.userSendMessage(#stTeams[item].leaderid#);"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/email.png" alt=""></a><cfelse>&nbsp;</cfif></td>
					<td>
						<cftry>
							<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.event.model.seatplan')#" method="getSeatLinkDataByUserID" returnvariable="stSeat">
								<cfinvokeargument name="userid" value="#stTeams[item].leaderid#">
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
	</cfif>
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">