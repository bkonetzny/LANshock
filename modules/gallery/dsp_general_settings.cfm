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
<h3>#request.content.settings_headline#</h3>

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm">
<input type="hidden" name="form_submitted" value="true"/>

<fieldset class="inlineLabels">
	<legend>aTable</legend>
	
	<div class="ctrlHolder">
		<label for="formrow_item_max_height">#request.content.settings_item_max_height#</label>
		<input type="text" class="textInput" name="item_max_height" id="formrow_item_max_height" value="#stModuleConfig.item.max_height#" maxlength="4" size="4"/>
	</div>
	
	<div class="ctrlHolder">
		<label for="formrow_item_max_height">#request.content.settings_item_max_width#</label>
		<input type="text" class="textInput" name="item_max_width" id="formrow_item_max_width" value="#stModuleConfig.item.max_width#" maxlength="4" size="4"/>
	</div>
	
	<div class="ctrlHolder">
		<label for="formrow_item_max_height">#request.content.settings_tn_max_height#</label>
		<input type="text" class="textInput" name="tn_max_height" id="formrow_tn_max_height" value="#stModuleConfig.tn.max_height#" maxlength="4" size="4"/>
	</div>
	
	<div class="ctrlHolder">
		<label for="formrow_item_max_height">#request.content.settings_tn_max_width#</label>
		<input type="text" class="textInput" name="tn_max_width" id="formrow_tn_max_width" value="#stModuleConfig.tn.max_width#" maxlength="4" size="4"/>
	</div>
	
	<div class="ctrlHolder">
		<label for="formrow_item_max_height">#request.content.settings_items_per_col#</label>
		<input type="text" class="textInput" name="items_per_col" id="formrow_items_per_col" value="#stModuleConfig.items_per_col#" maxlength="3" size="3"/>
	</div>
	
</fieldset>
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave" onclick="<!--- javascript:save(this.form,'#XFA.Save#'); --->">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset" onclick="javascript:reset(this.form);">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="<!--- javascript:location.href='#self##sortParams#'; --->">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">