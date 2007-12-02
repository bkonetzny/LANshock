<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/dsp_details.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfoutput>
<div class="headline">#request.content.teamdetails#</div>

<cfif NOT isNumeric(qUserMemberData.team_id)>
	<a href="#myself##myfusebox.thiscircuit#.join&id=#qTeam.id#&#request.session.UrlToken#" class="link_extended">#request.content.join_team#</a><br>
</cfif>
<cfif qUserMemberData.team_id EQ qTeam.id>
	<a href="#myself##myfusebox.thiscircuit#.leave&#request.session.UrlToken#" class="link_extended">#request.content.leave_team#</a><br>
</cfif>
<cfif qUserMemberData.team_id EQ qTeam.id AND qUserMemberData.status EQ 'leader'>
	<a href="#myself##myfusebox.thiscircuit#.details_edit&#request.session.UrlToken#" class="link_extended">#request.content.edit_team#</a><br>
	<a href="#myself##myfusebox.thiscircuit#.members_edit&#request.session.UrlToken#" class="link_extended">#request.content.edit_members#</a>
</cfif>

<div class="headline2">#request.content.teaminfo#</div>

<table class="list">
	<tr>
		<th>#request.content.teamname#</th>
		<th>#request.content.tag#</th>
		<th>#request.content.members#</th>
		<th>#request.content.homepage#</th>
	</tr>
	<cfloop query="qTeam">
		<tr>
			<td>#name#</td>
			<td>#tag#</td>
			<td align="center"><a href="#myself##myfusebox.thiscircuit#.details&id=#id#&#request.session.UrlToken#">#members#</a></td>
			<td><a href="#homepage#" target="_blank">#homepage#</a></td>
		</tr>
		<tr>
			<th colspan="4">#request.content.description#</th>
		</tr>
		<tr>
			<td colspan="4">#description#</td>
		</tr>
	</cfloop>
</table>

<div class="headline2">#request.content.members#</div>

<table class="list">
	<tr>
		<th>#request.content.username#</th>
		<th>#request.content.firstname#</th>
		<th>#request.content.lastname#</th>
		<th>#request.content.status#</th>
	</tr>
	<cfloop query="qTeamMembers">
		<tr>
			<td><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&id=#user_id#&#request.session.UrlToken#">#name#</a></td>
			<td>#firstname#</td>
			<td>#lastname#</td>
			<td><cfswitch expression="#status#">
					<cfcase value="leader">#request.content.status_leader#</cfcase>
					<cfcase value="member">#request.content.status_member#</cfcase>
					<cfcase value="request">#request.content.status_request#</cfcase>
				</cfswitch></td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">