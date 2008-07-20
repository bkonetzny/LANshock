<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_group_ranking_edit.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
<h4>#request.content.type_group_ranking_headline#</h4>

<table align="center">
	<form action="#myself##myfusebox.thiscircuit#.ranking_edit&#session.urltoken#" method="post">
	<input type="hidden" name="tournamentid" value="#qTournament.id#">
	<input type="hidden" name="form_submitted" value="true">
	<cfloop from="1" to="#StructCount(stTeams)#" index="idx">
		<cfparam name="attributes.ranking_pos_#idx#" default="#idx#">
		<cfparam name="attributes.ranking_teamid_#idx#" default="">
		<tr>
			<td><select name="ranking_pos_#idx#">
					<cfloop from="1" to="#StructCount(stTeams)#" index="idxPos">
						<option value="#idxPos#"<cfif attributes['ranking_pos_#idx#'] EQ idxPos> selected</cfif>>#idxPos#</option>
					</cfloop>
				</select></td>
			<td><select name="ranking_teamid_#idx#">
					<option value=""></option>
					<cfloop list="#ListSort(StructKeyList(stTeams),'textnocase','asc')#" index="idxTeam">
						<option value="#stTeams[idxTeam].id#"<cfif attributes['ranking_teamid_#idx#'] EQ stTeams[idxTeam].id> selected</cfif>><cfif qTournament.teamsize EQ 1>#stTeams[idxTeam].leadername#<cfelse>#stTeams[idxTeam].name#</cfif></option>
					</cfloop>
				</select></td>
		</tr>
	</cfloop>
		<tr>
			<td colspan="2" align="center"><input type="submit" value="#request.content.form_save#"></td>
		</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">