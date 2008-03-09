<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_core_config_mailserver.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<div class="headline"><!--- TODO: $$$ ---> Mailserver</div>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th><!--- TODO: $$$ ---> Server</th>
		<td><input type="text" name="server" value="#attributes.server#"></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Port</th>
		<td><input type="text" name="port" value="#attributes.port#"></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Username</th>
		<td><input type="text" name="username" value="#attributes.username#"></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Password</th>
		<td><input type="text" name="password" value="#attributes.password#"></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Default Sender E-Mail Address</th>
		<td><input type="text" name="from" value="#attributes.from#"></td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">