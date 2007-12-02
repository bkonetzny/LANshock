<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_reset_password.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<div class="headline">#request.content.password_reset_headline#</div>

#request.content.password_reset_info#

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post" name="passwordreset">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist" width="100%">
	<tr>
		<th>#request.content.email#</th>
		<td><input type="text" name="email" value="#HTMLEditFormat(attributes.email)#"></td>
		<td><input type="submit" value="#request.content.password_reset_headline#"></td>
	</tr>
</table>
</form>

<script language="javascript">
<!--
	document.passwordreset.email.focus();
//-->
</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">