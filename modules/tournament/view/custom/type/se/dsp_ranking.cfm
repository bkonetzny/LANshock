<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_se_ranking.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
<h4>#request.content.type_se_ranking_headline#</h4>

<cfif session.oUser.checkPermissions('manage')>
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.ranking_edit&tournamentid=#qTournament.id#')#">#request.content.type_se_ranking_edit#</a></li>
	</ul>
</cfif>

<table align="center" cellpadding="5">
	<cfset lPosSet = ''>
</cfoutput>
<cfoutput query="qRanking" group="pos">
	<tr>
		<td align="center">
			<cfif NOT ListFind(lPosSet, qRanking.pos)>
				<cfset lPosSet = ListAppend(lPosSet, qRanking.pos)>
				<cfswitch expression="#qRanking.pos#">
					<cfcase value="1"><img src="#stImageDir.module#/ranking_1.gif"></cfcase>
					<cfcase value="2"><img src="#stImageDir.module#/ranking_2.gif"></cfcase>
					<cfcase value="3"><img src="#stImageDir.module#/ranking_3.gif"></cfcase>
					<cfdefaultcase>#qRanking.pos#</cfdefaultcase>
				</cfswitch>
			</cfif></td>
		<td><cfoutput>
				<cfif qTournament.teamsize GT 1>
					<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#attributes.tournamentid#&teamid=#qRanking.teamid#')#">#qRanking.name#</a><br/>
				<cfelse>
					<a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qRanking.leaderid#')#">#qRanking.name#</a><br/>
				</cfif>
			</cfoutput></td>
	</tr>
</cfoutput>
<cfoutput>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">