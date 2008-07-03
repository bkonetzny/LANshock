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
	<h3>#request.content.online_headline#</h3>
	<table>
		<tr>
			<th>#request.content.online_username#</th>
			<cfif session.oUser.checkPermissions(module="admin",area="*")>
				<th>#request.content.online_location#</th>
				<th>#request.content.online_ip#</th>
				<th>#request.content.online_timestamp#</th>
			</cfif>
		</tr>
		<cfloop from="1" to="#ArrayLen(aStructOrder)#" index="idx">
			<cfset keyUser = aStructOrder[idx]>
			<tr>
				<td<cfif session.oUser.checkPermissions(module="admin",area="*")> rowspan="2"</cfif>><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/#LCase(ListLast(stUserOnline[keyUser].session.stUser.lang,'_'))#.png" alt="#stLocales[stUserOnline[keyUser].session.stUser.lang]#"> <cfif isNumeric(stUserOnline[keyUser].session.stUser.userid) AND stUserOnline[keyUser].session.stUser.userid GT 0><a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#stUserOnline[keyUser].session.stUser.userid#')#">#stUserOnline[keyUser].session.stUser.name#</a><cfelse>#application.lanshock.oHelper.GetUsernameByID(0)#</cfif></td>
				<cfif session.oUser.checkPermissions(module="admin",area="*")>
					<td><a href="#application.lanshock.oHelper.buildUrl('#stUserOnline[keyUser].fusebox.circuit#.#stUserOnline[keyUser].fusebox.action#')#" title="#stUserOnline[keyUser].query_string#">#stUserOnline[keyUser].fusebox.circuit#.#stUserOnline[keyUser].fusebox.action#</a></td>
					<td>#stUserOnline[keyUser].session.stUser.ip_address#</td>
					<td>#session.oUser.DateTimeFormat(stUserOnline[keyUser].session.dtSessionLastCall)# (#DateDiff('n',stUserOnline[keyUser].session.dtSessionLastCall,now())# Min.)
						<br/>#session.oUser.DateTimeFormat(stUserOnline[keyUser].session.dtSessionCreated)# (#DateDiff('n',stUserOnline[keyUser].session.dtSessionCreated,stUserOnline[keyUser].session.dtSessionLastCall)# Min.)</td>
				</cfif>
			</tr>
			<cfif session.oUser.checkPermissions(module="admin",area="*")>
				<tr>
					<td colspan="3">#request.content.online_useragent# <span class="text_small text_light">#stUserOnline[keyUser].http_user_agent#</span></td>
				</tr>
			</cfif>
		</cfloop>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">