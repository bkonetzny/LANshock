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
<div class="headline">#request.content.edit_tournament#</div>

<cfif ArrayLen(aError)>
	<div class="errorBox">
		#request.content.error#
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<table>
	<form action="#myself##myfusebox.thiscircuit#.tournaments_edit_settings&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="id" value="#attributes.id#">
	<input type="hidden" name="type" value="#attributes.type#">
	<input type="hidden" name="export_league" value="#attributes.export_league#">
	<tr>
		<td>#request.content.tournament_id#</td>
		<td><strong><cfif NOT attributes.id LTE 0>#attributes.id#<cfelse>#request.content.new_tournament#</cfif></strong></td>
	</tr>
	<tr>
		<td>#request.content.tournament_name#</td>
		<td><input type="text" name="name" maxlength="255" size="40" value="#HTMLEditFormat(attributes.name)#"></td>
	</tr>
	<tr>
		<td valign="top">#request.content.tournament_group#</td>
		<td><select name="groupid">
				<cfloop query="qGroups">
					<option value="#id#"<cfif attributes.groupid EQ id> selected</cfif>>#name#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td valign="top">#request.content.tournament_image#</td>
		<td><select name="image">
				<cfif attributes.image EQ ''><option value=""></option></cfif>
				<cfloop query="qIcons">
					<option value="#name#"<cfif attributes.image EQ name> selected</cfif>>#name#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td valign="top">#request.content.tournament_type#</td>
		<td><strong><cftry>#request.content['tournament_type_' & attributes.type]#<cfcatch>#attributes.type#</cfcatch></cftry></strong></td>
	</tr>
	<tr>
		<td valign="top">#request.content.tournament_export_league#</td>
		<td><strong>#request.content['tournament_export_league_' & attributes.export_league]#</strong></td>
	</tr>
	<cfif attributes.export_league EQ 'wwcl'>
		<cfset aKeyList = StructSort(stWWCLgameini,'textnocase','ASC','name')>
		<tr>
			<td valign="top">#request.content.tournament_export_league_data_wwcl#</td>
			<td><select name="export_league_data">
					<cfloop from="1" to="#ArrayLen(aKeyList)#" index="idx">
						<option value="#aKeyList[idx]#"<cfif attributes.export_league_data EQ aKeyList[idx]> selected</cfif>>#stWWCLgameini[aKeyList[idx]].name#</option>
					</cfloop>
				</select></td>
		</tr>
	</cfif>
	<tr>
		<td>#request.content.tournament_status#</td>
		<td><strong>#request.content['tournament_status_' & attributes.status]#</strong></td>
	</tr>
	<tr>
		<td>#request.content.tournament_teamsize#</td>
		<td><input<cfif attributes.id NEQ 0> disabled</cfif> type="text" name="teamsize" value="#attributes.teamsize#" maxlength="2" style="width: 20px;"></td>
	</tr>
	<tr>
		<td>#request.content.tournament_teamsubstitute#</td>
		<td><input<cfif attributes.id NEQ 0> disabled</cfif> type="text" name="teamsubstitute" value="#attributes.teamsubstitute#" maxlength="2" style="width: 20px;"></td>
	</tr>
	<tr>
		<td valign="top">#request.content.tournament_rulefile#</td>
		<td><select name="rulefile">
				<cfif attributes.export_league NEQ 'wwcl'><option value=""></option></cfif>
				<cfloop query="qRules">
					<cfif type EQ 'dir'>
						<cfset sParentDir = name>
						<optgroup label="#sParentDir#">
						<cfdirectory action="LIST" directory="#UDF_Module('absPath')#/rules/#name#" name="qRulesSubDir" sort="name ASC">
						<cfloop query="qRulesSubDir">
							<option value="#sParentDir#/#name#"<cfif attributes.rulefile EQ '#sParentDir#/#name#'> selected</cfif>>#name#</option>
						</cfloop>
						</optgroup>
					<cfelse>
						<option value="#name#"<cfif attributes.rulefile EQ name> selected</cfif>>#name#</option>
					</cfif>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td>#request.content.tournament_req_coins#</td>
		<td><input type="text" name="coins" value="#attributes.coins#" maxlength="2" style="width: 20px;"></td>
	</tr>
	<tr>
		<td colspan="2"><br><br></td>
	</tr>
	<cfinclude template="dsp_type_#attributes.type#_tournament_edit.cfm">
	<tr>
		<td colspan="2"><br><br></td>
	</tr>
	<tr>
		<td>#request.content.tournament_estimatedstarttime#</td>
		<td><select name="starttime_day">
				<cfloop from="1" to="31" index="idx">
					<option value="#idx#"<cfif attributes.starttime_day EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			.
			<select name="starttime_month">
				<cfloop from="1" to="12" index="idx">
					<option value="#idx#"<cfif attributes.starttime_month EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			.
			<select name="starttime_year">
				<cfloop from="#year(now())#" to="#year(now())+1#" index="idx">
					<option value="#idx#"<cfif attributes.starttime_year EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			&nbsp;
			<select name="starttime_hour">
				<cfloop from="0" to="23" index="idx">
					<option value="#idx#"<cfif attributes.starttime_hour EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			:
			<select name="starttime_minute">
				<cfloop from="0" to="59" index="idx">
					<option value="#idx#"<cfif attributes.starttime_minute EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td>#request.content.tournament_estimatedendtime#</td>
		<td><select name="endtime_day">
				<cfloop from="1" to="31" index="idx">
					<option value="#idx#"<cfif attributes.endtime_day EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			.
			<select name="endtime_month">
				<cfloop from="1" to="12" index="idx">
					<option value="#idx#"<cfif attributes.endtime_month EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			.
			<select name="endtime_year">
				<cfloop from="#year(now())#" to="#year(now())+1#" index="idx">
					<option value="#idx#"<cfif attributes.endtime_year EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			&nbsp;
			<select name="endtime_hour">
				<cfloop from="0" to="23" index="idx">
					<option value="#idx#"<cfif attributes.endtime_hour EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select>
			:
			<select name="endtime_minute">
				<cfloop from="0" to="59" index="idx">
					<option value="#idx#"<cfif attributes.endtime_minute EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td>#request.content.tournament_timetable_color#</td>
		<td><select name="timetable_color">
				<option>#request.content.tournament_timetable_noentry#</option>
				<optgroup label="#request.content.tournament_timetable_websave_colors#">
				<cfloop list="#lColorNames#" index="idxColor">
					<option value="#idxColor#" style="color: #idxColor#;"<cfif attributes.timetable_color EQ idxColor> selected</cfif>>#idxColor#</option>
				</cfloop>
				</optgroup>
			</select></td>
	</tr>
	<tr>
		<td><!--- TODO: $$$ ---> Admins</td>
		<td><select name="ladminids" multiple>
				<cfloop query="qAdmins">
					<option value="#id#"<cfif listFind(attributes.ladminids,id)> selected</cfif>>#name#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td><!--- TODO: $$$ ---> Infotext</td>
		<td><textarea name="infotext" style="width: 100%; height: 100px;">#attributes.infotext#</textarea></td>
	</tr>
	<tr>
		<td colspan="2"><input type="Submit" value="<cfif attributes.id LTE 0>#request.content.form_add#<cfelse>#request.content.form_save#</cfif>"> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#myself##myfusebox.thiscircuit#.tournaments_edit&#request.session.UrlToken#')"></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">