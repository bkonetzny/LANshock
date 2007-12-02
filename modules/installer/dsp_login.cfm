<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/dsp_login.cfm $
$LastChangedDate: 2006-10-23 00:39:57 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 51 $
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