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
<h3>#request.content.message#</h3>

<ul class="options">
	<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main&mailtype=#attributes.mailtype#')#">#request.content.back#</a></li>
</ul>

<div align="center">
	<input type="button" onclick="javascript:LANshock.userSendMessage(<cfif NOT attributes.mailtype>#qMessage.user_id_from#<cfelse>#qMessage.user_id_to#</cfif>);" value="#request.content.reply#">
</div>

<table class="list">
	<tr>
		<th>#request.content.topic#</th>
		<th><cfif qMessage.user_id_to EQ session.oUser.getDataValue('userid')>#request.content.from#<cfelse>#request.content.to#</cfif></th>
		<th>#request.content.attime#</th>
		<th class="empty">&nbsp;</th>
	</tr>
	<cfif NOT len(qMessage.title)>
		<cfset tmp_topic = "<em>#request.content.notopic#</em>">
	<cfelse>
		<cfset tmp_topic = qMessage.title>
	</cfif>
	<cfif qMessage.user_id_to EQ session.oUser.getDataValue('userid')>
		<cfset iUserID = qMessage.user_id_from>
		<cfset sUsername = qMessage.username_from>
	<cfelse>
		<cfset iUserID = qMessage.user_id_to>
		<cfset sUsername = qMessage.username_to>
	</cfif>
	<tr>
		<td width="100%">#tmp_topic#</td>
		<td width="100" nowrap><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#iUserID#')#">#sUsername#</a></td>
		<td nowrap>#session.oUser.DateTimeFormat(qMessage.datetime)#</td>
		<td class="empty"><cfif qMessage.user_id_to EQ session.oUser.getDataValue('userid')><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.mail_del&id=#qMessage.id#')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/delete.png" alt=""></a><cfelse>&nbsp;</cfif></td>
	</tr>
	<tr>
		<td colspan="4">#application.lanshock.oHelper.ConvertText(qMessage.text)#</td>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">