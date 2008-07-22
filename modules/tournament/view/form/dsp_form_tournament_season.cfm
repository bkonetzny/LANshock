<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_season">
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
<h3>#request.content.__globalmodule__navigation__tournament_season_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_season_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_season_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_92501A75209E4AC8A06A4D9FA4F86EA3" value="#otournament_season.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_92501A75209E4AC8A06A4D9FA4F86EA3">#request.content.tournament_season_rowtype_label_id#</label>
		#Trim(otournament_season.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_D9DEB7CC73B3436B97740BCB2D6897D1"><em>*</em> #request.content.tournament_season_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_D9DEB7CC73B3436B97740BCB2D6897D1" value="#Trim(otournament_season.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F5A6A320FB0B4316B7B5EE4F582CFD38"><em>*</em> #request.content.tournament_season_rowtype_label_description#</label>
		<textarea name="description" id="formrow_F5A6A320FB0B4316B7B5EE4F582CFD38">#Trim(otournament_season.getdescription())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_F5A6A320FB0B4316B7B5EE4F582CFD38 = new FCKeditor('description');
				oFCKeditor_formrow_F5A6A320FB0B4316B7B5EE4F582CFD38.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_F5A6A320FB0B4316B7B5EE4F582CFD38.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_F5A6A320FB0B4316B7B5EE4F582CFD38.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_F5A6A320FB0B4316B7B5EE4F582CFD38.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F09B48EE2B1444CC9536E3484E4B8D0C">#request.content.tournament_season_rowtype_label_player_coins#</label>
		<input type="text" class="textInput" name="player_coins" id="formrow_F09B48EE2B1444CC9536E3484E4B8D0C" value="#Trim(otournament_season.getplayer_coins())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_season.getdt_start()))>
		<cfset otournament_season.setdt_start(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_E415FC75AF9242CFBE540B7453826738">#request.content.tournament_season_rowtype_label_dt_start#</label>
		<div class="divInput" id="divDatePickerE415FC75AF9242CFBE540B7453826738"></div>
		<input type="hidden" name="dt_start" id="formrow_E415FC75AF9242CFBE540B7453826738" value="#LsDateFormat(Trim(otournament_season.getdt_start()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_start()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerE415FC75AF9242CFBE540B7453826738 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_E415FC75AF9242CFBE540B7453826738').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerE415FC75AF9242CFBE540B7453826738.render('divDatePickerE415FC75AF9242CFBE540B7453826738');
				var dtE415FC75AF9242CFBE540B7453826738 = new Date();
				dtE415FC75AF9242CFBE540B7453826738 = Date.parseDate("#LsDateFormat(Trim(otournament_season.getdt_start()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_start()),'HH:MM')#","Y-m-d G:i");
				myDatePickerE415FC75AF9242CFBE540B7453826738.setValue(dtE415FC75AF9242CFBE540B7453826738);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_season.getdt_end()))>
		<cfset otournament_season.setdt_end(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_006C31B385374EC59ED00D796927972D">#request.content.tournament_season_rowtype_label_dt_end#</label>
		<div class="divInput" id="divDatePicker006C31B385374EC59ED00D796927972D"></div>
		<input type="hidden" name="dt_end" id="formrow_006C31B385374EC59ED00D796927972D" value="#LsDateFormat(Trim(otournament_season.getdt_end()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_end()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker006C31B385374EC59ED00D796927972D = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_006C31B385374EC59ED00D796927972D').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker006C31B385374EC59ED00D796927972D.render('divDatePicker006C31B385374EC59ED00D796927972D');
				var dt006C31B385374EC59ED00D796927972D = new Date();
				dt006C31B385374EC59ED00D796927972D = Date.parseDate("#LsDateFormat(Trim(otournament_season.getdt_end()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_end()),'HH:MM')#","Y-m-d G:i");
				myDatePicker006C31B385374EC59ED00D796927972D.setValue(dt006C31B385374EC59ED00D796927972D);
			});
			//-->
		</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sRelevent_events = otournament_season.getevent_events().getid()>
	<div class="ctrlHolder">
		<label for="formrow_C3CC5ABCAD0540A38E0E437825D3D152">event_events</label>
		<select class="selectInput" name="event_id" id="formrow_C3CC5ABCAD0540A38E0E437825D3D152">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.event_events.qData">
				<option value="#stRelated.stManyToOne.event_events.qData.optionvalue#"<cfif sRelevent_events EQ stRelated.stManyToOne.event_events.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.event_events.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
