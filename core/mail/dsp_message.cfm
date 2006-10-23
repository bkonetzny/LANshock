<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput query="qMessage">
<div class="headline">#request.content.message#</div>

<a href="#myself##myfusebox.thiscircuit#.main&mailtype=#attributes.mailtype#&#request.session.UrlToken#" class="link_extended">#request.content.back#</a>

<div align="center">
	<input type="button" onClick="javascript:SendMsg(#buddyid#);" value="#request.content.reply#">
</div>

<table class="list">
	<tr>
		<th>#request.content.topic#</th>
		<th><cfif NOT attributes.mailtype>#request.content.from#<cfelse>#request.content.to#</cfif></th>
		<th>#request.content.attime#</th>
		<th class="empty">&nbsp;</th>
	</tr>
	<cfif NOT len(title)>
		<cfset tmp_topic = "<em>#request.content.notopic#</em>">
	<cfelse>
		<cfset tmp_topic = title>
	</cfif>
	<tr>
		<td width="100%">#tmp_topic#</td>
		<td width="100" nowrap><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id_from#&#request.session.UrlToken#">#buddyname#</a></td>
		<td nowrap>#UDF_DateTimeFormat(datetime)#</td>
		<td class="empty"><cfif NOT attributes.mailtype><a href="#myself##myfusebox.thiscircuit#.mail_del&id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="" border="0"></a><cfelse>&nbsp;</cfif></td>
	</tr>
	<tr>
		<td colspan="4">#ConvertText(text)#</td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">