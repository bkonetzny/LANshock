<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_tournament">
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
<h3>#request.content.__globalmodule__navigation__tournament_tournament_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_tournament_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_tournament_grid_global_edit#</h4>
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
<form id="frmAddEdit" action="#application.lanshock.oHelper.buildUrl('#xfa.save#')#" method="post" class="uniForm" onsubmit="javascript: return validate();">
	<div class="hidden">
		<!---<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
		<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
		<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />--->
	</div>
	
	

	
		
		
		
		
		
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
		
				
		
	
	
		
		
		
		
		
			
				
				
				
				
				
						
					
				
				
			
		
				
		
	
	
	
				
	
	
		
		
	
		
			
			
		
			
			
		
			
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
		
			
			
				
				
			
		
			
			
				
				
			
		
			
			
		
			
			
		
			
			
		
	
		
			
			
		
	
		
	
	
	

	
	
	

	
	
	
	
	
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aTable</legend>
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_60726F0FA2D244DB894F05B60CF5C4E0" value="#otournament_tournament.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_60726F0FA2D244DB894F05B60CF5C4E0">#request.content.tournament_tournament_rowtype_label_id#</label>
		#Trim(otournament_tournament.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_B793E0BE1A8D4FD198F622153D4CFB97"><em>*</em> #request.content.tournament_tournament_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_B793E0BE1A8D4FD198F622153D4CFB97" value="#Trim(otournament_tournament.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2A27E4D98B354A9D9E7C1FD54A343939"><em>*</em> #request.content.tournament_tournament_rowtype_label_type#</label>
		<cfif isDefined("stRelated.type_custom.qData")>
		<select class="selectInput" name="type" id="formrow_2A27E4D98B354A9D9E7C1FD54A343939">
			<cfloop query="stRelated.type_custom.qData">
				<option value="#stRelated.type_custom.qData.optionvalue#"<cfif otournament_tournament.gettype() EQ stRelated.type_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.type_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_B754EFB282674544853AD160BC9BC4BF"><em>*</em> #request.content.tournament_tournament_rowtype_label_status#</label>
		<cfif isDefined("stRelated.status_custom.qData")>
		<select class="selectInput" name="status" id="formrow_B754EFB282674544853AD160BC9BC4BF">
			<cfloop query="stRelated.status_custom.qData">
				<option value="#stRelated.status_custom.qData.optionvalue#"<cfif otournament_tournament.getstatus() EQ stRelated.status_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.status_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0D771742E7AE43AFB39F145993241F37"><em>*</em> #request.content.tournament_tournament_rowtype_label_rulefile#</label>
		<cfif isDefined("stRelated.rulefile_custom.qData")>
		<select class="selectInput" name="rulefile" id="formrow_0D771742E7AE43AFB39F145993241F37">
			<cfloop query="stRelated.rulefile_custom.qData">
				<option value="#stRelated.rulefile_custom.qData.optionvalue#"<cfif otournament_tournament.getrulefile() EQ stRelated.rulefile_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.rulefile_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C72B0FB3129C4E9F98C78D916F5F7E8A"><em>*</em> #request.content.tournament_tournament_rowtype_label_image#</label>
		<cfif isDefined("stRelated.image_custom.qData")>
		<select class="selectInput" name="image" id="formrow_C72B0FB3129C4E9F98C78D916F5F7E8A">
			<cfloop query="stRelated.image_custom.qData">
				<option value="#stRelated.image_custom.qData.optionvalue#"<cfif otournament_tournament.getimage() EQ stRelated.image_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.image_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_36CA0978BF954760B908A29947333842"><em>*</em> #request.content.tournament_tournament_rowtype_label_coins#</label>
		<input type="text" class="textInput" name="coins" id="formrow_36CA0978BF954760B908A29947333842" value="#Trim(otournament_tournament.getcoins())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_tournament.getstarttime()))>
		<cfset otournament_tournament.setstarttime(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_F87FFAF7E4D54D09BBDBAC467D7F68FD">#request.content.tournament_tournament_rowtype_label_starttime#</label>
		<div class="divInput" id="divDatePickerF87FFAF7E4D54D09BBDBAC467D7F68FD"></div>
		<input type="hidden" name="starttime" id="formrow_F87FFAF7E4D54D09BBDBAC467D7F68FD" value="#LsDateFormat(Trim(otournament_tournament.getstarttime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getstarttime()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerF87FFAF7E4D54D09BBDBAC467D7F68FD = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_F87FFAF7E4D54D09BBDBAC467D7F68FD').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerF87FFAF7E4D54D09BBDBAC467D7F68FD.render('divDatePickerF87FFAF7E4D54D09BBDBAC467D7F68FD');
				var dtF87FFAF7E4D54D09BBDBAC467D7F68FD = new Date();
				dtF87FFAF7E4D54D09BBDBAC467D7F68FD = Date.parseDate("#LsDateFormat(Trim(otournament_tournament.getstarttime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getstarttime()),'HH:MM')#","Y-m-d G:i");
				myDatePickerF87FFAF7E4D54D09BBDBAC467D7F68FD.setValue(dtF87FFAF7E4D54D09BBDBAC467D7F68FD);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_tournament.getendtime()))>
		<cfset otournament_tournament.setendtime(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_508A85B47C8941B8BC2C2288E2FD761B">#request.content.tournament_tournament_rowtype_label_endtime#</label>
		<div class="divInput" id="divDatePicker508A85B47C8941B8BC2C2288E2FD761B"></div>
		<input type="hidden" name="endtime" id="formrow_508A85B47C8941B8BC2C2288E2FD761B" value="#LsDateFormat(Trim(otournament_tournament.getendtime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getendtime()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker508A85B47C8941B8BC2C2288E2FD761B = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_508A85B47C8941B8BC2C2288E2FD761B').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker508A85B47C8941B8BC2C2288E2FD761B.render('divDatePicker508A85B47C8941B8BC2C2288E2FD761B');
				var dt508A85B47C8941B8BC2C2288E2FD761B = new Date();
				dt508A85B47C8941B8BC2C2288E2FD761B = Date.parseDate("#LsDateFormat(Trim(otournament_tournament.getendtime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getendtime()),'HH:MM')#","Y-m-d G:i");
				myDatePicker508A85B47C8941B8BC2C2288E2FD761B.setValue(dt508A85B47C8941B8BC2C2288E2FD761B);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_107538AD6B944CA3B3DC4E0EB8D71460"><em>*</em> #request.content.tournament_tournament_rowtype_label_timetable_color#</label>
		<cfif isDefined("stRelated.timetable_color_custom.qData")>
		<select class="selectInput" name="timetable_color" id="formrow_107538AD6B944CA3B3DC4E0EB8D71460">
			<cfloop query="stRelated.timetable_color_custom.qData">
				<option value="#stRelated.timetable_color_custom.qData.optionvalue#"<cfif otournament_tournament.gettimetable_color() EQ stRelated.timetable_color_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.timetable_color_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E1222E83F29148D294B2779E7F627B05">#request.content.tournament_tournament_rowtype_label_ladminids#</label>
		<input type="text" class="textInput" name="ladminids" id="formrow_E1222E83F29148D294B2779E7F627B05" value="#Trim(otournament_tournament.getladminids())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_61F9F017EE65414FA9C20726C8051DBC">#request.content.tournament_tournament_rowtype_label_infotext#</label>
		<textarea name="infotext" id="formrow_61F9F017EE65414FA9C20726C8051DBC">#Trim(otournament_tournament.getinfotext())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_61F9F017EE65414FA9C20726C8051DBC = new FCKeditor('infotext');
				oFCKeditor_formrow_61F9F017EE65414FA9C20726C8051DBC.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_61F9F017EE65414FA9C20726C8051DBC.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_61F9F017EE65414FA9C20726C8051DBC.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_61F9F017EE65414FA9C20726C8051DBC.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_group = otournament_tournament.gettournament_group().getid()>
	<div class="ctrlHolder">
		<label for="formrow_DA7534A89622452AB706635C5683BDDE">tournament_group</label>
		<select class="selectInput" name="groupid" id="formrow_DA7534A89622452AB706635C5683BDDE">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_group.qData">
				<option value="#stRelated.stManyToOne.tournament_group.qData.optionvalue#"<cfif sReltournament_group EQ stRelated.stManyToOne.tournament_group.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_group.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>team</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_EAC5C5A4F38A40EFAD42C8EE62391FED"><em>*</em> #request.content.tournament_tournament_rowtype_label_maxteams#</label>
		<input type="text" class="textInput" name="maxteams" id="formrow_EAC5C5A4F38A40EFAD42C8EE62391FED" value="#Trim(otournament_tournament.getmaxteams())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F915B794B9ED43E4B4C1EFB4E62A9631"><em>*</em> #request.content.tournament_tournament_rowtype_label_teamsize#</label>
		<input type="text" class="textInput" name="teamsize" id="formrow_F915B794B9ED43E4B4C1EFB4E62A9631" value="#Trim(otournament_tournament.getteamsize())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2F1D9D2B7B514AB2A83738E35BE7DB20"><em>*</em> #request.content.tournament_tournament_rowtype_label_teamsubstitute#</label>
		<input type="text" class="textInput" name="teamsubstitute" id="formrow_2F1D9D2B7B514AB2A83738E35BE7DB20" value="#Trim(otournament_tournament.getteamsubstitute())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>match</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_CEBFBCFA2033496C8438D183F20EC659"><em>*</em> #request.content.tournament_tournament_rowtype_label_pausetime#</label>
		<input type="text" class="textInput" name="pausetime" id="formrow_CEBFBCFA2033496C8438D183F20EC659" value="#Trim(otournament_tournament.getpausetime())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_AECF84E983864FD090F17EE3959D2DC1"><em>*</em> #request.content.tournament_tournament_rowtype_label_matchtime#</label>
		<input type="text" class="textInput" name="matchtime" id="formrow_AECF84E983864FD090F17EE3959D2DC1" value="#Trim(otournament_tournament.getmatchtime())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E1D4403CBA07495E8CC5A774D2295E2B"><em>*</em> #request.content.tournament_tournament_rowtype_label_matchcount#</label>
		<input type="text" class="textInput" name="matchcount" id="formrow_E1D4403CBA07495E8CC5A774D2295E2B" value="#Trim(otournament_tournament.getmatchcount())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>export</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_398CCA18BD1148EC95C6DD5EE0AE88D6">#request.content.tournament_tournament_rowtype_label_export_league#</label>
		<input type="text" class="textInput" name="export_league" id="formrow_398CCA18BD1148EC95C6DD5EE0AE88D6" value="#Trim(otournament_tournament.getexport_league())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_23D066174457496C8D094CA6BCEEEF84">#request.content.tournament_tournament_rowtype_label_export_league_data#</label>
		<input type="text" class="textInput" name="export_league_data" id="formrow_23D066174457496C8D094CA6BCEEEF84" value="#Trim(otournament_tournament.getexport_league_data())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
