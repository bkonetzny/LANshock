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
	<table>
		<form action="#myself##myfusebox.thiscircuit#.login&#request.session.UrlToken#" method="post" name="login">
		<input type="hidden" name="form_submitted" value="true">
		<tr>
			<th>#request.content.password#</th>
			<td><input type="Password" name="password"></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="Submit" name="form_submit" value="#request.content.login#"></td>
		</tr>
		</form>
	</table>
	
	#request.content.password_set_in_config#

	<SCRIPT LANGUAGE="JavaScript">
	<!--
		document.login.password.focus();
	//-->
	</SCRIPT>
</cfoutput>

<cfsetting enablecfoutputonly="No">