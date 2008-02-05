<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_core_config_layout.cfm $
$LastChangedDate: 2007-06-10 16:50:09 +0200 (So, 10 Jun 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 87 $
--->

<cfoutput>
<div class="headline"><!--- TODO: $$$ ---> System Apperance</div>

<br>&nbsp;<br>
#request.content.template_txt#
<br>&nbsp;<br>

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

<script type="text/javascript">
<!--
	function setPreviewImage(template){
		document.getElementById("imgPreviewImage").src = "#request.lanshock.environment.webpath#templates/" + template +"/_preview.jpg";
	}
	
	function getSelectedValue(sObj) {
		with (sObj) return options[selectedIndex].value;
	}
//-->
</script>

<form action="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.UrlToken#" name="formTemplate" method="post">
<input type="hidden" name="form_submitted" value="true">
<table class="vlist">
	<tr>
		<th>#request.content.template#</th>
		<td><select name="template" onChange="setPreviewImage(escape(getSelectedValue(document.formTemplate.template)))">
				<cfset sActiveTemplate = attributes.template>
				<cfloop query="qTemplates">
					<cfif type EQ "dir" AND name NEQ "_scripts">
						<option value="#qTemplates.name#"<cfif sActiveTemplate EQ qTemplates.name> selected</cfif>>#qTemplates.name#</option>
					</cfif>
				</cfloop>
			</select><br>
			<img id="imgPreviewImage" style="border: 1px dotted gray;" vspace="2" hspace="2" src="#request.lanshock.environment.webpath#templates/#UrlEncodedFormat(application.lanshock.settings.layout.template)#/_preview.jpg"></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Smileyset</th>
		<td><select name="smileyset">
				<option value=""></option>
				<cfset sActiveSmileys = attributes.smileyset>
				<cfloop query="qSmileySets">
					<option value="#qSmileySets.name#"<cfif sActiveSmileys EQ qSmileySets.name> selected</cfif>>#qSmileySets.name#</option>
				</cfloop>
			</select></td>
	</tr>
	<tr>
		<td colspan="2"><div class="headline2"><!--- TODO: $$$ ---> Avatar</div></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Avatar Mode</th>
		<td><input type="radio" name="avatar_mode" id="avatar_mode_lanshock" value="lanshock"<cfif attributes.avatar_mode EQ 'lanshock'> checked</cfif>> <label for="avatar_mode_lanshock"><!--- TODO: $$$ ---> LANshock</label><br>
			<input type="radio" name="avatar_mode" id="avatar_mode_gravatar" value="gravatar"<cfif attributes.avatar_mode EQ 'gravatar'> checked</cfif>> <label for="avatar_mode_gravatar"><!--- TODO: $$$ ---> Gravatar.com</label></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Avatar Size</th>
		<td><input type="text" name="avatar_width" value="#attributes.avatar_width#" maxlength="3" size="3"> <!--- TODO: $$$ ---> width * <input type="text" name="avatar_height" value="#attributes.avatar_height#" maxlength="3" size="3"> <!--- TODO: $$$ ---> height</td>
	</tr>
	<tr>
		<td colspan="2"><div class="headline2"><!--- TODO: $$$ ---> Text Replacement</div></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Escape HTML</th>
		<td><input type="radio" name="escapehtml" id="escapehtml1" value="true"<cfif attributes.escapehtml> checked</cfif>> <label for="escapehtml1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="escapehtml" id="escapehtml0" value="false"<cfif NOT attributes.escapehtml> checked</cfif>> <label for="escapehtml0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
	<tr>
		<th><!--- TODO: $$$ ---> Pseudocode Replacement</th>
		<td><input type="radio" name="pseudocode" id="pseudocode1" value="true"<cfif attributes.pseudocode> checked</cfif>> <label for="pseudocode1"><!--- TODO: $$$ ---> Yes</label><br>
			<input type="radio" name="pseudocode" id="pseudocode0" value="false"<cfif NOT attributes.pseudocode> checked</cfif>> <label for="pseudocode0"><!--- TODO: $$$ ---> No</label></td>
	</tr>
</table>
<input type="submit" value="#request.content.form_save#">
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">