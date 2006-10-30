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
<div class="headline">Key Comparison</div>

<div class="headline2">Informations</div>

<table cellpadding="5">
	<tr>
		<td>This Directory:</td>
		<td><a href="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#">#attributes.directory#</a></td>
	</tr>
	<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" method="post">
	<input type="hidden" name="form_submitted" value="true">
	<input type="hidden" name="directory" value="#attributes.directory#">
	<tr>
		<td colspan="2"><input type="submit"<cfif NOT len(langDefaults)> disabled</cfif> value="Replace all Keylists with Keylist from Default-File"></td>
	</tr>
	</form>
</table>

<div class="headline2">Default</div>

<cfif NOT len(langDefaults)>
You have to specify a Default Language-File first.
<cfelse>
<table cellpadding="5">
	<tr>
		<th>Language</th>
		<th>File</th>
		<th>Keys</th>
	</tr>
	<tr>
		<td>#stLocales[ListGetAt(langDefaults,2,'.')]#</td>
		<td>#langDefaults#</td>
		<td align="right">#stFiles[langDefaults]#</td>
	</tr>
</table>
</cfif>

<div class="headline2">Files</div>

<table cellpadding="5">
	<tr>
		<th>Language</th>
		<th>File</th>
		<th>Keys</th>
	</tr>
	<cfloop collection="#stFiles#" item="idx">
		<tr>
			<td>#stLocales[ListGetAt(idx,2,'.')]#</td>
			<td>#idx#</td>
			<td align="right"<cfif len(langDefaults) AND stFiles[idx] NEQ stFiles[langDefaults]> style="color: red;"</cfif>>#stFiles[idx]#</td>
		</tr>
	</cfloop>
</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">