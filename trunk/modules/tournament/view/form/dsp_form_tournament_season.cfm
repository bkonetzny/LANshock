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
	<input type="hidden" name="id" id="formrow_9C572CDE576942AC842695AE37601B38" value="#otournament_season.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_9C572CDE576942AC842695AE37601B38">#request.content.tournament_season_rowtype_label_id#</label>
		#Trim(otournament_season.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F235AB31D1AC44568DDC6191D4EF8818"><em>*</em> #request.content.tournament_season_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_F235AB31D1AC44568DDC6191D4EF8818" value="#Trim(otournament_season.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_7C922B57B1C144FE964CC75F0C8A1884"><em>*</em> #request.content.tournament_season_rowtype_label_description#</label>
		<textarea name="description" id="formrow_7C922B57B1C144FE964CC75F0C8A1884">#Trim(otournament_season.getdescription())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_7C922B57B1C144FE964CC75F0C8A1884 = new FCKeditor('description');
				oFCKeditor_formrow_7C922B57B1C144FE964CC75F0C8A1884.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_7C922B57B1C144FE964CC75F0C8A1884.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_7C922B57B1C144FE964CC75F0C8A1884.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_7C922B57B1C144FE964CC75F0C8A1884.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A8CA2524AA964CCDBC25C34CF15390EE">#request.content.tournament_season_rowtype_label_player_coins#</label>
		<input type="text" class="textInput" name="player_coins" id="formrow_A8CA2524AA964CCDBC25C34CF15390EE" value="#Trim(otournament_season.getplayer_coins())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_season.getdt_start()))>
		<cfset otournament_season.setdt_start(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_446189486A2A4EB4BB65E88A0474E3D5">#request.content.tournament_season_rowtype_label_dt_start#</label>
		<div class="divInput" id="divDatePicker446189486A2A4EB4BB65E88A0474E3D5"></div>
		<input type="hidden" name="dt_start" id="formrow_446189486A2A4EB4BB65E88A0474E3D5" value="#LsDateFormat(Trim(otournament_season.getdt_start()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_start()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker446189486A2A4EB4BB65E88A0474E3D5 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_446189486A2A4EB4BB65E88A0474E3D5').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker446189486A2A4EB4BB65E88A0474E3D5.render('divDatePicker446189486A2A4EB4BB65E88A0474E3D5');
				var dt446189486A2A4EB4BB65E88A0474E3D5 = new Date();
				dt446189486A2A4EB4BB65E88A0474E3D5 = Date.parseDate("#LsDateFormat(Trim(otournament_season.getdt_start()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_start()),'HH:MM')#","Y-m-d G:i");
				myDatePicker446189486A2A4EB4BB65E88A0474E3D5.setValue(dt446189486A2A4EB4BB65E88A0474E3D5);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_season.getdt_end()))>
		<cfset otournament_season.setdt_end(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_80A66AE41B904BC0A56B63A843844C6E">#request.content.tournament_season_rowtype_label_dt_end#</label>
		<div class="divInput" id="divDatePicker80A66AE41B904BC0A56B63A843844C6E"></div>
		<input type="hidden" name="dt_end" id="formrow_80A66AE41B904BC0A56B63A843844C6E" value="#LsDateFormat(Trim(otournament_season.getdt_end()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_end()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker80A66AE41B904BC0A56B63A843844C6E = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_80A66AE41B904BC0A56B63A843844C6E').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker80A66AE41B904BC0A56B63A843844C6E.render('divDatePicker80A66AE41B904BC0A56B63A843844C6E');
				var dt80A66AE41B904BC0A56B63A843844C6E = new Date();
				dt80A66AE41B904BC0A56B63A843844C6E = Date.parseDate("#LsDateFormat(Trim(otournament_season.getdt_end()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_season.getdt_end()),'HH:MM')#","Y-m-d G:i");
				myDatePicker80A66AE41B904BC0A56B63A843844C6E.setValue(dt80A66AE41B904BC0A56B63A843844C6E);
			});
			//-->
		</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sRelevent_events = otournament_season.getevent_events().getid()>
	<div class="ctrlHolder">
		<label for="formrow_12D1E6EEDC714996987E9A76DD8E2695">event_events</label>
		<select class="selectInput" name="event_id" id="formrow_12D1E6EEDC714996987E9A76DD8E2695">
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
