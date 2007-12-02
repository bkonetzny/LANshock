<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/dsp_setpassword.cfm $
$LastChangedDate: 2006-10-23 00:39:57 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 51 $
--->

<cfoutput>
	<div align="center">
		<table align="center">
			<form action="#myself##myfusebox.thiscircuit#.setpassword&#request.session.UrlToken#" method="post" name="password">
			<input type="hidden" name="form_submitted" value="true">
			<tr>
				<th>#request.content.setpassword_newpassword#</th>
				<td><input type="Password" name="password" size="28">&nbsp;&nbsp;<input type="Submit" name="form_submit" value="#request.content.form_save#"></td>
			</tr>
			</form>
		</table>
	</div>
	<script type="text/javascript">
	<!--
		document.password.password.focus();
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">