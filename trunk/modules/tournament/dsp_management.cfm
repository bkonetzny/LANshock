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
<div class="headline">#request.content.management_headline#</div>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">

<div class="headline2">#request.content.management_settings_signup_restrictions#</div>
<table>
	<tr>
		<td><input type="checkbox" name="group_maxsignups" id="group_maxsignups" value="true"<cfif stModuleConfig.groupmaxsignups> checked</cfif>></td>
		<td><label for="group_maxsignups">#request.content.management_settings_groupmaxsignups#</label></td>
	</tr>
	<tr>
		<td><input type="checkbox" name="coin_system" id="coin_system" value="true"<cfif stModuleConfig.coinsystem> checked</cfif>></td>
		<td><label for="coin_system">#request.content.management_settings_coinsystem#</label></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="text" name="coinsystem_usercoins" size="2" maxlength="3" value="#stModuleConfig.coinsystem_usercoins#"> #request.content.management_settings_coinsystem_usercoins#</td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>

<div class="headline2">#request.content.management_layout#</div>
<table>
	<tr>
		<td><input type="checkbox" name="layout_listview_user_change" id="layout_listview_user_change" value="true"<cfif stModuleConfig.layout.listview.user_change> checked</cfif>></td>
		<td><label for="layout_listview_user_change">#request.content.management_layout_user_select#</label></td>
	</tr>
	<tr>
		<td colspan="2">#request.content.management_layout_default#</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><select name="layout_listview_default">
				<option value="1"<cfif stModuleConfig.layout.listview.default EQ 1> selected</cfif>>#request.content.tournaments_view_detailed#</option>
				<option value="2"<cfif stModuleConfig.layout.listview.default EQ 2> selected</cfif>>#request.content.tournaments_view_classic#</option>
				<option value="3"<cfif stModuleConfig.layout.listview.default EQ 3> selected</cfif>>#request.content.tournaments_view_slim#</option>
			</select></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>

<div class="headline2">#request.content.management_rules_headline#</div>

<table class="list">
	<tr>
		<th>#request.content.management_rules_file#</th>
		<th>#request.content.management_rules_lastchange#</th>
		<th class="empty">&nbsp;</th>
	</tr>
	<cfloop query="qRules">
		<cfif type NEQ "dir">
			<tr>
				<td><a href="#UDF_Module('webPath')#rules/#name#" target="_blank">#name#</a></td>
				<td>#UDF_DateTimeFormat(datelastmodified)#</td>
				<td class="empty"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></td>
			</tr>
		</cfif>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">