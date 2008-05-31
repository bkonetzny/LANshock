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
	<input type="hidden" name="id" id="formrow_0AD9D22552294BCEB5E0BE095A55B591" value="#ouser.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_0AD9D22552294BCEB5E0BE095A55B591">#request.content.user_rowtype_label_id#</label>
		#NumberFormat(ouser.getid(),"9.99")#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_44093F13E2F346DB98F25BFC41F7ACA6"><em>*</em> #request.content.user_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_44093F13E2F346DB98F25BFC41F7ACA6" value="#Trim(ouser.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A0EC92CBEB824E2EBDEBE812D92A61B2"><em>*</em> #request.content.user_rowtype_label_email#</label>
		<input type="text" class="textInput" name="email" id="formrow_A0EC92CBEB824E2EBDEBE812D92A61B2" value="#Trim(ouser.getemail())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_1A036A33E26B40588265D989B4C56A83"><em>*</em> #request.content.user_rowtype_label_pwd#</label>
		<input type="password" class="textInput" name="pwd" id="formrow_1A036A33E26B40588265D989B4C56A83" value=""/>
		<input type="hidden" class="textInput" name="pwd__hidden" id="formrow_1A036A33E26B40588265D989B4C56A83__hidden" value="#Trim(ouser.getpwd())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_9A8BC4ADE11A4E3597AD73E85F64415D"><em>*</em> #request.content.user_rowtype_label_firstname#</label>
		<input type="text" class="textInput" name="firstname" id="formrow_9A8BC4ADE11A4E3597AD73E85F64415D" value="#Trim(ouser.getfirstname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_53D78AEDC9FA4842A4D30F0742C94788"><em>*</em> #request.content.user_rowtype_label_lastname#</label>
		<input type="text" class="textInput" name="lastname" id="formrow_53D78AEDC9FA4842A4D30F0742C94788" value="#Trim(ouser.getlastname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<p class="label"><em>*</em> #request.content.user_rowtype_label_gender#</p>
		
			<cfif isDefined("stRelated.gender_custom.qData")>
				<cfloop query="stRelated.gender_custom.qData">
					<label for="formrow_562E8E87E8064BC0A7C7F0099EF3DF04_#stRelated.gender_custom.qData.optionvalue#" class="inlineLabel"><input type="radio" name="gender" id="formrow_562E8E87E8064BC0A7C7F0099EF3DF04_#stRelated.gender_custom.qData.optionvalue#" value="#stRelated.gender_custom.qData.optionvalue#"<cfif ouser.getgender() EQ stRelated.gender_custom.qData.optionvalue> checked="checked"</cfif>/>#stRelated.gender_custom.qData.optionname#</label>
				</cfloop>
			</cfif>
		
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_33363DB600774AB5A168FF6FBB103766"><em>*</em> #request.content.user_rowtype_label_status#</label>
		
			<cfif isDefined("stRelated.status_custom.qData")>
			<select class="selectInput" name="status" id="formrow_33363DB600774AB5A168FF6FBB103766">
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
		<label for="formrow_ADDBF077CB0E477B8C530F5D6C8B42F1">#request.content.user_rowtype_label_dt_birthdate#</label>
		<div class="divInput" id="divDatePickerADDBF077CB0E477B8C530F5D6C8B42F1"></div>
		<input type="hidden" name="dt_birthdate" id="formrow_ADDBF077CB0E477B8C530F5D6C8B42F1" value="#LsDateFormat(Trim(ouser.getdt_birthdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ouser.getdt_birthdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerADDBF077CB0E477B8C530F5D6C8B42F1 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_ADDBF077CB0E477B8C530F5D6C8B42F1').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerADDBF077CB0E477B8C530F5D6C8B42F1.render('divDatePickerADDBF077CB0E477B8C530F5D6C8B42F1');
				var dtADDBF077CB0E477B8C530F5D6C8B42F1 = new Date();
				dtADDBF077CB0E477B8C530F5D6C8B42F1 = Date.parseDate("#LsDateFormat(Trim(ouser.getdt_birthdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ouser.getdt_birthdate()),'HH:MM')#","Y-m-d G:i");
				myDatePickerADDBF077CB0E477B8C530F5D6C8B42F1.setValue(dtADDBF077CB0E477B8C530F5D6C8B42F1);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dt_lastlogin" id="formrow_4BD02AAAAB6E435EA8D8123DF7006F99" value="#Trim(ouser.getdt_lastlogin())#"/>
	<div class="ctrlHolder">
		<label for="formrow_4BD02AAAAB6E435EA8D8123DF7006F99">#request.content.user_rowtype_label_dt_lastlogin#</label>
		#Trim(ouser.getdt_lastlogin())#
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dt_registered" id="formrow_B54DC55E635641E29970502D72BD4A68" value="#Trim(ouser.getdt_registered())#"/>
	<div class="ctrlHolder">
		<label for="formrow_B54DC55E635641E29970502D72BD4A68">#request.content.user_rowtype_label_dt_registered#</label>
		#Trim(ouser.getdt_registered())#
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_393E0EA79F5D40D5868C6BA42E64BDAF"><em>*</em> #request.content.user_rowtype_label_language#</label>
		
			<cfif isDefined("stRelated.language_custom.qData")>
			<select class="selectInput" name="language" id="formrow_393E0EA79F5D40D5868C6BA42E64BDAF">
				<option value=""></option>
				<cfloop query="stRelated.language_custom.qData">
					<option value="#stRelated.language_custom.qData.optionvalue#"<cfif ouser.getlanguage() EQ stRelated.language_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.language_custom.qData.optionname#</option>
				</cfloop>
			</select>
			</cfif>
		
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="logincount" id="formrow_F7B9A1DE5A264A7F936CE0491CDB2F70" value="#NumberFormat(ouser.getlogincount(),"9.99")#"/>
	<div class="ctrlHolder">
		<label for="formrow_F7B9A1DE5A264A7F936CE0491CDB2F70">#request.content.user_rowtype_label_logincount#</label>
		#NumberFormat(ouser.getlogincount(),"9.99")#
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="reset_password_key" id="formrow_97D48ADDA2DB4E8FBC7A9B449CF6BEEB" value="#ouser.getreset_password_key()#" />
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_ABF6E6008F6F41EDB54DDF86F2416781">#request.content.user_rowtype_label_openid_url#</label>
		<input type="text" class="textInput" name="openid_url" id="formrow_ABF6E6008F6F41EDB54DDF86F2416781" value="#Trim(ouser.getopenid_url())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_474B8671E232462D8E9B150CA821AEC3" class="inlineLabel"><input type="checkbox" name="data_access" id="formrow_474B8671E232462D8E9B150CA821AEC3" value="1"<cfif ouser.getdata_access()> checked="checked"</cfif>/> <em>*</em>  #request.content.user_rowtype_label_data_access#</label>
		</div>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToMany</legend>
		
			
				
				
				
				
					

	
	
		<cfset lRelcore_security_users_roles_rel = ouser.getcore_security_users_roles_reliterator().getValueList('role_id')>
		<div class="ctrlHolder">
			<label for="formrow_C28597C79F1842B991ACE2A0BA2F5539">core_security_users_roles_rel</label>
			<select class="selectInput" name="core_security_users_roles_rel" id="formrow_C28597C79F1842B991ACE2A0BA2F5539" multiple="multiple" size="6">
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
		<label for="formrow_CB7666B12C034C9E86D3F5279ECAB743"><em>*</em> #request.content.user_rowtype_label_country#</label>
		<input type="text" class="textInput" name="country" id="formrow_CB7666B12C034C9E86D3F5279ECAB743" value="#Trim(ouser.getcountry())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_79EE0284240240AFA7B37A8292CF8988"><em>*</em> #request.content.user_rowtype_label_city#</label>
		<input type="text" class="textInput" name="city" id="formrow_79EE0284240240AFA7B37A8292CF8988" value="#Trim(ouser.getcity())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_688402CC92ED4313B5E877055FACBBCE"><em>*</em> #request.content.user_rowtype_label_street#</label>
		<input type="text" class="textInput" name="street" id="formrow_688402CC92ED4313B5E877055FACBBCE" value="#Trim(ouser.getstreet())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_691D1515EE9A4432A384245EC74FA443"><em>*</em> #request.content.user_rowtype_label_zip#</label>
		<input type="text" class="textInput" name="zip" id="formrow_691D1515EE9A4432A384245EC74FA443" value="#Trim(ouser.getzip())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F3068B681F4E4F98B4AC9298E217A893">#request.content.user_rowtype_label_internal_note#</label>
		<textarea name="internal_note" id="formrow_F3068B681F4E4F98B4AC9298E217A893">#Trim(ouser.getinternal_note())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6926C223F44A4C8D8590F9A7BE38A5A5">#request.content.user_rowtype_label_signature#</label>
		<textarea name="signature" id="formrow_6926C223F44A4C8D8590F9A7BE38A5A5">#Trim(ouser.getsignature())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_EA8590651CE74A029F3E1C0032E93C7C"><em>*</em> #request.content.user_rowtype_label_homepage#</label>
		<input type="text" class="textInput" name="homepage" id="formrow_EA8590651CE74A029F3E1C0032E93C7C" value="#Trim(ouser.gethomepage())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0F892026062E4CF4B2AA23153BAC9913">#request.content.user_rowtype_label_geo_latlong#</label>
		<input type="text" class="textInput" name="geo_latlong" id="formrow_0F892026062E4CF4B2AA23153BAC9913" value="#Trim(ouser.getgeo_latlong())#"/>
		<cfif len(application.lanshock.settings.google_maps_key)>
			<p class="formHint">
				<div id="formrow_0F892026062E4CF4B2AA23153BAC9913_map" style="width: 100%; height: 300px;"></div>
			</p>
			<script type="text/javascript" src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=test"></script>
			<script type="text/javascript">
				<!--
				$(document).ready(function() {
					if (GBrowserIsCompatible()) {
						function OnMapClicked_0F892026062E4CF4B2AA23153BAC9913(oGLatLng){
							map_0F892026062E4CF4B2AA23153BAC9913.clearOverlays();
							map_0F892026062E4CF4B2AA23153BAC9913.addOverlay(new GMarker(oGLatLng));
							$('##formrow_0F892026062E4CF4B2AA23153BAC9913').val(oGLatLng.lat()+','+oGLatLng.lng());
						}
						var map_0F892026062E4CF4B2AA23153BAC9913 = new GMap2(document.getElementById("formrow_0F892026062E4CF4B2AA23153BAC9913_map"));
						map_0F892026062E4CF4B2AA23153BAC9913.addControl(new GLargeMapControl());
						map_0F892026062E4CF4B2AA23153BAC9913.addControl(new GMapTypeControl());
						<cfif len(Trim(ouser.getgeo_latlong()))>
							map_0F892026062E4CF4B2AA23153BAC9913.setCenter(new GLatLng(#Trim(ouser.getgeo_latlong())#),6,G_HYBRID_MAP);
							map_0F892026062E4CF4B2AA23153BAC9913.addOverlay(new GMarker(new GLatLng(#Trim(ouser.getgeo_latlong())#)));
						<cfelse>
							map_0F892026062E4CF4B2AA23153BAC9913.setCenter(new GLatLng(0,0),1,G_HYBRID_MAP);
						</cfif>
						GEvent.addListener(map_0F892026062E4CF4B2AA23153BAC9913,"click",function(overlay,oGLatLng){if(oGLatLng){OnMapClicked_0F892026062E4CF4B2AA23153BAC9913(oGLatLng);}});
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
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
