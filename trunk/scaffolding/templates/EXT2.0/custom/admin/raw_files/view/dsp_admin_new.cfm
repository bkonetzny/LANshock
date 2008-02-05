<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_admin_new.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
	<div class="headline">#request.content.neworga1#</div>
	
	<a href="#myself##request.lanshock.settings.modulePrefix.core#user.register_admin&#session.UrlToken#" target="_blank" class="link_extended">#request.content.adduser#</a>
	
	<div class="headline2">#request.content.existing_user#</div>
	
	<table>
		<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.UrlToken#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<tr>
			<td><select name="lAdminIDs" multiple size="20">
					<cfloop query="qNonAdmins">
						<option value="#id#">#name#</option>
					</cfloop>
				</select>
			</td>
		</tr>
		<tr>
			<td align="right"><input type="submit" value="#request.content.form_add#"></td>
		</tr>
		</form>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">