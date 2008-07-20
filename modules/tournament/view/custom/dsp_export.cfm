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
<h3>#request.content.export_headline#</h3>

<fieldset>
<legend>#request.content.league_wwcl#</legend>
<table width="100%">
	<tr>
		<td width="50%">#request.content.export_exportable_tournaments#</td>
		<td rowspan="2" style="border-right: 2px solid grey;">&nbsp;</td>
		<td width="50%" valign="top" align="center"><a href="http://www.wwcl.net" target="_blank"><img src="#application.lanshock.oHelper.UDF_Module('webPath')#export/wwcl.gif"></a></td>
	</tr>
	<tr>
		<td>
			<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
			<input type="hidden" name="form_submitted" value="true">
			<input type="hidden" name="type" value="wwcl">
			<table>
				<tr>
					<td>#request.content.export_wwcl_partyname#</td>
					<td><input type="text" name="wwcl_partyname"></td>
				</tr>
				<tr>
					<td>#request.content.export_wwcl_pid#</td>
					<td><input type="text" name="wwcl_pid"></td>
				</tr>
				<tr>
					<td>#request.content.export_wwcl_pvdid#</td>
					<td><input type="text" name="wwcl_pvdid"></td>
				</tr>
				<tr>
					<td>#request.content.export_wwcl_location#</td>
					<td><input type="text" name="wwcl_location"></td>
				</tr>
				<tr>
					<td colspan="2"><select name="tournament_export_ids" multiple size="8" style="width: 300px;">
						<cfloop query="qTournaments">
							<cfif export_league EQ 'wwcl' AND status EQ 'done' AND StructKeyExists(stExportData.WWCL.bGameiniData,export_league_data)>
								<option value="#id#" selected>#name# ---- #stExportData.WWCL.bGameiniData[export_league_data].name#</option>
							</cfif>
						</cfloop>
						</select><br><input type="submit" value="#request.content.export_export#"></td>
				</tr>
			</table>
			</form>
		</td>
		<td valign="top">
			<table>
				<tr>
					<td valign="top"><img src="#stImageDir.module#/export.gif" alt=""></td>
					<td>
						<cfif stExportData.WWCL.bGameini>
							<a href="#application.lanshock.oHelper.UDF_Module('webPath')#export/wwcl/gameini.xml" target="_blank"class="link_extended">#request.content.export_wwcl_gameini#</a><br>
							&nbsp;&nbsp;&nbsp; #request.content.export_wwcl_gameini_date# #session.oUser.DateTimeFormat(stExportData.WWCL.bGameiniDate)#<br>
							&nbsp;&nbsp;&nbsp; #request.content.export_wwcl_gameini_tournaments# #StructCount(stExportData.WWCL.bGameiniData)#<br>
						<cfelse>
							#request.content.export_wwcl_gameini_nofile#<br>
						</cfif>
						&nbsp;<br><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&wwcl_updategameini=true')#">#request.content.export_wwcl_gameini_update#</a>
					</td>
				</tr>
			</table>
			<br>&nbsp;<br>
			<cfif fileExists('#application.lanshock.oHelper.UDF_Module('absPath')#/export/export.wwcl.xml')>
				<table>
					<tr>
						<td valign="top"><img src="#stImageDir.module#/export.gif" alt=""></td>
						<td>
							<a href="#application.lanshock.oHelper.UDF_Module('webPath')#export/export.wwcl.xml"class="link_extended">#request.content.export_exportfile#</a><br>
							<a href="http://xmlcheck.wwcl.net" target="_blank"class="link_extended">#request.content.export_onlinecheck#</a><br>
							<a href="mailto:info@wwcl.net"class="link_extended">#request.content.export_submitfile#</a>
						</td>
					</tr>
				</table>
			<cfelse>#request.content.export_exportfile_nofile#
			</cfif>
		</td>
	</tr>
</table>
</fieldset>
<br>&nbsp;<br>
<!--- <fieldset>
<legend>NGL-Europe</legend>
<table width="100%">
	<tr>
		<td valign="top">Informationen ber die NGL</td>
		<td valign="top" align="right"><a href="http://www.ngl-europe.com" target="_blank"><img src="#stImageDir.module#/ngl.gif" alt="NGL"></a></td>
	</tr>
	<tr>
		<th>Exportfhige Turniere</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="alternate">
			<select name="tournament_export_ids" multiple>
			<cfloop query="qTournaments">
				<cfif export_league EQ 'ngl'>
					<option value="#id#">#name#</option>
				</cfif>
			</cfloop>
			</select></td>
		<td valign="top" align="right">
			<table>
				<tr>
					<td valign="top"><img src="#stImageDir.module#/export.gif" alt=""></td>
					<td>(Generated: 20.08.03 - 20:38:00)<br>&nbsp;<br>
						<a href=""class="link_extended">Export-Datei</a><br>&nbsp;<br>
						<a href="http://www.ngl-europe.com/import/" target="_blank"class="link_extended">Online berprfen</a><br>&nbsp;<br>
						<a href="mailto:info@ngl-europe.com"class="link_extended">bermitteln</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</fieldset> --->
</cfoutput>

<cfsetting enablecfoutputonly="No">