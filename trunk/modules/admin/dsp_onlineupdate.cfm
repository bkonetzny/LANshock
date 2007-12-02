<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_onlineupdate.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->
	
<cfoutput>
	<div class="headline">#request.content.onlineupdate#</div>
	<table width="90%" align="center">
		<tr>
			<td width="50%">
				<fieldset>
					<legend>#request.content.onlineupdate_version_installed#</legend>
					<table width="90%" align="center">
						<tr>
							<td width="30%">#request.content.onlineupdate_version#</td>
							<td width="70%"><strong>#application.lanshock.settings.version#</strong></td>
						</tr>
						<tr>
							<td>#request.content.onlineupdate_build#</td>
							<td><strong>#UDF_DateTimeFormat(application.lanshock.settings.version_build)#</strong></td>
						</tr>
					</table>
				</fieldset>
			</td>
			<td width="50%">
				<fieldset>
					<legend>#request.content.onlineupdate_version_online#</legend>
					<table width="90%" align="center">
						<tr>
							<td width="30%">#request.content.onlineupdate_version#</td>
							<td width="70%"><cfif len(stOnlineUpdate.version)><strong>#stOnlineUpdate.version#</strong><cfelse>&nbsp;</cfif></td>
						</tr>
						<tr>
							<td>#request.content.onlineupdate_build#</td>
							<td><cfif len(stOnlineUpdate.build)><strong>#UDF_DateTimeFormat(stOnlineUpdate.build)#</strong><cfelse>&nbsp;</cfif></td>
						</tr>
					</table>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
					<input type="hidden" name="form_submitted" value="true">
					<input type="submit" value="#request.content.onlineupdate_check_for_updates#">
				</form>
			</td>
		</tr>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">