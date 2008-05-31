<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/dsp_webmail.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfset bEnableGetHeaders = false>

<cfoutput>
	<h3>$$$ Webmail</h3>
	
	<h4>$$$ Accounts</h4>
	
	<ul class="options">
		<li><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.webmail_account_edit')#">$$$ New Account</a></li>
	</ul>
	
	<table class="list">
		<tr>
			<th class="empty">&nbsp;</th>
			<th>$$$ Name</th>
			<th>$$$ Username</th>
			<th>$$$ Server</th>
			<th class="empty">&nbsp;</th>
		</tr>
		<cfloop query="qAccounts">
			<cfif isactive><cfset bEnableGetHeaders = true></cfif>
			<tr>
				<td class="empty"><img src="#stImageDir.general#/status_led_<cfif isactive>green<cfelse>red</cfif>.gif" alt="isactive = #isactive#"></td>
				<td><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&action_getheader=#id#')#">#name#</a></td>
				<td>#username#</td>
				<td>#server# (#port#)</td>
				<td class="empty"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.webmail_account_edit&id=#id#')#"><img src="#stImageDir.general#/btn_edit.gif" alt="#request.content.form_edit#"></a> <a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.webmail_account_delete&id=#id#')#"><img src="#stImageDir.general#/btn_delete.gif" alt="" border="0"></a></td>
			</tr>
		</cfloop>
	</table>
	
	<div align="center">
		<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post">
			<input type="hidden" name="form_submitted" value="true">
			<input type="hidden" name="action_getheaders" value="true">
			<input type="submit" value="$$$ Get Headers"<cfif NOT bEnableGetHeaders> disabled</cfif>>
		</form>
	</div>

	<cfif NOT StructIsEmpty(stResults)>
		<h4>$$$ E-Mail</h4>
		
		<table class="list">
			<tr>
				<th>$$$ From</th>
				<th>$$$ Subject</th>
				<th>$$$ Date</th>
				<th class="empty">&nbsp;</th>
			</tr>
			<cfloop collection="#stResults#" item="idx">
				<cfif isQuery(stResults[idx])>
					<cfset qMessageHeaders = stResults[idx]>
					<cfloop query="qMessageHeaders">
						<tr>
							<td>#stResults[idx].from#</td>
							<td<cfif left(stResults[idx].subject,14) EQ '*****SPAM*****'> class="text_small text_light text_important"</cfif>><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.webmail_detail&account_id=#idx#&uid=#UrlEncodedFormat(uid)#')#">#stResults[idx].subject#</a></td>
							<td>#UDF_DateTimeFormat(stResults[idx].date)#</td>
							<td class="empty"><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.webmail_delete&account_id=#idx#&uid=#UrlEncodedFormat(uid)#')#"><img src="#stImageDir.general#/btn_delete.gif" alt="" border="0"></a></td>
						</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td rowspan="2">#idx#</td>
						<td colspan="3">#stResults[idx].message#</td>
					</tr>
					<tr>
						<td colspan="3">#stResults[idx].detail#</td>
					</tr>
				</cfif>
			</cfloop>
		</table>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">