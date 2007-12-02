<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/dsp_messagebox_new.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfoutput>
	<div class="headline">#request.content.create_new_message#</div>
	
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" name="newmsg" method="post">
		<input type="hidden" name="form_submitted" value="true">
		<input type="hidden" name="user_id" value="#attributes.user_id#">
		<table class="vlist">
			<tr>
				<th>#request.content.topic#</th>
				<td><input type="text" name="title" maxlength="255" style="width: 300px;" value="#attributes.title#"></td>
				<th>#request.content.to#</th>
			</tr>
			<tr>
				<td>#request.content.text#</th>
				<td><textarea name="text" style="text" style="width: 300px; height: 200px">#attributes.text#</textarea></td>
				<td><select name="user_id" style="width: 100%; height: 200px;" multiple>
						<cfloop query="qBuddylist">
							<option value="#id#">#buddyname#</option>
						</cfloop>
					</select></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="submit" value="#request.content.send#"></td>
				<td>&nbsp;</td>
			</tr>
		</table>
	</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">