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
<div class="headline">#request.content.newticket#</div>
<br><br>
<form action="#myself##myfusebox.thiscircuit#.create&#request.session.urltoken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table align="center">
	<tr>
		<td>#request.content.title#:</td>
		<td><input type="text" name="title" value="#attributes.title#" style="width: 400px;"></td>
	</tr>
	<tr>
		<td valign="top">#request.content.problem#:</td>
		<td><textarea name="problem" style="width: 400px; height: 300px;">#attributes.problem#</textarea></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="center"><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">