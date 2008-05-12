<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/admin/raw_files/view/custom/dsp_core_config_general.cfm $
$LastChangedDate: 2008-05-12 14:49:49 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 298 $
--->

<cfoutput>
<h3><!--- TODO: $$$ ---> General Settings</h3>

<script type="text/javascript">
	function switchStartpage(activeElement){
		if(activeElement == 'select'){
			$('##formrow_selected_value').show();
			$('##formrow_custom_value').hide();
			$('##formrow_default_value').hide();
		}
		else if(activeElement == 'custom'){
			$('##formrow_selected_value').hide();
			$('##formrow_custom_value').show();
			$('##formrow_default_value').hide();
		}
		else if(activeElement == 'default'){
			$('##formrow_selected_value').hide();
			$('##formrow_custom_value').hide();
			$('##formrow_default_value').show();
		}
	}
</script>

<cfif ArrayLen(aError)>
	<div class="errorBox">
		<h3>#request.content.error#</h3>
		<ul>
			<cfloop from="1" to="#ArrayLen(aError)#" index="idxError">
			<li>#aError[idxError]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend><!--- TODO: $$$ ---> General Settings</legend>
		
		<div class="ctrlHolder">
			<label for="formrow_appname"><em>*</em> #request.content.party_name#</label>
			<input type="text" class="textInput" name="appname" id="formrow_appname" value="#attributes.appname#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_language"><em>*</em> #request.content.default_language#</label>
			<select class="selectInput" name="language" id="formrow_language">
				<cfloop list="#ListSort(StructKeyList(stLocales),'textnocase')#" index="idx">
					<option value="#LCase(idx)#"<cfif attributes.language EQ LCase(idx)> selected="selected"</cfif>>#stLocales[idx]#</option>
				</cfloop>
			</select>
		</div>
			
		<div class="ctrlHolder">
			<p class="label"><em>*</em> <!--- TODO: $$$ ---> Startpage Mode</p>
			<label for="formrow_selected" class="inlineLabel" onclick="switchStartpage('select');"><input type="radio" name="startpage_type" id="formrow_selected" value="selected"<cfif attributes.startpage_type EQ 'selected'> checked="checked"</cfif>> <!--- TODO: $$$ ---> Selected</label>
			<label for="formrow_custom" class="inlineLabel" onclick="switchStartpage('custom');"><input type="radio" name="startpage_type" id="formrow_custom" value="custom"<cfif attributes.startpage_type EQ 'custom' AND len(attributes.startpage_custom)> checked="checked"</cfif>> <!--- TODO: $$$ ---> Custom</label>
			<label for="formrow_default" class="inlineLabel" onclick="switchStartpage('default');"><input type="radio" name="startpage_type" id="formrow_default" value="custom"<cfif attributes.startpage_type EQ 'custom' AND NOT len(attributes.startpage_custom)> checked="checked"</cfif>> <!--- TODO: $$$ ---> Default</label>
		</div>
			
		<div class="ctrlHolder">
			<p class="label"><em>*</em> <!--- TODO: $$$ ---> Startpage</p>
			<div id="formrow_selected_value"<cfif attributes.startpage_type NEQ 'selected'> style="display: none;"</cfif>>
				<select name="startpage" class="selectInput">#sSelectList#</select>
			</div>
			<div id="formrow_custom_value"<cfif attributes.startpage_type NEQ 'custom' OR NOT len(attributes.startpage_custom)> style="display: none;"</cfif>>
				<input type="text" class="textInput" name="startpage_custom" value="#attributes.startpage_custom#">
			</div>
			<div id="formrow_default_value"<cfif attributes.startpage_type NEQ 'custom' OR len(attributes.startpage_custom)> style="display: none;"</cfif>>
				general.welcome
			</div>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_google_maps_key"><!--- TODO: $$$ ---> Google Maps API Key</label>
			<input type="text" class="textInput" name="google_maps_key" id="formrow_google_maps_key" value="#attributes.google_maps_key#"/>
		</div>
	
	</fieldset>

	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.core_config')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">