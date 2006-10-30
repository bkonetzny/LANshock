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
<div class="headline">#request.content.board_edit_headline#</div>

<div class="headline2">#request.content.board_edit#</div>
<table>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="id" value="#attributes.id#">
	<tr>
		<td>#request.content.board_title#</td>
		<td><input type="text" name="title" value="#attributes.title#"></td>
	</tr>
	<tr>
		<td>#request.content.board_subtitle#</td>
		<td><input type="text" name="subtitle" value="#attributes.subtitle#"></td>
	</tr>
	<tr>
		<td>#request.content.group#</td>
		<td><select name="group_id">
				<cfloop query="qGroups">
					<option value="#id#"<cfif attributes.group_id EQ id> selected</cfif>>#name#</option>
				</cfloop>
			</select></td>
	</tr>
	<!--- <tr>
		<td><!--- TODO: $$$ ---> Mapped Module Comments:</td>
		<td><select name="mapped_module_type">
				<option value=""<cfif attributes.mapped_module_type EQ ''> selected</cfif>></option>
				<cfloop collection="#stModuleTypes#" item="idx">
					<optgroup label="#idx#">
						<cfloop collection="#stModuleTypes[idx]#" item="idx2">
							<option value="#idx#,#idx2#"<cfif attributes.mapped_module_type EQ '#idx#,#idx2#'> selected</cfif>>#idx2# (#stModuleTypes[idx][idx2]#)</option>
						</cfloop>
					</optgroup>
				</cfloop>
			</select></td>
	</tr> --->
	<tr>
		<td colspan="2"><input type="Submit" value="#request.content.form_add#"></td>
	</tr>
	</form>
</table>

<div class="headline2">#request.content.board_edit_avaible#</div>

<table class="list">
	<cfloop query="qGroups">
		<tr>
			<td colspan="3" class="empty"><div class="headline2">#request.content.group# "#name#"</div></td>
		</tr>
		<tr>
			<th>#request.content.board_title#</th>
			<th>#request.content.board_subtitle#</th>
			<th class="empty">&nbsp;</th>
		</tr>
		<cfinvoke component="discussion" method="getBoards" returnvariable="qBoards">
			<cfinvokeargument name="group_id" value="#id#">
		</cfinvoke>
		<cfloop query="qBoards">
			<tr>
				<td><a href="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#id#&#request.session.UrlToken#">#title#</a></td>
				<td>#subtitle#&nbsp;</td>
				<td class="empty"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#" border="0"><!--- <a href="#myself##myfusebox.thiscircuit#.board_del&id=#id#&#request.session.UrlToken#" title="#request.content.form_delete#"><img src="#stImageDir.general#/btn_delete.gif" alt="#request.content.form_delete#" border="0"></a> ---></td>
			</tr>
		</cfloop>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">