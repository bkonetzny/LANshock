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
<div class="headline">#request.content.group_edit_headline#</div>

<div class="headline2">#request.content.group_edit#</div>
<table>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="id" value="#attributes.id#">
	<tr>
		<td>#request.content.group_name#</td>
		<td><input type="text" name="name" value="#attributes.name#"></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="#request.content.form_add#"></td>
	</tr>
	</form>
</table>

<div class="headline2">#request.content.group_edit_avaible#</div>

<table class="list">
	<tr>
		<th>#request.content.group_name#</th>
		<th class="empty">&nbsp;</th>
	</tr>
	<cfloop query="qGroups">	
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#id#&#request.session.UrlToken#">#name#</a></td>
			<td class="empty"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#" border="0"><!--- <a href="#myself##myfusebox.thiscircuit#.group_del&id=#id#&#request.session.UrlToken#" title="#request.content.form_delete#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#" border="0"></a> ---></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">