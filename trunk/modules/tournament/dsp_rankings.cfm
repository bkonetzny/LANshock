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
<div class="headline">#request.content.rankings_headline#</div>

<table align="center">
<cfloop query="qGroups">
	<tr>
		<td colspan="2"><div class="headline2">#name#</div></td>
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
				<td rowspan="2" valign="top"><cfif len(image)><img src="#UDF_Module('webPath')#icons/#image#"><cfelse><img src="#stImageDir.general#/spacer.gif" width="32" height="32"></cfif></td>
				<td><strong><a href="#myself##myfusebox.thiscircuit#.ranking&tournamentid=#id#&#request.session.urltoken#">#name#</a></strong></td>
			</tr>
			<tr>
				<td><cfset iCurrentTournament = id>
					<cfif qRanking.recordcount>
						<cfloop query="qRanking">
							<cfif pos LTE 3>
								#pos#. <a href="#myself##myfusebox.thiscircuit#.team_details&teamid=#teamid#&tournamentid=#iCurrentTournament#&#request.session.urltoken#">#name#</a><br>
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