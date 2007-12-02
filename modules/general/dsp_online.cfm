<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_online.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfoutput>
	<h3>#request.content.online_headline#</h3>

	<table>
		<tr>
			<th>#request.content.online_username#</th>
			<cfif request.session.isAdmin>
				<th>#request.content.online_location#</th>
				<th>#request.content.online_ip#</th>
				<th>#request.content.online_timestamp#</th>
			</cfif>
		</tr>
		<cfloop from="1" to="#ArrayLen(aStructOrder)#" index="idx">
		<cfset keyUser = aStructOrder[idx]>
		<tr>
			<td<cfif request.session.isAdmin> rowspan="2"</cfif>><img src="#UDF_Module('webPath')#flags/#LCase(ListLast(stUserOnline[keyUser].session.lang,'_'))#.gif" alt="#stLocales[stUserOnline[keyUser].session.lang]#"> <cfif isNumeric(stUserOnline[keyUser].session.userid)><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#stUserOnline[keyUser].session.userid#&#request.session.UrlToken#">#GetUsernameByID(stUserOnline[keyUser].session.userid)#</a><cfelse>#GetUsernameByID(0)#</cfif></td>
			<cfif request.session.isAdmin>
				<td title="#stUserOnline[keyUser].fusebox.urlvalue#"><cfif StructKeyExists(Application.module,stUserOnline[keyUser].fusebox.circuit)>#Application.module[stUserOnline[keyUser].fusebox.circuit].name#</cfif></td>
				<td>#stUserOnline[keyUser].session.ip_address#</td>
				<td>#UDF_DateTimeFormat(stUserOnline[keyUser].session.timestamp)#</td>
			</cfif>
		</tr>
		<cfif request.session.isAdmin>
			<tr>
				<td colspan="3">#request.content.online_useragent# <span class="text_small text_light">#stUserOnline[keyUser].http_user_agent#</span></td>
			</tr>
		</cfif>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">