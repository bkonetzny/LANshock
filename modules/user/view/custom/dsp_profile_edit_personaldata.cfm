<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_profile_edit_personaldata.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<h3>#request.content.personal_data#</h3>

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

<form action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" class="uniForm" method="post">
	<div class="hidden">
		<input type="hidden" name="form_submitted" value="true"/>
	</div>
	
	<fieldset class="inlineLabels">
		<legend>#request.content.personal_data#</legend>
			
		<div class="ctrlHolder">
			<label for="formrow_firstname"><em>*</em> #request.content.firstname#</label>
			<input type="text" class="textInput" name="firstname" id="formrow_firstname" value="#attributes.firstname#"/>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_lastname"><em>*</em> #request.content.lastname#</label>
			<input type="text" class="textInput" name="lastname" id="formrow_lastname" value="#attributes.lastname#"/>
		</div>
			
		<div class="ctrlHolder">
			<label for="formrow_dt_birthdate"><em>*</em> #request.content.birthday#</label>
			<div class="divInput" id="divDatePickerdt_birthdate"></div>
			<input type="hidden" name="dt_birthdate" id="formrow_dt_birthdate" value="#LsDateFormat(attributes.dt_birthdate,'YYYY-MM-DD')#"/>
			<script type="text/javascript">
				var myDatePickerdt_birthdate = new Ext.DatePicker({
					handler : function(dp,date){
						var elmDate = Ext.get('formrow_dt_birthdate');
						elmDate.set({value:date.format("Y-m-d")});
					}
				});
				<cfif isDate(attributes.dt_birthdate)>
					var dtdt_birthdate = new Date();
					dtdt_birthdate = Date.parseDate("#LsDateFormat(attributes.dt_birthdate,'YYYY-MM-DD')#","Y-m-d");
					myDatePickerdt_birthdate.setValue(dtdt_birthdate);
				</cfif>
				Ext.onReady(function(){
					myDatePickerdt_birthdate.render('divDatePickerdt_birthdate');
				});
			</script>
		</div>
			
		<div class="ctrlHolder">
			<p class="label"><em>*</em> #request.content.gender#</p>
			<label for="formrow_male" class="inlineLabel"><input type="radio" name="gender" id="formrow_male" value="1"<cfif attributes.gender EQ 1> checked="checked"</cfif>/> #request.content.gender_male#</label>
			<label for="formrow_female" class="inlineLabel"><input type="radio" name="gender" id="formrow_female" value="0"<cfif attributes.gender EQ 0> checked="checked"</cfif>/> #request.content.gender_female#</label>
		</div>
		
		<div class="ctrlHolder">
			<label for="formrow_language"><em>*</em> #request.content.settings_language#</label>
			<select class="selectInput" name="language" id="formrow_language">
				<cfloop list="#ListSort(StructKeyList(stLocales),'textnocase')#" index="idx">
					<option value="#LCase(idx)#"<cfif attributes.language EQ LCase(idx)> selected="selected"</cfif>>#stLocales[idx]#</option>
				</cfloop>
			</select>
		</div>

	</fieldset>
	
	<fieldset class="inlineLabels">
		<legend><!--- $$$ --->Address</legend>
		
		<div class="ctrlHolder">
			<label for="profile_country">#request.content.country#</label>
			<select class="selectInput" name="country" id="profile_country"<cfif bLockEditing> disabled="disabled"</cfif>>
				<option value=""></option>
				<cfloop from="1" to="#ArrayLen(aCountryList)#" index="idx">
					<option value="#aCountryList[idx]#"<cfif attributes.country EQ aCountryList[idx]> selected="selected"</cfif>>#stCountryList[aCountryList[idx]]#</option>
				</cfloop>
			</select>
		</div>

		<div class="ctrlHolder">
			<label for="profile_city">#request.content.city#</label>
			<input type="text" class="textInput" name="city" id="profile_city" value="#attributes.city#"<cfif bLockEditing> disabled="disabled"</cfif>/>
		</div>

		<div class="ctrlHolder">
			<label for="profile_street">#request.content.street#</label>
			<input type="text" class="textInput" name="street" id="profile_street" value="#attributes.street#"<cfif bLockEditing> disabled="disabled"</cfif>/>
		</div>

		<div class="ctrlHolder">
			<label for="profile_zip">#request.content.zip#</label>
			<input type="text" class="textInput" name="zip" id="profile_zip" value="#attributes.zip#"<cfif bLockEditing> disabled="disabled"</cfif>/>
		</div>

	</fieldset>
	<div class="buttonHolder">
		<button type="submit" class="submitButton"<cfif bLockEditing> disabled="disabled"</cfif>>#request.content.form_save#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>

<cfsetting enablecfoutputonly="No">