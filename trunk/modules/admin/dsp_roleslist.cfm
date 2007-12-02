<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_modules.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<h3>$$$ Roles</h3>

<ul class="options">
	<li><a href="">$$$ New Role</a></li>
</ul>

<table>
	<tr>
		<th>Name</th>
		<th>Users</th>
	</tr>
	<cfloop query="qRoles">
		<tr>
			<td>#name#</td>
			<td></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">