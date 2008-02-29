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
		<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login')#" method="post" name="login">
		<input type="hidden" name="form_submitted" value="true"/>
		<tr>
			<th>#request.content.password#</th>
			<td><input type="password" name="password"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="#request.content.login#"/></td>
		</tr>
		</form>
	</table>
	
	#request.content.password_set_in_config#

	<script type="text/javascript">
	<!--
		document.login.password.focus();
	//-->
	</script>
</cfoutput>

<cfsetting enablecfoutputonly="No">