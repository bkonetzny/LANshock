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
	<input type="hidden" name="id" id="formrow_C50891A39EB74C6DAE3C50094FB3AED4" value="#ouser.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_C50891A39EB74C6DAE3C50094FB3AED4">#request.content.user_rowtype_label_id#</label>
		#NumberFormat(ouser.getid(),"9.99")#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_4195B6D1946449FAB5DE2FFE7C638D5B"><em>*</em> #request.content.user_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_4195B6D1946449FAB5DE2FFE7C638D5B" value="#Trim(ouser.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6EAEAA4400204D4F8623385CBE6F7CDD"><em>*</em> #request.content.user_rowtype_label_email#</label>
		<input type="text" class="textInput" name="email" id="formrow_6EAEAA4400204D4F8623385CBE6F7CDD" value="#Trim(ouser.getemail())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_3A4828CC55E0454E8E9BA7AFA01DB890"><em>*</em> #request.content.user_rowtype_label_pwd#</label>
		<input type="password" class="textInput" name="pwd" id="formrow_3A4828CC55E0454E8E9BA7AFA01DB890" value=""/>
		<input type="hidden" class="textInput" name="pwd__hidden" id="formrow_3A4828CC55E0454E8E9BA7AFA01DB890__hidden" value="#Trim(ouser.getpwd())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E9D9EC30A3A5407FB9D923A0F54C7A4E"><em>*</em> #request.content.user_rowtype_label_firstname#</label>
		<input type="text" class="textInput" name="firstname" id="formrow_E9D9EC30A3A5407FB9D923A0F54C7A4E" value="#Trim(ouser.getfirstname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_9683162E3AFD4AECABB5A4B922FB013D"><em>*</em> #request.content.user_rowtype_label_lastname#</label>
		<input type="text" class="textInput" name="lastname" id="formrow_9683162E3AFD4AECABB5A4B922FB013D" value="#Trim(ouser.getlastname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<p class="label"><em>*</em> #request.content.user_rowtype_label_gender#</p>
		
			<cfif isDefined("stRelated.gender_custom.qData")>
				<cfloop query="stRelated.gender_custom.qData">
					<label for="formrow_FBC6382B51BD448490D8940D806B2CC6_#stRelated.gender_custom.qData.optionvalue#" class="inlineLabel"><input type="radio" name="gender" id="formrow_FBC6382B51BD448490D8940D806B2CC6_#stRelated.gender_custom.qData.optionvalue#" value="#stRelated.gender_custom.qData.optionvalue#"<cfif ouser.getgender() EQ stRelated.gender_custom.qData.optionvalue> checked="checked"</cfif>/>#stRelated.gender_custom.qData.optionname#</label>
				</cfloop>
			</cfif>
		
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E24439AF557C4BC8844E6B1DEACCA03E"><em>*</em> #request.content.user_rowtype_label_status#</label>
		
			<cfif isDefined("stRelated.status_custom.qData")>
			<select class="selectInput" name="status" id="formrow_E24439AF557C4BC8844E6B1DEACCA03E">
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
		<label for="formrow_A689B1CF30604763A7A54825F5C357D2">#request.content.user_rowtype_label_dt_birthdate#</label>
		<div class="divInput" id="divDatePickerA689B1CF30604763A7A54825F5C357D2"></div>
		<input type="hidden" name="dt_birthdate" id="formrow_A689B1CF30604763A7A54825F5C357D2" value="#LsDateFormat(Trim(ouser.getdt_birthdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ouser.getdt_birthdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			var myDatePickerA689B1CF30604763A7A54825F5C357D2 = new Ext.ux.form.DateTime({
				handler: function(){
					$('##formrow_A689B1CF30604763A7A54825F5C357D2').val(myDatePickerA689B1CF30604763A7A54825F5C357D2.getValue().format('Y-m-d G:i'));
				},
				dateFormat: 'Y-m-d',
				timeFormat: 'G:i'
			});
			Ext.onReady(function(){
				myDatePickerA689B1CF30604763A7A54825F5C357D2.render('divDatePickerA689B1CF30604763A7A54825F5C357D2');
				var dtA689B1CF30604763A7A54825F5C357D2 = new Date();
				dtA689B1CF30604763A7A54825F5C357D2 = Date.parseDate("#LsDateFormat(Trim(ouser.getdt_birthdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ouser.getdt_birthdate()),'HH:MM')#","Y-m-d G:i");
				myDatePickerA689B1CF30604763A7A54825F5C357D2.setValue(dtA689B1CF30604763A7A54825F5C357D2);
			});
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dt_lastlogin" id="formrow_929D8C76906A485FB0F1C387E1AB3243" value="#Trim(ouser.getdt_lastlogin())#"/>
	<div class="ctrlHolder">
		<label for="formrow_929D8C76906A485FB0F1C387E1AB3243">#request.content.user_rowtype_label_dt_lastlogin#</label>
		#Trim(ouser.getdt_lastlogin())#
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dt_registered" id="formrow_210CA85D15434E63A560070F1ACAB44C" value="#Trim(ouser.getdt_registered())#"/>
	<div class="ctrlHolder">
		<label for="formrow_210CA85D15434E63A560070F1ACAB44C">#request.content.user_rowtype_label_dt_registered#</label>
		#Trim(ouser.getdt_registered())#
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_686F0BC14B9B4045AC9A596F79A3235C"><em>*</em> #request.content.user_rowtype_label_language#</label>
		
			<cfif isDefined("stRelated.language_custom.qData")>
			<select class="selectInput" name="language" id="formrow_686F0BC14B9B4045AC9A596F79A3235C">
				<option value=""></option>
				<cfloop query="stRelated.language_custom.qData">
					<option value="#stRelated.language_custom.qData.optionvalue#"<cfif ouser.getlanguage() EQ stRelated.language_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.language_custom.qData.optionname#</option>
				</cfloop>
			</select>
			</cfif>
		
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="logincount" id="formrow_5804B3BA25E1451D820DD08EE5BF1EEB" value="#NumberFormat(ouser.getlogincount(),"9.99")#"/>
	<div class="ctrlHolder">
		<label for="formrow_5804B3BA25E1451D820DD08EE5BF1EEB">#request.content.user_rowtype_label_logincount#</label>
		#NumberFormat(ouser.getlogincount(),"9.99")#
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="reset_password_key" id="formrow_76345DA311C34AF5A958E225A59E6466" value="#ouser.getreset_password_key()#" />
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_60375440632945719620DA7374AAE2E4">#request.content.user_rowtype_label_openid_url#</label>
		<input type="text" class="textInput" name="openid_url" id="formrow_60375440632945719620DA7374AAE2E4" value="#Trim(ouser.getopenid_url())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToMany</legend>
		
			
				
				
				
				
					

	
	
		<cfset lRelcore_security_users_roles_rel = ouser.getcore_security_users_roles_reliterator().getValueList('role_id')>
		<div class="ctrlHolder">
			<label for="formrow_FB86BC0AA02744D2B91BBD447A26CA52">core_security_users_roles_rel</label>
			<select class="selectInput" name="core_security_users_roles_rel" id="formrow_FB86BC0AA02744D2B91BBD447A26CA52" multiple="multiple" size="6">
				<option value=""></option>
				<cfloop query="stRelated.stManyToMany.core_security_users_roles_rel.qData">
					<option value="#stRelated.stManyToMany.core_security_users_roles_rel.qData.optionvalue#"<cfif ListFind(lRelcore_security_users_roles_rel,stRelated.stManyToMany.core_security_users_roles_rel.qData.optionvalue)> selected="selected"</cfif>>#stRelated.stManyToMany.core_security_users_roles_rel.qData.optionname#</option>
				</cfloop>
			</select>
		</div>
	
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>optional</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6021B5D552C149CCB71FE8582397B22C"><em>*</em> #request.content.user_rowtype_label_country#</label>
		<input type="text" class="textInput" name="country" id="formrow_6021B5D552C149CCB71FE8582397B22C" value="#Trim(ouser.getcountry())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_8CE1B255988D4D57821C30E3795F496F"><em>*</em> #request.content.user_rowtype_label_city#</label>
		<input type="text" class="textInput" name="city" id="formrow_8CE1B255988D4D57821C30E3795F496F" value="#Trim(ouser.getcity())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_794B1E336C884839B3B1FF9FE40DE39A"><em>*</em> #request.content.user_rowtype_label_street#</label>
		<input type="text" class="textInput" name="street" id="formrow_794B1E336C884839B3B1FF9FE40DE39A" value="#Trim(ouser.getstreet())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_79D00BE4F8E74EF4A2B653AA8AB27FB6"><em>*</em> #request.content.user_rowtype_label_zip#</label>
		<input type="text" class="textInput" name="zip" id="formrow_79D00BE4F8E74EF4A2B653AA8AB27FB6" value="#Trim(ouser.getzip())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_467859EE19844E0F821478DB36CF8187">#request.content.user_rowtype_label_internal_note#</label>
		<textarea name="internal_note" id="formrow_467859EE19844E0F821478DB36CF8187">#Trim(ouser.getinternal_note())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_9776C853F2E34A51B25D7D41EA8F0B13">#request.content.user_rowtype_label_signature#</label>
		<textarea name="signature" id="formrow_9776C853F2E34A51B25D7D41EA8F0B13">#Trim(ouser.getsignature())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_46D06FB4702F4A148F33B9D9D0C807EA"><em>*</em> #request.content.user_rowtype_label_homepage#</label>
		<input type="text" class="textInput" name="homepage" id="formrow_46D06FB4702F4A148F33B9D9D0C807EA" value="#Trim(ouser.gethomepage())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F3DA8BD77FD14FA1A6BDE82543124C6F">#request.content.user_rowtype_label_geo_latlong#</label>
		<input type="text" class="textInput" name="geo_latlong" id="formrow_F3DA8BD77FD14FA1A6BDE82543124C6F" value="#Trim(ouser.getgeo_latlong())#"/>
		<cfif len(application.lanshock.settings.google_maps_key)>
			<p class="formHint">
				<div id="formrow_F3DA8BD77FD14FA1A6BDE82543124C6F_map" style="width: 100%; height: 300px;"></div>
			</p>
			<script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=test"></script>
			<script type="text/javascript">
				<!--
				$(document).ready(function() {
					if (GBrowserIsCompatible()) {
						function OnMapClicked_F3DA8BD77FD14FA1A6BDE82543124C6F(oGLatLng){
							map_F3DA8BD77FD14FA1A6BDE82543124C6F.clearOverlays();
							map_F3DA8BD77FD14FA1A6BDE82543124C6F.addOverlay(new GMarker(oGLatLng));
							$('##formrow_F3DA8BD77FD14FA1A6BDE82543124C6F').val(oGLatLng.lat()+','+oGLatLng.lng());
						}
						var map_F3DA8BD77FD14FA1A6BDE82543124C6F = new GMap2(document.getElementById("formrow_F3DA8BD77FD14FA1A6BDE82543124C6F_map"));
						map_F3DA8BD77FD14FA1A6BDE82543124C6F.addControl(new GLargeMapControl());
						map_F3DA8BD77FD14FA1A6BDE82543124C6F.addControl(new GMapTypeControl());
						<cfif len(Trim(ouser.getgeo_latlong()))>
							map_F3DA8BD77FD14FA1A6BDE82543124C6F.setCenter(new GLatLng(#Trim(ouser.getgeo_latlong())#),6,G_HYBRID_MAP);
							map_F3DA8BD77FD14FA1A6BDE82543124C6F.addOverlay(new GMarker(new GLatLng(#Trim(ouser.getgeo_latlong())#)));
						<cfelse>
							map_F3DA8BD77FD14FA1A6BDE82543124C6F.setCenter(new GLatLng(0,0),1,G_HYBRID_MAP);
						</cfif>
						GEvent.addListener(map_F3DA8BD77FD14FA1A6BDE82543124C6F,"click",function(overlay,oGLatLng){if(oGLatLng){OnMapClicked_F3DA8BD77FD14FA1A6BDE82543124C6F(oGLatLng);}});
					}
				});
				//-->
			</script>
		</cfif>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
