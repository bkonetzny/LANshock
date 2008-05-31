<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/dsp_message.cfm $
$LastChangedDate: 2006-10-23 19:20:51 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 61 $
--->

<cfoutput query="qMessage">
<h3>#request.content.message#</h3>

<ul class="options">
	<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main&mailtype=#attributes.mailtype#')#">#request.content.back#</a></li>
</ul>

<div align="center">
	<input type="button" onclick="javascript:LANshock.userSendMessage(#buddyid#);" value="#request.content.reply#">
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
		<td width="100" nowrap><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#user_id_from#')#">#buddyname#</a></td>
		<td nowrap>#session.oUser.DateTimeFormat(datetime)#</td>
		<td class="empty"><cfif NOT attributes.mailtype><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.mail_del&id=#id#')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/delete.png" alt=""></a><cfelse>&nbsp;</cfif></td>
	</tr>
	<tr>
		<td colspan="4">#application.lanshock.oHelper.ConvertText(text)#</td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">