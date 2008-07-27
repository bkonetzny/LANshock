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
	<input type="hidden" name="id" id="formrow_05BDDEA2F089446A87601A5FE4C64C07" value="#otournament_season.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_05BDDEA2F089446A87601A5FE4C64C07">#request.content.tournament_season_rowtype_label_id#</label>
		#Trim(otournament_season.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_5111E2E65A9C45DFBE5273834913FE7F"><em>*</em> #request.content.tournament_season_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_5111E2E65A9C45DFBE5273834913FE7F" value="#Trim(otournament_season.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_39DAAB03CF284E69A1236B136423EAE5"><em>*</em> #request.content.tournament_season_rowtype_label_description#</label>
		<textarea name="description" id="formrow_39DAAB03CF284E69A1236B136423EAE5">#Trim(otournament_season.getdescription())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_39DAAB03CF284E69A1236B136423EAE5 = new FCKeditor('description');
				oFCKeditor_formrow_39DAAB03CF284E69A1236B136423EAE5.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_39DAAB03CF284E69A1236B136423EAE5.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_39DAAB03CF284E69A1236B136423EAE5.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_39DAAB03CF284E69A1236B136423EAE5.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_33486052EDCE464688C138A19692DB62">#request.content.tournament_season_rowtype_label_player_coins#</label>
		<input type="text" class="textInput" name="player_coins" id="formrow_33486052EDCE464688C138A19692DB62" value="#Trim(otournament_season.getplayer_coins())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_season.getdt_start()))>
		<cfset otournament_season.setdt_start(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_38A1CAA7B343434A8F9394C8E1A0DA85">#request.content.tournament_season_rowtype_label_dt_start#</label>
		<div class="divInput" id="divDatePicker38A1CAA7B343434A8F9394C8E1A0DA85"></div>
		<input type="hidden" name="dt_start" id="formrow_38A1CAA7B343434A8F9394C8E1A0DA85" value="#LsDateFormat(Trim(otournament_season.getdt_start()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_start()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker38A1CAA7B343434A8F9394C8E1A0DA85 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_38A1CAA7B343434A8F9394C8E1A0DA85').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker38A1CAA7B343434A8F9394C8E1A0DA85.render('divDatePicker38A1CAA7B343434A8F9394C8E1A0DA85');
				var dt38A1CAA7B343434A8F9394C8E1A0DA85 = new Date();
				dt38A1CAA7B343434A8F9394C8E1A0DA85 = Date.parseDate("#LsDateFormat(Trim(otournament_season.getdt_start()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_start()),'HH:MM')#","Y-m-d G:i");
				myDatePicker38A1CAA7B343434A8F9394C8E1A0DA85.setValue(dt38A1CAA7B343434A8F9394C8E1A0DA85);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_season.getdt_end()))>
		<cfset otournament_season.setdt_end(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_6B9ED28FC6EA4A768B8BFE2050FBEF5C">#request.content.tournament_season_rowtype_label_dt_end#</label>
		<div class="divInput" id="divDatePicker6B9ED28FC6EA4A768B8BFE2050FBEF5C"></div>
		<input type="hidden" name="dt_end" id="formrow_6B9ED28FC6EA4A768B8BFE2050FBEF5C" value="#LsDateFormat(Trim(otournament_season.getdt_end()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_end()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker6B9ED28FC6EA4A768B8BFE2050FBEF5C = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_6B9ED28FC6EA4A768B8BFE2050FBEF5C').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker6B9ED28FC6EA4A768B8BFE2050FBEF5C.render('divDatePicker6B9ED28FC6EA4A768B8BFE2050FBEF5C');
				var dt6B9ED28FC6EA4A768B8BFE2050FBEF5C = new Date();
				dt6B9ED28FC6EA4A768B8BFE2050FBEF5C = Date.parseDate("#LsDateFormat(Trim(otournament_season.getdt_end()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_end()),'HH:MM')#","Y-m-d G:i");
				myDatePicker6B9ED28FC6EA4A768B8BFE2050FBEF5C.setValue(dt6B9ED28FC6EA4A768B8BFE2050FBEF5C);
			});
			//-->
		</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sRelevent_events = otournament_season.getevent_events().getid()>
	<div class="ctrlHolder">
		<label for="formrow_4CD47E732805442D86A0AB6D270349C4">event_events</label>
		<select class="selectInput" name="event_id" id="formrow_4CD47E732805442D86A0AB6D270349C4">
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
