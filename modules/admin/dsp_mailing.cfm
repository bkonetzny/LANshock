<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_mailing.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
	<div class="headline">#request.content.mailing_headline#</div>
	<div class="headline2">#request.content.mailing_create#</div>

	<cfif ArrayLen(aError)>
		<div class="errorBox">
			#request.content.error#
			<ul>
				<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
				<li>#aError[idxError]#</li>
				</cfloop>
			</ul>
		</div>
	</cfif>

	<table width="90%" align="center">
		<tr>
			<td width="60%" valign="top">
				<fieldset>
					<legend>#request.content.mailing_mailserver_settings#</legend>
					<table width="100%">
						<tr>
							<td colspan="2"><input type="checkbox"<cfif attributes.mailserver_usedefault> checked</cfif> name="mailserver_usedefault" id="mailserver_usedefault"> <label for="mailserver_usedefault">#request.content.mailing_mailserver_usedefault#</label></td>
						</tr>
						<tr>
							<td>#request.content.mailing_mailserver_server#</td>
							<td><input type="text" name="mailserver_server" value="#attributes.mailserver_server#"></td>
						</tr>
						<tr>
							<td>#request.content.mailing_mailserver_port#</td>
							<td><input type="text" name="mailserver_port" value="#attributes.mailserver_port#"></td>
						</tr>
						<tr>
							<td>#request.content.mailing_mailserver_username#</td>
							<td><input type="text" name="mailserver_username" value="#attributes.mailserver_username#"></td>
						</tr>
						<tr>
							<td>#request.content.mailing_mailserver_password#</td>
							<td><input type="password" name="mailserver_password" value="#attributes.mailserver_password#"></td>
						</tr>
					</table>
				</fieldset>
			</td>
			<td align="right" valign="top">
				<fieldset>
					<legend>#request.content.mailing_legend#</legend>
					<table cellpadding="4" width="100%">
						<tr>
							<td valign="top">##username##</td>
							<td valign="top">#request.content.mailing_legend_username#</td>
						</tr>
						<tr>
							<td valign="top">##firstname##</td>
							<td valign="top">#request.content.mailing_legend_firstname#</td>
						</tr>
						<tr>
							<td valign="top">##lastname##</td>
							<td valign="top">#request.content.mailing_legend_lastname#</td>
						</tr>
						<tr>
							<td valign="top">##email##</td>
							<td valign="top">#request.content.mailing_legend_email#</td>
						</tr>
					</table>
				</fieldset>
			</td>
		</tr>
	</table>

	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post" name="form_mailing">
	<input type="hidden" name="form_submitted" value="true">
	<table width="90%" align="center">
		<tr>
			<td>#request.content.mailing_email_from#<br>
				<input type="text" name="email_from" value="#attributes.email_from#" maxlength="255" style="width: 100%;"></td>
		</tr>
		<tr>
			<td>#request.content.mailing_subject#<br>
				<input type="text" name="subject" value="#attributes.subject#" maxlength="255" style="width: 100%;"></td>
		</tr>
		<tr>
			<td>#request.content.mailing_body_plain#<br>
				<textarea name="body_plain" style="width: 100%; height: 200px;">#attributes.body_plain#</textarea></td>
		</tr>
		<tr>
			<td>#request.content.mailing_body_html#<br>
				<textarea name="body_html" style="width: 100%; height: 200px;">#attributes.body_html#</textarea></td>
		</tr>
		<tr>
			<td><input type="submit" value="#request.content.mailing_send#"></td>
		</tr>
	</table>
	</form>
	<script language="javascript">
	<!--
		document.form_mailing.subject.focus();
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">