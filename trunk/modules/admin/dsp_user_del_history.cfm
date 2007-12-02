<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_user_del_history.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<div class="headline">#request.content.deleted_users_headline#</div>

<a href="#myself##myfusebox.thiscircuit#.userlist&#request.session.UrlToken#" class="link_extended">#request.content.back_to_userlist#</a>

<table class="list">
	<tr>
		<th>#request.content.deleted_users_deleted_at#</th>
		<th>#request.content.id#</th>
		<th>#request.content.nickname#</th>
		<th>#request.content.prename#</th>
		<th>#request.content.name#</th>
		<th>#request.content.email#</th>
	</tr>
	<cfloop query="qGetDeletedUser">
		<tr>
			<td>#UDF_DateTimeFormat(dt_deleted)#</td>
			<td align="right">#old_id#</td>
			<td>#name#</td>
			<td>#firstname#</td>
			<td>#lastname#</td>
			<td>#email#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">