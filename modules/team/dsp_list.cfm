<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/dsp_list.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfoutput>
<div class="headline">#request.content.teamlist#</div>

<a href="#myself##myfusebox.thiscircuit#.details_edit&#request.session.UrlToken#" class="link_extended">#request.content.new_team#</a>

<table class="list">
	<tr>
		<th>#request.content.teamname#</th>
		<th>#request.content.tag#</th>
		<th>#request.content.members#</th>
		<th>#request.content.homepage#</th>
	</tr>
	<cfloop query="qTeams">
		<tr>
			<td><a href="#myself##myfusebox.thiscircuit#.details&id=#id#&#request.session.UrlToken#">#name#</a></td>
			<td><a href="#myself##myfusebox.thiscircuit#.details&id=#id#&#request.session.UrlToken#">#tag#</a></td>
			<td align="center"><a href="#myself##myfusebox.thiscircuit#.details&id=#id#&#request.session.UrlToken#">#members#</a></td>
			<td><a href="#homepage#" target="_blank">#homepage#</a></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">