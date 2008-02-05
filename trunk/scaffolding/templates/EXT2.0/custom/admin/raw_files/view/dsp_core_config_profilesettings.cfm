<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_core_config_profilesettings.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<div class="headline"><!--- TODO: $$$ ---> Profile Settings</div>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th>#request.content.settings_registration_active#</th>
		<td><input type="radio" name="registration_active" id="registration_active1" value="true"<cfif attributes.registration_active> checked</cfif>> <label for="registration_active1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="registration_active" id="registration_active0" value="false"<cfif NOT attributes.registration_active> checked</cfif>> <label for="registration_active0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
	<tr>
		<th>#request.content.settings_edit_personal_data#</th>
		<td><input type="radio" name="edit_personal_data" id="edit_personal_data1" value="true"<cfif attributes.edit_personal_data> checked</cfif>> <label for="edit_personal_data1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="edit_personal_data" id="edit_personal_data0" value="false"<cfif NOT attributes.edit_personal_data> checked</cfif>> <label for="edit_personal_data0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
	<tr>
		<th>#request.content.settings_edit_nickname#</th>
		<td><input type="radio" name="edit_nickname" id="edit_nickname1" value="true"<cfif attributes.edit_nickname> checked</cfif>> <label for="edit_nickname1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="edit_nickname" id="edit_nickname0" value="false"<cfif NOT attributes.edit_nickname> checked</cfif>> <label for="edit_nickname0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">