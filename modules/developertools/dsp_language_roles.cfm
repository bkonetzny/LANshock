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
<div class="headline">Language Roles</div>

<div class="headline2">Add Role</div>

<table cellpadding="5">
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
		<tr>
			<td>Language:</td>
			<td><select name="language">
					<cfloop list="#ListSort(StructKeyList(stLocales),'textnocase')#" index="langIdx">
						<option value="#langIdx#">#langIdx# - #stLocales[langIdx]#</option>
					</cfloop>
				</select></td>
		</tr>
		<tr>
			<td>User:</td>
			<td><select name="user_id">
					<cfloop query="qUsers">
						<option value="#id#">#name#</option>
					</cfloop>
				</select></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td><input type="submit" value="Add Role"></td>
		</tr>
	</form>
</table>

<div class="headline2">Existing Roles</div>

<table cellpadding="5">
	<tr>
		<th>Language</th>
		<th>User</th>
	</tr>
	<cfloop query="qGetLanguageRoles">
	<tr>
		<td>#language# - #stLocales[language]#</td>
		<td>#GetUserNameById(user_id)#</td>
		<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&language=#language#&user_id=#user_id#&delete=true&#request.session.urltoken#">DELETE</a></td>
	</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">