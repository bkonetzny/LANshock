<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/dsp_webmail_account_edit.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfoutput>
	<div class="headline">$$$ Account Manager</div>
	
	<div class="headline2">$$$ Edit Account</div>
	
	<table class="vlist">
		<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="hidden" name="id" value="#attributes.id#">
		<tr>
			<th>$$$ Name</th>
			<td><input type="text" name="name" value="#attributes.name#"></td>
		</tr>
		<tr>
			<th>$$$ Username</th>
			<td><input type="text" name="username" value="#attributes.username#"></td>
		</tr>
		<tr>
			<th>$$$ Password</th>
			<td><input type="password" name="password" value="#attributes.password#"></td>
		</tr>
		<tr>
			<th>$$$ Server</th>
			<td><input type="text" name="server" value="#attributes.server#"></td>
		</tr>
		<tr>
			<th>$$$ Port</th>
			<td><input type="text" name="port" value="#attributes.port#" maxlength="5" size="5"></td>
		</tr>
		<tr>
			<th>$$$ Active</th>
			<td><input type="radio" name="isactive" value="1"<cfif attributes.isactive> checked</cfif>> $$$ Active<br>
				<input type="radio" name="isactive" value="0"<cfif NOT attributes.isactive> checked</cfif>> $$$ Inactive</td>
		</tr>
		<tr>
			<td colspan="2"><input type="Submit" name="form_submit" value="#request.content.form_save#"></td>
		</tr>
		</form>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">