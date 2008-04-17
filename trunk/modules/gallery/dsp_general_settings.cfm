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
		<legend>#request.content.settings_headline#</legend>
		
		<div class="ctrlHolder">
			<label for="formrow_item_max_height">$$$ Resolutions to Generate</label>
			<input type="text" class="textInput" name="lResolutions" id="lResolutions" value="#stModuleConfig.lResolutions#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_item_max_height">$$$ Resolution of Thumbnails in Gallerylist</label>
			<input type="text" class="textInput" name="lResolutions" id="lResolutions" value="#stModuleConfig.lResolutions#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_item_max_height">$$$ Resolution of Thumbnails in Itemview</label>
			<input type="text" class="textInput" name="lResolutions" id="lResolutions" value="#stModuleConfig.lResolutions#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_item_max_height">$$$ Resolution of Item in Itemview</label>
			<input type="text" class="textInput" name="lResolutions" id="lResolutions" value="#stModuleConfig.lResolutions#"/>
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