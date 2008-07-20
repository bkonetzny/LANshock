<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_group_ranking.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
<h4>#request.content.type_group_ranking_headline#</h4>

<cfif session.oUser.checkPermissions('manage')>
	<a href="#myself##myfusebox.thiscircuit#.ranking_edit&tournamentid=#qTournament.id#&#session.urltoken#" class="link_extended">#request.content.type_group_ranking_edit#</a>
</cfif>
<table align="center" cellpadding="5">
	<cfset lPosSet = ''>
	<cfloop query="qRanking">
		<tr>
			<td align="center">
				<cfif NOT ListFind(lPosSet, pos)>
					<cfset lPosSet = ListAppend(lPosSet, pos)>
					<cfswitch expression="#pos#">
						<cfcase value="1"><img src="#stImageDir.module#/ranking_1.gif"></cfcase>
						<cfcase value="2"><img src="#stImageDir.module#/ranking_2.gif"></cfcase>
						<cfcase value="3"><img src="#stImageDir.module#/ranking_3.gif"></cfcase>
						<cfdefaultcase>#pos#</cfdefaultcase>
					</cfswitch>
				</cfif></td>
			<td><cfswitch expression="#pos#">
					<cfcase value="1,2,3"><span class="text_big">#name#</span></cfcase>
					<cfdefaultcase>#name#</cfdefaultcase>
				</cfswitch></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">