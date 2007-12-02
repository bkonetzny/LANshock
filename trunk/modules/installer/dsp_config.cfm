<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/dsp_config.cfm $
$LastChangedDate: 2007-09-30 14:42:48 +0200 (So, 30 Sep 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 102 $
--->

<cfoutput>
<cfif ArrayLen(aError)>
	<div class="errorBox">
		#request.content.error#
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<cfif attributes.bConfigSaved>
	<div align="center" class="text_important">#request.content.configuration_saved#</div>
</cfif>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th>#request.content.setup_password#</th>
		<td><input type="password" name="password" value="#attributes.password#"></td>
	</tr>
	<tr>
		<th>#request.content.datasource#</th>
		<td><cfif listlen(lDatasources)>
				<select name="datasource">
					<option value=""></option>
					<cfloop list="#ListSort(lDatasources,'textnocase')#" index="idx">
						<option value="#idx#"<cfif attributes.datasource EQ idx> selected</cfif>>#idx#</option>
					</cfloop>
				</select>
			<cfelse>
				<input type="text" name="datasource" value="#attributes.datasource#">
			</cfif></td>
	</tr>
	<tr>
		<th>#request.content.datasource_type#</th>
		<td><select name="datasource_type">
				<cfloop list="#ListSort(lDatasourcesTypes,'textnocase')#" index="idx">
					<option value="#idx#"<cfif attributes.datasource_type EQ idx> selected</cfif>>#idx#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<th>$$$ Index File</th>
		<td><input type="text" name="index_file" value="#attributes.index_file#"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="#request.content.form_save#"></td>
	</tr>
</table>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">