<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/dsp_type_group_tournament_edit.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfoutput>
	<tr>
		<td>#request.content.tournament_maxteams#:</td>
		<td><select name="maxteams"<cfif attributes.id NEQ 0> disabled</cfif>>
				<cfloop list="8,16,32,64,128,256,512,1024,2048" index="idx">
					<option value="#idx#"<cfif attributes.maxteams EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td>#request.content.tournament_matchcount#:</td>
		<td><input type="text" name="matchcount" value="#attributes.matchcount#" maxlength="2" style="width: 20px;"></td>
	</tr>
	<tr>
		<td>#request.content.tournament_matchtime#:</td>
		<td><input type="text" name="matchtime" value="#attributes.matchtime#" maxlength="3" style="width: 30px;"> #request.content.tournament_time_minutes#</td>
	</tr>
	<tr>
		<td>#request.content.tournament_pausetime#:</td>
		<td><input type="text" name="pausetime" value="#attributes.pausetime#" maxlength="3" style="width: 30px;"> #request.content.tournament_time_minutes#</td>
	</tr>
</cfoutput>

<cfsetting enablecfoutputonly="No">