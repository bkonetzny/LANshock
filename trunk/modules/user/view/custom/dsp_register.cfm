<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_register.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
<h3>#request.content.register#</h3>

<p>
	#request.content.register_notice# <a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login')#">#request.content.login#</a>.
</p>

<cfif myfusebox.thisfuseaction NEQ 'register' OR stModuleConfig.registration_active>
	<script type="text/javascript">
	<!--
		function validate(){
			$('##btnSave').attr('disabled','disabled');
			return true;
		};
	//-->
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
	
	<form id="frmAddEdit" action="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" method="post" class="uniForm" onsubmit="javascript: return validate();">
		<div class="hidden">
			<input type="hidden" name="form_submitted" value="true"/>
		</div>
	
		<fieldset class="inlineLabels">
			<legend>#request.content.headline_userdata#</legend>
			
			<div class="ctrlHolder">
				<label for="formrow_name"><em>*</em> #request.content.name#</label>
				<input type="text" class="textInput" name="name" id="formrow_name" value="#attributes.name#"/>
			</div>
			
			<div class="ctrlHolder">
				<label for="formrow_email"><em>*</em> #request.content.email#</label>
				<input type="text" class="textInput" name="email" id="formrow_email" value="#attributes.email#"/>
			</div>
		
		</fieldset>
	
		<fieldset class="inlineLabels">
			<legend>#request.content.security#</legend>
			
			<div class="ctrlHolder">
				<label for="formrow_pass1"><em>*</em> #request.content.password#</label>
				<input type="password" class="textInput" name="pass1" id="formrow_pass1" value=""/>
			</div>
			
			<div class="ctrlHolder">
				<label for="formrow_pass2"><em>*</em> #request.content.password_repeat#</label>
				<input type="password" class="textInput" name="pass2" id="formrow_pass2" value=""/>
			</div>
		
		</fieldset>
	
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
	
		<div class="buttonHolder">
			<button type="submit" class="submitButton" id="btnSave"<cfif session.isBot> disabled="disabled"</cfif>>#request.content.form_save#</button>
			<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		</div>
	</form>
<cfelse>
	#request.content.register_deactivated#
</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">