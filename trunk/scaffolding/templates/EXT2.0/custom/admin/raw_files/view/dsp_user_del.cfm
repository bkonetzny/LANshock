<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_user_del.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->
 
<cfoutput>
<div class="headline">#request.content.user_delete_headline#</div>

#request.content.user_delete_txt#

<table align="center">
	<tr>
		<form action="#myself##myfusebox.thiscircuit#.user_del&#session.URLToken#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="hidden" name="user_id" value="#attributes.user_id#">
		<td><input type="submit" value="#request.content.user_delete_confirm#"></td>
		</form>
		<form action="#myself##myfusebox.thiscircuit#.userlist&#session.URLToken#" method="post">
		<td><input type="submit" value="#request.content.user_delete_abort#"></td>
		</form>
	</tr>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">