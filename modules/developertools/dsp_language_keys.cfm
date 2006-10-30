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
<div class="headline">Edit Keys</div>

<div class="headline2">Informations</div>

<table cellpadding="5">
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="file" value="#attributes.file#">
	<input type="hidden" name="directory" value="#attributes.directory#">
	<cfif NOT len(attributes.file)>
		<tr>
			<td>Save File As:</td>
			<td><select name="newLanguage">
				<cfloop list="#ListSort(StructKeyList(stLocales),'textnocase')#" index="langIdx">
					<option value="#langIdx#">[#langIdx#] - #stLocales[langIdx]#</option>
				</cfloop>
			</select></td>
		</tr>
	<cfelse>
		<tr>
			<td>This File:</td>
			<td>#attributes.file# (#stLocales[ListGetAt(ListLast(attributes.file,'/'),2,'.')]#)</td>
		</tr>
	</cfif>
	<tr>
		<td>This Directory:</td>
		<td><a href="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#">#attributes.directory#</a></td>
	</tr>
</table>

<div class="headline2">Keys</div>

<table cellpadding="5">
	<tr>
		<td align="center">&nbsp;<br><input type="submit" value="Save Keylist"></td>
	</tr>
	<tr>
		<td>New Keylist:<br>
			<textarea name="lang_keys" style="width: 600px; height: 300px;">#attributes.lang_keys#</textarea>
		</td>
	</tr>
	<cfif isDefined("sKeys") AND NOT len(attributes.langFileDefault)>
		<tr>
			<td>Old Keylist:<br>
				<textarea readonly style="width: 600px; height: 300px;">#sKeys#</textarea>
			</td>
		</tr>
	</cfif>
	</form>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">