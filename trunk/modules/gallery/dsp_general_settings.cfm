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
<div class="headline">#request.content.settings_headline#</div>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table>
	<tr>
		<td align="right">#request.content.settings_item_max_height#</td>
		<td><input type="text" name="item_max_height" value="#stModuleConfig.item.max_height#" maxlength="4" size="4"></td>
	</tr>
	<tr>
		<td align="right">#request.content.settings_item_max_width#</td>
		<td><input type="text" name="item_max_width" value="#stModuleConfig.item.max_width#" maxlength="4" size="4"></td>
	</tr>
	<tr>
		<td align="right">#request.content.settings_tn_max_height#</td>
		<td><input type="text" name="tn_max_height" value="#stModuleConfig.tn.max_height#" maxlength="4" size="4"></td>
	</tr>
	<tr>
		<td align="right">#request.content.settings_tn_max_width#</td>
		<td><input type="text" name="tn_max_width" value="#stModuleConfig.tn.max_width#" maxlength="4" size="4"></td>
	</tr>
	<tr>
		<td align="right">#request.content.settings_items_per_col#</td>
		<td><input type="text" name="items_per_col" value="#stModuleConfig.items_per_col#" maxlength="3" size="3"></td>
	</tr>
	<tr>
		<td align="right">#request.content.settings_user_create#</td>
		<td><input type="checkbox" name="user_create" value="true"<cfif stModuleConfig.user_create> checked</cfif>></td>
	</tr>
	<tr>
		<td align="right">$$$ Resize Smaller Images</td>
		<td><input type="checkbox" name="resize_smaller_items" value="true"<cfif stModuleConfig.resize_smaller_items> checked</cfif>></td>
	</tr>
	<tr>
		<td align="right">$$$ Enable Public Download of ZIP Files</td>
		<td><input type="checkbox" name="public_download" value="true"<cfif stModuleConfig.public_download> checked</cfif>></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">