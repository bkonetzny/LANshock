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
	<input type="hidden" name="id" id="formrow_2195D97C0E114ACAB93722A069C5D7D4" value="#otournament_tournament.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_2195D97C0E114ACAB93722A069C5D7D4">#request.content.tournament_tournament_rowtype_label_id#</label>
		#Trim(otournament_tournament.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_96F97680C07A442F8D1199D33AC3B835"><em>*</em> #request.content.tournament_tournament_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_96F97680C07A442F8D1199D33AC3B835" value="#Trim(otournament_tournament.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_DFF1B0F823F34EA090BE74C2E8D62EF4"><em>*</em> #request.content.tournament_tournament_rowtype_label_type#</label>
		<cfif isDefined("stRelated.type_custom.qData")>
		<select class="selectInput" name="type" id="formrow_DFF1B0F823F34EA090BE74C2E8D62EF4">
			<cfloop query="stRelated.type_custom.qData">
				<option value="#stRelated.type_custom.qData.optionvalue#"<cfif otournament_tournament.gettype() EQ stRelated.type_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.type_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_54E735142A5541C48B5A7E0317468B2B"><em>*</em> #request.content.tournament_tournament_rowtype_label_status#</label>
		<cfif isDefined("stRelated.status_custom.qData")>
		<select class="selectInput" name="status" id="formrow_54E735142A5541C48B5A7E0317468B2B">
			<cfloop query="stRelated.status_custom.qData">
				<option value="#stRelated.status_custom.qData.optionvalue#"<cfif otournament_tournament.getstatus() EQ stRelated.status_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.status_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_07B75B40203E4CC590AC34EEE783F744"><em>*</em> #request.content.tournament_tournament_rowtype_label_rulefile#</label>
		<cfif isDefined("stRelated.rulefile_custom.qData")>
		<select class="selectInput" name="rulefile" id="formrow_07B75B40203E4CC590AC34EEE783F744">
			<cfloop query="stRelated.rulefile_custom.qData">
				<option value="#stRelated.rulefile_custom.qData.optionvalue#"<cfif otournament_tournament.getrulefile() EQ stRelated.rulefile_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.rulefile_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A85AFED28B5F4CB3A68C6EAC6E6A816F"><em>*</em> #request.content.tournament_tournament_rowtype_label_image#</label>
		<cfif isDefined("stRelated.image_custom.qData")>
		<select class="selectInput" name="image" id="formrow_A85AFED28B5F4CB3A68C6EAC6E6A816F">
			<cfloop query="stRelated.image_custom.qData">
				<option value="#stRelated.image_custom.qData.optionvalue#"<cfif otournament_tournament.getimage() EQ stRelated.image_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.image_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_16C680108CDE4AEEA63E8A1786CA1FE2"><em>*</em> #request.content.tournament_tournament_rowtype_label_coins#</label>
		<input type="text" class="textInput" name="coins" id="formrow_16C680108CDE4AEEA63E8A1786CA1FE2" value="#Trim(otournament_tournament.getcoins())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_tournament.getstarttime()))>
		<cfset otournament_tournament.setstarttime(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_59DBA38E1DA34850949F82D8B38336CA">#request.content.tournament_tournament_rowtype_label_starttime#</label>
		<div class="divInput" id="divDatePicker59DBA38E1DA34850949F82D8B38336CA"></div>
		<input type="hidden" name="starttime" id="formrow_59DBA38E1DA34850949F82D8B38336CA" value="#LsDateFormat(Trim(otournament_tournament.getstarttime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getstarttime()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker59DBA38E1DA34850949F82D8B38336CA = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_59DBA38E1DA34850949F82D8B38336CA').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker59DBA38E1DA34850949F82D8B38336CA.render('divDatePicker59DBA38E1DA34850949F82D8B38336CA');
				var dt59DBA38E1DA34850949F82D8B38336CA = new Date();
				dt59DBA38E1DA34850949F82D8B38336CA = Date.parseDate("#LsDateFormat(Trim(otournament_tournament.getstarttime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getstarttime()),'HH:MM')#","Y-m-d G:i");
				myDatePicker59DBA38E1DA34850949F82D8B38336CA.setValue(dt59DBA38E1DA34850949F82D8B38336CA);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_tournament.getendtime()))>
		<cfset otournament_tournament.setendtime(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_D26F350AA0CD4EF6A196850E1FA13805">#request.content.tournament_tournament_rowtype_label_endtime#</label>
		<div class="divInput" id="divDatePickerD26F350AA0CD4EF6A196850E1FA13805"></div>
		<input type="hidden" name="endtime" id="formrow_D26F350AA0CD4EF6A196850E1FA13805" value="#LsDateFormat(Trim(otournament_tournament.getendtime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getendtime()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerD26F350AA0CD4EF6A196850E1FA13805 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_D26F350AA0CD4EF6A196850E1FA13805').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerD26F350AA0CD4EF6A196850E1FA13805.render('divDatePickerD26F350AA0CD4EF6A196850E1FA13805');
				var dtD26F350AA0CD4EF6A196850E1FA13805 = new Date();
				dtD26F350AA0CD4EF6A196850E1FA13805 = Date.parseDate("#LsDateFormat(Trim(otournament_tournament.getendtime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getendtime()),'HH:MM')#","Y-m-d G:i");
				myDatePickerD26F350AA0CD4EF6A196850E1FA13805.setValue(dtD26F350AA0CD4EF6A196850E1FA13805);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_3B91E080EA50421E88A0BE5F4C4DF189"><em>*</em> #request.content.tournament_tournament_rowtype_label_timetable_color#</label>
		<cfif isDefined("stRelated.timetable_color_custom.qData")>
		<select class="selectInput" name="timetable_color" id="formrow_3B91E080EA50421E88A0BE5F4C4DF189">
			<cfloop query="stRelated.timetable_color_custom.qData">
				<option value="#stRelated.timetable_color_custom.qData.optionvalue#"<cfif otournament_tournament.gettimetable_color() EQ stRelated.timetable_color_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.timetable_color_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_44FF8567761345ED8B64EFD7BC2E2E02">#request.content.tournament_tournament_rowtype_label_ladminids#</label>
		<input type="text" class="textInput" name="ladminids" id="formrow_44FF8567761345ED8B64EFD7BC2E2E02" value="#Trim(otournament_tournament.getladminids())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_19CA0A6E5A234658AD466CCFB46D308C">#request.content.tournament_tournament_rowtype_label_infotext#</label>
		<textarea name="infotext" id="formrow_19CA0A6E5A234658AD466CCFB46D308C">#Trim(otournament_tournament.getinfotext())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_19CA0A6E5A234658AD466CCFB46D308C = new FCKeditor('infotext');
				oFCKeditor_formrow_19CA0A6E5A234658AD466CCFB46D308C.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_19CA0A6E5A234658AD466CCFB46D308C.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_19CA0A6E5A234658AD466CCFB46D308C.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_19CA0A6E5A234658AD466CCFB46D308C.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_group = otournament_tournament.gettournament_group().getid()>
	<div class="ctrlHolder">
		<label for="formrow_C17EB91A55934F24B757339F53483FF1">tournament_group</label>
		<select class="selectInput" name="groupid" id="formrow_C17EB91A55934F24B757339F53483FF1">
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
		<label for="formrow_113E654646264283B24B2BE43449E819"><em>*</em> #request.content.tournament_tournament_rowtype_label_maxteams#</label>
		<input type="text" class="textInput" name="maxteams" id="formrow_113E654646264283B24B2BE43449E819" value="#Trim(otournament_tournament.getmaxteams())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_8B22C16F6C224FC19315B182D44FE8FF"><em>*</em> #request.content.tournament_tournament_rowtype_label_teamsize#</label>
		<input type="text" class="textInput" name="teamsize" id="formrow_8B22C16F6C224FC19315B182D44FE8FF" value="#Trim(otournament_tournament.getteamsize())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_4164399502D84B2C8A18197E282324BD"><em>*</em> #request.content.tournament_tournament_rowtype_label_teamsubstitute#</label>
		<input type="text" class="textInput" name="teamsubstitute" id="formrow_4164399502D84B2C8A18197E282324BD" value="#Trim(otournament_tournament.getteamsubstitute())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>match</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_4EA62A28044A48B585CA74A71F3AB427"><em>*</em> #request.content.tournament_tournament_rowtype_label_pausetime#</label>
		<input type="text" class="textInput" name="pausetime" id="formrow_4EA62A28044A48B585CA74A71F3AB427" value="#Trim(otournament_tournament.getpausetime())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6AD7FA008EC84E86B58EAA5452FEACB8"><em>*</em> #request.content.tournament_tournament_rowtype_label_matchtime#</label>
		<input type="text" class="textInput" name="matchtime" id="formrow_6AD7FA008EC84E86B58EAA5452FEACB8" value="#Trim(otournament_tournament.getmatchtime())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_89C216A96D38472685E97DA934676982"><em>*</em> #request.content.tournament_tournament_rowtype_label_matchcount#</label>
		<input type="text" class="textInput" name="matchcount" id="formrow_89C216A96D38472685E97DA934676982" value="#Trim(otournament_tournament.getmatchcount())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>export</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_16831AC9F0A14E77BB8331E5168D1684">#request.content.tournament_tournament_rowtype_label_export_league#</label>
		<input type="text" class="textInput" name="export_league" id="formrow_16831AC9F0A14E77BB8331E5168D1684" value="#Trim(otournament_tournament.getexport_league())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2791A0CCACA149BBA58A5C561FF9750D">#request.content.tournament_tournament_rowtype_label_export_league_data#</label>
		<input type="text" class="textInput" name="export_league_data" id="formrow_2791A0CCACA149BBA58A5C561FF9750D" value="#Trim(otournament_tournament.getexport_league_data())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
