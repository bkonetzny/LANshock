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
<h3><!--- TODO: $$$ ---> Profile Settings</h3>

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
		<legend><!--- TODO: $$$ ---> Profile Settings</legend>
			
		<div class="ctrlHolder">
			<p class="label"><!--- TODO: $$$ ---> #request.content.settings_registration_active#</p>
			<label for="registration_active1" class="inlineLabel">
				<input type="radio" name="registration_active" id="registration_active1" value="true"<cfif attributes.registration_active> checked="checked"</cfif>/>
				<!--- TODO: $$$ ---> Yes
			</label>
			<label for="registration_active0" class="inlineLabel">
				<input type="radio" name="registration_active" id="registration_active0" value="false"<cfif NOT attributes.registration_active> checked="checked"</cfif>/>
				<!--- TODO: $$$ ---> No
			</label>
		</div>
			
		<div class="ctrlHolder">
			<p class="label"><!--- TODO: $$$ ---> #request.content.settings_edit_personal_data#</p>
			<label for="edit_personal_data1" class="inlineLabel">
				<input type="radio" name="edit_personal_data" id="edit_personal_data1" value="true"<cfif attributes.edit_personal_data> checked="checked"</cfif>/>
				<!--- TODO: $$$ ---> Yes
			</label>
			<label for="edit_personal_data0" class="inlineLabel">
				<input type="radio" name="edit_personal_data" id="edit_personal_data0" value="false"<cfif NOT attributes.edit_personal_data> checked="checked"</cfif>/>
				<!--- TODO: $$$ ---> No
			</label>
		</div>
			
		<div class="ctrlHolder">
			<p class="label"><!--- TODO: $$$ ---> #request.content.settings_edit_nickname#</p>
			<label for="edit_nickname1" class="inlineLabel">
				<input type="radio" name="edit_nickname" id="edit_nickname1" value="true"<cfif attributes.edit_nickname> checked="checked"</cfif>/>
				<!--- TODO: $$$ ---> Yes
			</label>
			<label for="edit_nickname0" class="inlineLabel">
				<input type="radio" name="edit_nickname" id="edit_nickname0" value="false"<cfif NOT attributes.edit_nickname> checked="checked"</cfif>/>
				<!--- TODO: $$$ ---> No
			</label>
		</div>
	
	</fieldset>

	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.core_config')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">