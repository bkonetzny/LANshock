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
<div class="headline">#request.content.user_delete_headline#</div>

#request.content.user_delete_txt#

<table align="center">
	<tr>
		<form action="#myself##myfusebox.thiscircuit#.user_del&#request.session.URLToken#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="hidden" name="user_id" value="#attributes.user_id#">
		<td><input type="submit" value="#request.content.user_delete_confirm#"></td>
		</form>
		<form action="#myself##myfusebox.thiscircuit#.userlist&#request.session.URLToken#" method="post">
		<td><input type="submit" value="#request.content.user_delete_abort#"></td>
		</form>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">