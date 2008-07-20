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
<h3>#request.content.rankings_headline#</h3>

<table align="center">
<cfloop query="qGroups">
	<tr>
		<td colspan="2"><h4>#name#</h4></td>
	</tr>
	<cfset iCurrentGroup = id>
	<cfloop query="qTournaments">

		<cfif groupid EQ iCurrentGroup>

			<cftry>
				<cfinvoke component="type_#type#" method="getRanking" returnvariable="qRanking">
					<cfinvokeargument name="tournamentid" value="#id#">
				</cfinvoke>
				<cfcatch><cfset qRanking = QueryNew('id')></cfcatch>
			</cftry>
			<tr>
				<td rowspan="2" valign="top"><cfif len(image)><img src="#application.lanshock.oHelper.UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
				<td><strong><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.ranking&tournamentid=#id#')#">#name#</a></strong></td>
			</tr>
			<tr>
				<td><cfset iCurrentTournament = id>
					<cfif qRanking.recordcount>
						<cfloop query="qRanking">
							<cfif pos LTE 3>
								#pos#. <a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_details&tournamentid=#iCurrentTournament#&teamid=#teamid#')#">#name#</a><br>
							</cfif>
						</cfloop>
					</cfif>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
		</cfif>
	</cfloop>
</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">