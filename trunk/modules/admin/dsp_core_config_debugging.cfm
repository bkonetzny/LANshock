<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_core_config_debugging.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<div class="headline"><!--- TODO: $$$ ---> Debugging</div>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th><!--- TODO: $$$ ---> show plain error</th>
		<td><input type="radio" name="show_plain_error" id="show_plain_error1" value="true"<cfif attributes.show_plain_error> checked</cfif>> <label for="show_plain_error1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="show_plain_error" id="show_plain_error0" value="false"<cfif NOT attributes.show_plain_error> checked</cfif>> <label for="show_plain_error0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> mail error notification</th>
		<td><input type="radio" name="mail_error" id="mail_error1" value="true"<cfif attributes.mail_error> checked</cfif>> <label for="mail_error1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="mail_error" id="mail_error0" value="false"<cfif NOT attributes.mail_error> checked</cfif>> <label for="mail_error0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> mail address</th>
		<td><input type="text" name="error_email" value="#attributes.error_email#"></td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">