<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_core_config_general.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<div class="headline"><!--- TODO: $$$ ---> General Settings</div>

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

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.UrlToken#" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th>#request.content.party_name#</th>
		<td><input type="text" name="appname" value="#attributes.appname#"></td>
	</tr>
	<tr>
		<th>#request.content.default_language#</th>
		<td><select name="language">
				<cfloop list="#ListSort(StructKeyList(stLocales),'textnocase')#" index="idx">
					<option value="#idx#"<cfif attributes.language EQ idx> selected</cfif>>#idx# - #stLocales[idx]#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<th rowspan="3"><!--- TODO: $$$ ---> Startpage</th>
		<td><input type="radio" name="startpage_type" value="selected"<cfif attributes.startpage_type EQ 'selected'> checked</cfif>> <select name="startpage">#sSelectList#</select></td>
	</tr>
	<tr>
		<td><input type="radio" name="startpage_type" value="custom"<cfif attributes.startpage_type EQ 'custom' AND len(attributes.startpage_custom)> checked</cfif>> <!--- TODO: $$$ ---> Custom <input type="text" name="startpage_custom" value="#attributes.startpage_custom#"></td>
	</tr>
	<tr>
		<td><input type="radio" name="startpage_type" value="custom"<cfif attributes.startpage_type EQ 'custom' AND NOT len(attributes.startpage_custom)> checked</cfif>> <!--- TODO: $$$ ---> Default: general.welcome</td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">