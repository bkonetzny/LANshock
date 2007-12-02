<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/dsp_panel_buddylist.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfset userOnline = application.sessions.lUserIDs>

<cfoutput>
<table class="list">
	<tr>
		<th colspan="3">#request.content.online#</th>
	</tr>
	<cfloop query="qBuddylist">
		<cfif ListFind(userOnline,id)>
			<tr>
				<td class="empty"><cfif listFind(ValueList(qNewMessagesBuddyIDs.user_id_from),id)><a href="javascript:SendMsg(#id#)"><img src="#stImageDir.module#/newmail_blink.gif" alt="" border="0"></a><cfelse>&nbsp;</cfif></td>
				<td width="100%"><a href="javascript:SendMsg(#id#)">#buddyname#</a></td>
				<td class="empty"><a href="#myself##myfusebox.thiscircuit#.buddy_del&buddy_id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.removeuser#" border="0"></a></td>
			</tr>
		</cfif>
	</cfloop>
	<cfif ListLen(lBuddy_NotInList)>
		<tr>
			<th colspan="3">#request.content.notinlist#</th>
		</tr>
		<cfloop list="#lBuddy_NotInList#" index="id">
			<tr>
				<td class="empty"><a href="javascript:SendMsg(#id#)"><img src="#stImageDir.module#/newmail_blink.gif" alt="" border="0"></a></td>
				<td><a href="javascript:SendMsg(#id#)">#GetUsernameByID(id)#</a></td>
				<td class="empty"><a href="#myself##myfusebox.thiscircuit#.buddy_add&buddy_id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_add.gif" alt="#request.content.addbuddy#" border="0"></a></td>
			</tr>
		</cfloop>
	</cfif>
	<tr>
		<th colspan="3">#request.content.offline#</th>
	</tr>
	<cfloop query="qBuddylist">
		<cfif NOT ListFind(userOnline,id)>
			<tr>
				<td class="empty"><cfif listFind(ValueList(qNewMessagesBuddyIDs.user_id_from),id)><a href="javascript:SendMsg(#id#)"><img src="#stImageDir.module#/newmail_blink.gif" alt="" border="0"></a><cfelse>&nbsp;</cfif></td>
				<td><a href="javascript:SendMsg(#id#)">#buddyname#</a></td>
				<td class="empty"><a href="#myself##myfusebox.thiscircuit#.buddy_del&buddy_id=#id#&#request.session.UrlToken#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.removeuser#" border="0"></a></td>
			</tr>
		</cfif>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">