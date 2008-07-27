<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_tournament_changestatus.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfset request.content.tournament_status_signup_warning = "Durch w&auml;hlen dieses Status werden alle bisherigen Paarungen und Ergebnisse dieses Turniers gel&ouml;scht. Diese &Auml;nderung kann nicht r&uuml;ckg&auml;ngig gemacht werden! Soll das Turnier wirklich in diesen Status versetzt werden?">
<cfset request.content.tournament_status_warmup_warning = "Durch w&auml;hlen dieses Status wird die Anmeldung gesperrt und die Paarungen der ersten Runde werden vom System gesetzt. Soll das Turnier in diesen Status versetzt werden?">
<cfset request.content.tournament_status_playing_warning = "Durch w&auml;hlen dieses Status beginnt das Turnier und die Teilnehmer k&ouml;nnen Ergebnisse hinterlegen. Soll das Turnier in diesen Status versetzt werden?">
<cfset request.content.tournament_status_paused_warning = "Durch w&auml;hlen dieses Status wird das Turnier als 'Pausiert' gekennzeichnet. Dieser Status ist, bis auf die Kennzeichnung, identisch mit dem 'Spielen' Status. Soll das Turnier in diesen Status versetzt werden?">
<cfset request.content.tournament_status_done_warning = "Durch w&auml;hlen dieses Status wird das Ranking aus den Ergebnissen der Spiele mit Status 'Fertig' ermittelt. Bitte stellen Sie sicher dass alle Spiele den Status 'Fertig' haben. Soll das Turnier in diesen Status versetzt werden?">
<cfset request.content.tournament_status_cancelled_warning = "Durch w&auml;hlen dieses Status wird das Turnier als 'Abgesagt' gekennzeichnet. Es k&ouml;nnen keine &Auml;nderungen mehr an dem Turnier durchgef&uuml;hrt werden. Soll das Turnier in diesen Status versetzt werden?">

<cfoutput>
<h4>#request.content.tournaments_changestatus_headline#</h4>

<ul>
	<li><cfif qTournament.status EQ 'signup'>
			<strong>#request.content.tournament_status_signup#</strong>
		<cfelse>
			<a href="##" onclick="LANshock.Modules.oTournament.changeTournamentStatus('Warnung','#jsStringFormat(request.content.tournament_status_signup_warning)#','WARNING','#jsStringFormat(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=signup'))#');return false;">#request.content.tournament_status_signup#</a>
		</cfif>
		<br/>#request.content.tournament_status_signup_txt#</li>
	<li><cfif qTournament.status EQ 'warmup'>
			<strong>#request.content.tournament_status_warmup#</strong>
		<cfelse>
			<a href="##" onclick="LANshock.Modules.oTournament.changeTournamentStatus('Warnung','#jsStringFormat(request.content.tournament_status_warmup_warning)#','WARNING','#jsStringFormat(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=warmup'))#');return false;">#request.content.tournament_status_warmup#</a>
		</cfif>
		<br/>#request.content.tournament_status_warmup_txt#</li>
	<li><cfif qTournament.status EQ 'playing'>
			<strong>#request.content.tournament_status_playing#</strong>
		<cfelse>
			<a href="##" onclick="LANshock.Modules.oTournament.changeTournamentStatus('Warnung','#jsStringFormat(request.content.tournament_status_playing_warning)#','QUESTION','#jsStringFormat(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=playing'))#');return false;">#request.content.tournament_status_playing#</a>
		</cfif>
		<br/>#request.content.tournament_status_playing_txt#</li>
	<li><cfif qTournament.status EQ 'paused'>
			<strong>#request.content.tournament_status_paused#</strong>
		<cfelse>
			<a href="##" onclick="LANshock.Modules.oTournament.changeTournamentStatus('Warnung','#jsStringFormat(request.content.tournament_status_paused_warning)#','QUESTION','#jsStringFormat(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=paused'))#');return false;">#request.content.tournament_status_paused#</a>
		</cfif>
		<br/>#request.content.tournament_status_paused_txt#</li>
	<li><cfif qTournament.status EQ 'done'>
			<strong>#request.content.tournament_status_done#</strong>
		<cfelse>
			<a href="##" onclick="LANshock.Modules.oTournament.changeTournamentStatus('Warnung','#jsStringFormat(request.content.tournament_status_done_warning)#','QUESTION','#jsStringFormat(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=done'))#');return false;">#request.content.tournament_status_done#</a>
		</cfif>
		<br/>#request.content.tournament_status_done_txt#</li>
	<li><cfif qTournament.status EQ 'cancelled'>
			<strong>#request.content.tournament_status_cancelled#</strong>
		<cfelse>
			<a href="##" onclick="LANshock.Modules.oTournament.changeTournamentStatus('Warnung','#jsStringFormat(request.content.tournament_status_cancelled_warning)#','QUESTION','#jsStringFormat(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#&status=cancelled'))#');return false;">#request.content.tournament_status_cancelled#</a>
		</cfif>
		<br/>#request.content.tournament_status_cancelled_txt#</li>
</ul>
</cfoutput>

<cfsetting enablecfoutputonly="No">