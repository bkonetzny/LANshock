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