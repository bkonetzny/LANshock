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
<div class="headline">#request.content.groupoverview#</div>
<cfif attributes.id LTE 0>
	<div class="headline2">#request.content.new_group#</div>
<cfelse>
	<div class="headline2">#request.content.edit_group#</div>
</cfif>

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
	<form action="#myself##myfusebox.thiscircuit#.groups_edit&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="id" value="#attributes.id#">
	<tr>
		<td>#request.content.group_id#</td>
		<td><strong><cfif NOT attributes.id LTE 0>#attributes.id#<cfelse>#request.content.new_group#</cfif></strong></td>
	</tr>
	<tr>
		<td>#request.content.group_name#</td>
		<td><input type="text" class="text" name="name" maxlength="255" size="40" value="#HTMLEditFormat(attributes.name)#"></td>
	</tr>
	<tr>
		<td valign="top">#request.content.group_description#</td>
		<td><textarea name="description" style="width: 300px; height: 50px;">#HTMLEditFormat(attributes.description)#</textarea></td>
	</tr>
	<tr>
		<td>#request.content.group_maxsignups#</td>
		<td><input type="Text" class="text" name="maxsignups" maxlength="2" value="#HTMLEditFormat(attributes.maxsignups)#" style="width: 20px;"> #request.content.group_maxsignups_txt#</td>
	</tr>
	<tr>
		<td colspan="2"><input type="Submit" value="<cfif attributes.id LTE 0>#request.content.form_add#<cfelse>#request.content.form_save#</cfif>"><cfif NOT attributes.id LTE 0> <input type="button" value="#request.content.form_cancel#" onClick="javascript:document.location.href('#myself##myfusebox.thiscircuit#.groups_edit&#request.session.UrlToken#')"></cfif></td>
	</tr>
	</form>
</table>
</cfoutput>

<cfoutput>
<div class="headline2">#request.content.avaible_groups#</div>
<table class="list">
	<tr>
		<th>#request.content.group_id#</th>
		<th>#request.content.group_name#</th>
		<th>#request.content.group_description#</th>
		<th>#request.content.group_maxsignups#</th>
		<td class="empty">&nbsp;</th>
	</tr>
	<cfloop query="qGroups">	
		<tr>
			<td align="right">#id#</td>
			<td><a href="#myself##myfusebox.thiscircuit#.groups_edit&id=#id#&#request.session.UrlToken#">#HTMLEditFormat(name)#</a></td>
			<td>#HTMLEditFormat(description)#&nbsp;</td>
			<td><cfif maxsignups EQ 0>#request.content.group_maxsignups_nolimit#<cfelse>#maxsignups#</cfif></td>
			<td class="empty"><a href="#myself##myfusebox.thiscircuit#.groups_delete&id=#id#&#request.session.UrlToken#" title="#request.content.form_delete#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#"></a></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">