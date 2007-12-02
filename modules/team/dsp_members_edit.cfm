<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/team/dsp_members_edit.cfm $
$LastChangedDate: 2006-10-23 00:42:15 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 52 $
--->

<cfoutput>
<div class="headline">#request.content.edit_members#</div>

<a href="#myself##myfusebox.thiscircuit#.details&#request.session.UrlToken#" class="link_extended">#request.content.back_to_teamdetails#</a>

<div class="headline2">#request.content.members#</div>

<table class="list">
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<tr>
			<th>#request.content.username#</th>
			<th>#request.content.firstname#</th>
			<th>#request.content.lastname#</th>
			<th>#request.content.status#</th>
		</tr>
		<cfloop query="qTeamMembers">
			<tr>
				<td>#name#</td>
				<td>#firstname#</td>
				<td>#lastname#</td>
				<td><select name="status_#user_id#">
						<option value="leader"<cfif status EQ 'leader'> selected</cfif>>#request.content.status_leader#</option>
						<option value="member"<cfif status EQ 'member'> selected</cfif>>#request.content.status_member#</option>
						<option value="request"<cfif status EQ 'request'> selected</cfif>>#request.content.status_request#</option>
					</select></td>
			</tr>
		</cfloop>
		<tr>
			<td class="empty" colspan="3">&nbsp;</td>
			<td class="empty"><input type="submit" value="#request.content.form_save#"></td>
		</tr>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">