<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ouser">
<!--- This parameter specifies if we are to use Search Safe URLs or not --->
<cfparam name="request.searchSafe" default="false">
</cfsilent>
<cfoutput>
<script type="text/javascript">
<!--
	function validate(){
		$('##btnSave').attr('disabled','disabled');
		return true;
	};
//-->
</script>
<h3>#request.content.__globalmodule__navigation__user_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.user_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.user_grid_global_edit#</h4>
</cfif>
<cfif isDefined("aTranslatedErrors") AND ArrayLen(aTranslatedErrors)>
	<div class="errorBox">
		<h3>#request.content.error#</h3>
		<ul>
			<cfloop index="i" from="1" to="#arrayLen(aTranslatedErrors)#">
				<li>#aTranslatedErrors[i]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>
<!--- Start of the form --->
<form id="frmAddEdit" action="#self#" method="post" class="uniForm" onsubmit="javascript: return validate();">
	<div class="hidden">
		<input type="hidden" name="fuseaction" value="#XFA.save#" />
		<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
		<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
		<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />
	</div>
	
	

	
		
		
		
		
		
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
		
				
		
	
	
	
	
				
	
	
		
		
	
		
			
			
		
			
			
		
			
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
		
	
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aTable</legend>
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_EF9B6D61861C471384302F020924523B" value="#ouser.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_EF9B6D61861C471384302F020924523B">#request.content.user_rowtype_label_id#</label>
		#Trim(ouser.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2780901F37BE43F1AA1C3AC9BA807057"><em>*</em> #request.content.user_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_2780901F37BE43F1AA1C3AC9BA807057" value="#Trim(ouser.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E6096B565FEA4137AC5BFB4C60438AE6"><em>*</em> #request.content.user_rowtype_label_email#</label>
		<input type="text" class="textInput" name="email" id="formrow_E6096B565FEA4137AC5BFB4C60438AE6" value="#Trim(ouser.getemail())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_ECC1E6AB047343FB9B67027D4B9C594C"><em>*</em> #request.content.user_rowtype_label_pwd#</label>
		<input type="password" class="textInput" name="pwd" id="formrow_ECC1E6AB047343FB9B67027D4B9C594C" value=""/>
		<input type="hidden" class="textInput" name="pwd__hidden" id="formrow_ECC1E6AB047343FB9B67027D4B9C594C__hidden" value="#Trim(ouser.getpwd())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_65FCF3E0D60543E2ABBAD8F9EA75D3F8"><em>*</em> #request.content.user_rowtype_label_firstname#</label>
		<input type="text" class="textInput" name="firstname" id="formrow_65FCF3E0D60543E2ABBAD8F9EA75D3F8" value="#Trim(ouser.getfirstname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_3C46738EAC6340099450A253BDAB7B7D"><em>*</em> #request.content.user_rowtype_label_lastname#</label>
		<input type="text" class="textInput" name="lastname" id="formrow_3C46738EAC6340099450A253BDAB7B7D" value="#Trim(ouser.getlastname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<p class="label"><em>*</em> #request.content.user_rowtype_label_gender#</p>
		
			<cfif isDefined("stRelated.gender_custom.qData")>
				<cfloop query="stRelated.gender_custom.qData">
					<label for="formrow_CF570F8CEC904DE69CD39C08FCAAA9BE_#stRelated.gender_custom.qData.optionvalue#" class="inlineLabel"><input type="radio" name="gender" id="formrow_CF570F8CEC904DE69CD39C08FCAAA9BE_#stRelated.gender_custom.qData.optionvalue#" value="#stRelated.gender_custom.qData.optionvalue#"<cfif ouser.getgender() EQ stRelated.gender_custom.qData.optionvalue> checked="checked"</cfif>/>#stRelated.gender_custom.qData.optionname#</label>
				</cfloop>
			</cfif>
		
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_58F2F7833533462CAAFADE8E95A8DFFE">#request.content.user_rowtype_label_status#</label>
		
			<cfif isDefined("stRelated.status_custom.qData")>
			<select class="selectInput" name="status" id="formrow_58F2F7833533462CAAFADE8E95A8DFFE">
				<option value=""></option>
				<cfloop query="stRelated.status_custom.qData">
					<option value="#stRelated.status_custom.qData.optionvalue#"<cfif ouser.getstatus() EQ stRelated.status_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.status_custom.qData.optionname#</option>
				</cfloop>
			</select>
			</cfif>
		
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(ouser.getdt_birthdate()))>
		<cfset ouser.setdt_birthdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_995F73B8189A472A83AE81DE06912E5C">#request.content.user_rowtype_label_dt_birthdate#</label>
		<div class="divInput" id="divDatePicker995F73B8189A472A83AE81DE06912E5C"></div>
		<input type="hidden" name="dt_birthdate" id="formrow_995F73B8189A472A83AE81DE06912E5C" value="#LsDateFormat(Trim(ouser.getdt_birthdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ouser.getdt_birthdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker995F73B8189A472A83AE81DE06912E5C = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_995F73B8189A472A83AE81DE06912E5C').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker995F73B8189A472A83AE81DE06912E5C.render('divDatePicker995F73B8189A472A83AE81DE06912E5C');
				var dt995F73B8189A472A83AE81DE06912E5C = new Date();
				dt995F73B8189A472A83AE81DE06912E5C = Date.parseDate("#LsDateFormat(Trim(ouser.getdt_birthdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ouser.getdt_birthdate()),'HH:MM')#","Y-m-d G:i");
				myDatePicker995F73B8189A472A83AE81DE06912E5C.setValue(dt995F73B8189A472A83AE81DE06912E5C);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sValue = Trim(ouser.getdt_lastlogin())>
	<input type="hidden" name="dt_lastlogin" id="formrow_4018A47734644EAE8DF763C00E3C8D54" value="#Trim(ouser.getdt_lastlogin())#"/>
	<div class="ctrlHolder">
		<label for="formrow_4018A47734644EAE8DF763C00E3C8D54">#request.content.user_rowtype_label_dt_lastlogin#</label>
		<cfif LsIsDate(sValue)>
			#session.oUser.DateTimeFormat(sValue)#
		<cfelse>
			#sValue#
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sValue = Trim(ouser.getdt_registered())>
	<input type="hidden" name="dt_registered" id="formrow_9DA946FF121E4EBFB71654E069480178" value="#Trim(ouser.getdt_registered())#"/>
	<div class="ctrlHolder">
		<label for="formrow_9DA946FF121E4EBFB71654E069480178">#request.content.user_rowtype_label_dt_registered#</label>
		<cfif LsIsDate(sValue)>
			#session.oUser.DateTimeFormat(sValue)#
		<cfelse>
			#sValue#
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sValue = Trim(ouser.getlogincount())>
	<input type="hidden" name="logincount" id="formrow_9C79E8E07A594EC7ADF0F44C2AEA38A6" value="#Trim(ouser.getlogincount())#"/>
	<div class="ctrlHolder">
		<label for="formrow_9C79E8E07A594EC7ADF0F44C2AEA38A6">#request.content.user_rowtype_label_logincount#</label>
		<cfif LsIsDate(sValue)>
			#session.oUser.DateTimeFormat(sValue)#
		<cfelse>
			#sValue#
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_94500BD966EE42829AD4D6622C014E9C">#request.content.user_rowtype_label_language#</label>
		
			<cfif isDefined("stRelated.language_custom.qData")>
			<select class="selectInput" name="language" id="formrow_94500BD966EE42829AD4D6622C014E9C">
				<option value=""></option>
				<cfloop query="stRelated.language_custom.qData">
					<option value="#stRelated.language_custom.qData.optionvalue#"<cfif ouser.getlanguage() EQ stRelated.language_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.language_custom.qData.optionname#</option>
				</cfloop>
			</select>
			</cfif>
		
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_849CD03E64E64B6F9CEDB0EB9645B050">#request.content.user_rowtype_label_reset_password_key#</label>
		<input type="text" class="textInput" name="reset_password_key" id="formrow_849CD03E64E64B6F9CEDB0EB9645B050" value="#Trim(ouser.getreset_password_key())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F1A5D0C66C1A466F81642B963F98430C">#request.content.user_rowtype_label_openid_url#</label>
		<input type="text" class="textInput" name="openid_url" id="formrow_F1A5D0C66C1A466F81642B963F98430C" value="#Trim(ouser.getopenid_url())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_41777DEA03DD4BE2AA46F5EBDF26C008" class="inlineLabel"><input type="checkbox" name="data_access" id="formrow_41777DEA03DD4BE2AA46F5EBDF26C008" value="1"<cfif ouser.getdata_access()> checked="checked"</cfif>/> <em>*</em>  #request.content.user_rowtype_label_data_access#</label>
		</div>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>optional</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_B8FEE2E906E04217924C347D14BFE8AF">#request.content.user_rowtype_label_country#</label>
		<input type="text" class="textInput" name="country" id="formrow_B8FEE2E906E04217924C347D14BFE8AF" value="#Trim(ouser.getcountry())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_AF3253551C464C6382559BDB2B8902ED">#request.content.user_rowtype_label_city#</label>
		<input type="text" class="textInput" name="city" id="formrow_AF3253551C464C6382559BDB2B8902ED" value="#Trim(ouser.getcity())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_AD84E04200254C828C681B5C8E1EA22D">#request.content.user_rowtype_label_street#</label>
		<input type="text" class="textInput" name="street" id="formrow_AD84E04200254C828C681B5C8E1EA22D" value="#Trim(ouser.getstreet())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A37472ED7B774DC19731FAFAD9166CB8">#request.content.user_rowtype_label_zip#</label>
		<input type="text" class="textInput" name="zip" id="formrow_A37472ED7B774DC19731FAFAD9166CB8" value="#Trim(ouser.getzip())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F0B83DDB2C5B490C83A01A7B9B47A122">#request.content.user_rowtype_label_internal_note#</label>
		<textarea name="internal_note" id="formrow_F0B83DDB2C5B490C83A01A7B9B47A122">#Trim(ouser.getinternal_note())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_80475EEB355E4014A42EF53795BF6029">#request.content.user_rowtype_label_signature#</label>
		<textarea name="signature" id="formrow_80475EEB355E4014A42EF53795BF6029">#Trim(ouser.getsignature())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_80475EEB355E4014A42EF53795BF6029 = new FCKeditor('signature');
				oFCKeditor_formrow_80475EEB355E4014A42EF53795BF6029.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_80475EEB355E4014A42EF53795BF6029.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_80475EEB355E4014A42EF53795BF6029.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_80475EEB355E4014A42EF53795BF6029.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_16CB0C1BDA1E4C3AAAD6D41A4A285F68">#request.content.user_rowtype_label_homepage#</label>
		<input type="text" class="textInput" name="homepage" id="formrow_16CB0C1BDA1E4C3AAAD6D41A4A285F68" value="#Trim(ouser.gethomepage())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0980F8EA10D04A989B4560C85344C4B6">#request.content.user_rowtype_label_geo_latlong#</label>
		<input type="text" class="textInput" name="geo_latlong" id="formrow_0980F8EA10D04A989B4560C85344C4B6" value="#Trim(ouser.getgeo_latlong())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
