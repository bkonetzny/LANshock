<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/dsp_messagebox.cfm $
$LastChangedDate: 2006-10-23 19:15:23 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 60 $
--->

<cfscript>
	if(NOT attributes.mailtype) headline = request.content.inbox;
	else headline = request.content.outbox;
</cfscript>

<cfoutput>
	<h3>#headline#</h3>
	
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.message_new')#">#request.content.create_new_message#</a></li>
	</ul>

	<cfif NOT attributes.mailtype AND qMessages.recordcount>
		<div align="right">
			<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.mail_del&all=true')#" method="post">
				<input type="submit" value="#request.content.deleteall#">
			</form>
		</div>
	</cfif>

	<table>
		<tr>
			<th>#request.content.topic#</th>
			<th><cfif NOT attributes.mailtype>#request.content.from#<cfelse>#request.content.to#</cfif></th>
			<th>#request.content.attime#</th>
			<cfif NOT attributes.mailtype><th>&nbsp;</th></cfif>
		</tr>
		<cfloop query="qMessages">
			<cfif NOT len(qMessages.title)>
				<cfset sTopic = "<em>#request.content.notopic#</em>">
			<cfelse>
				<cfset sTopic = qMessages.title>
			</cfif>
			<cfif attributes.mailtype>
				<cfset iUserID = qMessages.user_id_to>
			<cfelse>
				<cfset iUserID = qMessages.user_id_from>
			</cfif>
			<tr>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.message&id=#qMessages.id#&mailtype=#attributes.mailtype#')#"><cfif qMessages.isNew><strong>#sTopic#</strong><cfelse>#sTopic#</cfif></a></td>
				<td><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#iUserID#')#">#qMessages.buddyname#</a></td>
				<td>#session.oUser.dateTimeFormat(qMessages.datetime)#</td>
				<cfif NOT attributes.mailtype><td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.mail_del&id=#qMessages.id#')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/icons/delete.png" alt=""></a></td></cfif>
			</tr>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">