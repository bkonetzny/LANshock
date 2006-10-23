<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	if(NOT attributes.mailtype) headline = request.content.inbox;
	else headline = request.content.outbox;
</cfscript>

<cfoutput>
	<div class="headline">#headline#</div>
	
	<a href="#myself##myfusebox.thiscircuit#.message_new&#request.session.UrlToken#">#request.content.create_new_message#</a>

	<div align="right">
		<form action="#myself##myfusebox.thiscircuit#.mail_del&all=true&#request.session.UrlToken#" method="post">
			<input type="submit" value="#request.content.deleteall#"<cfif NOT qMessages.recordcount OR attributes.mailtype> disabled</cfif>>
		</form>
	</div>

	<table class="list">
		<tr>
			<th>#request.content.topic#</th>
			<th><cfif NOT attributes.mailtype>#request.content.from#<cfelse>#request.content.to#</cfif></th>
			<th>#request.content.attime#</th>
			<th class="empty">&nbsp;</th>
		</tr>
		<cfloop query="qMessages">
			<cfif NOT len(title)>
				<cfset tmp_topic = "<em>#request.content.notopic#</em>">
			<cfelse>
				<cfset tmp_topic = title>
			</cfif>
			<tr>
				<td width="100%"><a href="#myself##myfusebox.thiscircuit#.message&id=#id#&mailtype=#attributes.mailtype#&#request.session.UrlToken#"><cfif isNew><strong>#tmp_topic#</strong><cfelse>#tmp_topic#</cfif></a></td>
				<td width="100" nowrap><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=<cfif attributes.mailtype>#user_id_to#<cfelse>#user_id_from#</cfif>&#request.session.UrlToken#">#buddyname#</a></td>
				<td nowrap>#UDF_DateTimeFormat(datetime)#</td>
				<td class="empty"><cfif NOT attributes.mailtype><a href="#myself##myfusebox.thiscircuit#.mail_del&id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="" border="0"></a><cfelse>&nbsp;</cfif></td>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">