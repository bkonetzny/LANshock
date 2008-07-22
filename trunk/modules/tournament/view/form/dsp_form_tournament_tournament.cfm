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
	<input type="hidden" name="id" id="formrow_E42C82A04CE041769FD045A6F0FEE44F" value="#otournament_tournament.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_E42C82A04CE041769FD045A6F0FEE44F">#request.content.tournament_tournament_rowtype_label_id#</label>
		#Trim(otournament_tournament.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_B822B4B9217546918F89ED60769433F8"><em>*</em> #request.content.tournament_tournament_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_B822B4B9217546918F89ED60769433F8" value="#Trim(otournament_tournament.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A8DCC63F38DF4C1D88E8A8AD491F61CF"><em>*</em> #request.content.tournament_tournament_rowtype_label_type#</label>
		<cfif isDefined("stRelated.type_custom.qData")>
		<select class="selectInput" name="type" id="formrow_A8DCC63F38DF4C1D88E8A8AD491F61CF">
			<cfloop query="stRelated.type_custom.qData">
				<option value="#stRelated.type_custom.qData.optionvalue#"<cfif otournament_tournament.gettype() EQ stRelated.type_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.type_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A71DF92FF8BE414FBCCA71C1004DA957"><em>*</em> #request.content.tournament_tournament_rowtype_label_status#</label>
		<cfif isDefined("stRelated.status_custom.qData")>
		<select class="selectInput" name="status" id="formrow_A71DF92FF8BE414FBCCA71C1004DA957">
			<cfloop query="stRelated.status_custom.qData">
				<option value="#stRelated.status_custom.qData.optionvalue#"<cfif otournament_tournament.getstatus() EQ stRelated.status_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.status_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_FC35B3C49F9146228C8A7C05DB9C5186"><em>*</em> #request.content.tournament_tournament_rowtype_label_rulefile#</label>
		<cfif isDefined("stRelated.rulefile_custom.qData")>
		<select class="selectInput" name="rulefile" id="formrow_FC35B3C49F9146228C8A7C05DB9C5186">
			<cfloop query="stRelated.rulefile_custom.qData">
				<option value="#stRelated.rulefile_custom.qData.optionvalue#"<cfif otournament_tournament.getrulefile() EQ stRelated.rulefile_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.rulefile_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_DA0A71B38FC44F4B98B7F7DB7751B6AF"><em>*</em> #request.content.tournament_tournament_rowtype_label_image#</label>
		<cfif isDefined("stRelated.image_custom.qData")>
		<select class="selectInput" name="image" id="formrow_DA0A71B38FC44F4B98B7F7DB7751B6AF">
			<cfloop query="stRelated.image_custom.qData">
				<option value="#stRelated.image_custom.qData.optionvalue#"<cfif otournament_tournament.getimage() EQ stRelated.image_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.image_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A0418B3AE9CE4F3CBB10CCF25681A04C"><em>*</em> #request.content.tournament_tournament_rowtype_label_coins#</label>
		<input type="text" class="textInput" name="coins" id="formrow_A0418B3AE9CE4F3CBB10CCF25681A04C" value="#Trim(otournament_tournament.getcoins())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_tournament.getstarttime()))>
		<cfset otournament_tournament.setstarttime(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_3A5E9D30181B4EFEAD57C6C7F061C6B2">#request.content.tournament_tournament_rowtype_label_starttime#</label>
		<div class="divInput" id="divDatePicker3A5E9D30181B4EFEAD57C6C7F061C6B2"></div>
		<input type="hidden" name="starttime" id="formrow_3A5E9D30181B4EFEAD57C6C7F061C6B2" value="#LsDateFormat(Trim(otournament_tournament.getstarttime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getstarttime()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker3A5E9D30181B4EFEAD57C6C7F061C6B2 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_3A5E9D30181B4EFEAD57C6C7F061C6B2').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker3A5E9D30181B4EFEAD57C6C7F061C6B2.render('divDatePicker3A5E9D30181B4EFEAD57C6C7F061C6B2');
				var dt3A5E9D30181B4EFEAD57C6C7F061C6B2 = new Date();
				dt3A5E9D30181B4EFEAD57C6C7F061C6B2 = Date.parseDate("#LsDateFormat(Trim(otournament_tournament.getstarttime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getstarttime()),'HH:MM')#","Y-m-d G:i");
				myDatePicker3A5E9D30181B4EFEAD57C6C7F061C6B2.setValue(dt3A5E9D30181B4EFEAD57C6C7F061C6B2);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_tournament.getendtime()))>
		<cfset otournament_tournament.setendtime(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_2B512523BD2749DF8A4A734A1D69A0B0">#request.content.tournament_tournament_rowtype_label_endtime#</label>
		<div class="divInput" id="divDatePicker2B512523BD2749DF8A4A734A1D69A0B0"></div>
		<input type="hidden" name="endtime" id="formrow_2B512523BD2749DF8A4A734A1D69A0B0" value="#LsDateFormat(Trim(otournament_tournament.getendtime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getendtime()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker2B512523BD2749DF8A4A734A1D69A0B0 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_2B512523BD2749DF8A4A734A1D69A0B0').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker2B512523BD2749DF8A4A734A1D69A0B0.render('divDatePicker2B512523BD2749DF8A4A734A1D69A0B0');
				var dt2B512523BD2749DF8A4A734A1D69A0B0 = new Date();
				dt2B512523BD2749DF8A4A734A1D69A0B0 = Date.parseDate("#LsDateFormat(Trim(otournament_tournament.getendtime()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_tournament.getendtime()),'HH:MM')#","Y-m-d G:i");
				myDatePicker2B512523BD2749DF8A4A734A1D69A0B0.setValue(dt2B512523BD2749DF8A4A734A1D69A0B0);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C8CAC39F29264E719423788022BC7BA9"><em>*</em> #request.content.tournament_tournament_rowtype_label_timetable_color#</label>
		<cfif isDefined("stRelated.timetable_color_custom.qData")>
		<select class="selectInput" name="timetable_color" id="formrow_C8CAC39F29264E719423788022BC7BA9">
			<cfloop query="stRelated.timetable_color_custom.qData">
				<option value="#stRelated.timetable_color_custom.qData.optionvalue#"<cfif otournament_tournament.gettimetable_color() EQ stRelated.timetable_color_custom.qData.optionvalue> selected="selected"</cfif>>#stRelated.timetable_color_custom.qData.optionname#</option>
			</cfloop>
		</select>
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_9AB443CF31674E9CB5E24AF5DC1036CE">#request.content.tournament_tournament_rowtype_label_ladminids#</label>
		<input type="text" class="textInput" name="ladminids" id="formrow_9AB443CF31674E9CB5E24AF5DC1036CE" value="#Trim(otournament_tournament.getladminids())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_9A7BA75606A84C499803309413149B1D">#request.content.tournament_tournament_rowtype_label_infotext#</label>
		<textarea name="infotext" id="formrow_9A7BA75606A84C499803309413149B1D">#Trim(otournament_tournament.getinfotext())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_9A7BA75606A84C499803309413149B1D = new FCKeditor('infotext');
				oFCKeditor_formrow_9A7BA75606A84C499803309413149B1D.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_9A7BA75606A84C499803309413149B1D.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_9A7BA75606A84C499803309413149B1D.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_9A7BA75606A84C499803309413149B1D.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_group = otournament_tournament.gettournament_group().getid()>
	<div class="ctrlHolder">
		<label for="formrow_6378747E42F14C5A9F814D18CA5F0961">tournament_group</label>
		<select class="selectInput" name="groupid" id="formrow_6378747E42F14C5A9F814D18CA5F0961">
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
		<label for="formrow_16D4C649BF0645E3BD376F8C35C99131"><em>*</em> #request.content.tournament_tournament_rowtype_label_maxteams#</label>
		<input type="text" class="textInput" name="maxteams" id="formrow_16D4C649BF0645E3BD376F8C35C99131" value="#Trim(otournament_tournament.getmaxteams())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_46DC4A6A653F4070AD9F8BB5F24ED3A5"><em>*</em> #request.content.tournament_tournament_rowtype_label_teamsize#</label>
		<input type="text" class="textInput" name="teamsize" id="formrow_46DC4A6A653F4070AD9F8BB5F24ED3A5" value="#Trim(otournament_tournament.getteamsize())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2CF9C55A8AD14D7698754E265896B149"><em>*</em> #request.content.tournament_tournament_rowtype_label_teamsubstitute#</label>
		<input type="text" class="textInput" name="teamsubstitute" id="formrow_2CF9C55A8AD14D7698754E265896B149" value="#Trim(otournament_tournament.getteamsubstitute())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>match</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_77F20F93AA4146879D5933D4445A4D7A"><em>*</em> #request.content.tournament_tournament_rowtype_label_pausetime#</label>
		<input type="text" class="textInput" name="pausetime" id="formrow_77F20F93AA4146879D5933D4445A4D7A" value="#Trim(otournament_tournament.getpausetime())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_45EC204E6B4140B4931A46B321D62A37"><em>*</em> #request.content.tournament_tournament_rowtype_label_matchtime#</label>
		<input type="text" class="textInput" name="matchtime" id="formrow_45EC204E6B4140B4931A46B321D62A37" value="#Trim(otournament_tournament.getmatchtime())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6E9AACA69C174DA698C098216E9D8E26"><em>*</em> #request.content.tournament_tournament_rowtype_label_matchcount#</label>
		<input type="text" class="textInput" name="matchcount" id="formrow_6E9AACA69C174DA698C098216E9D8E26" value="#Trim(otournament_tournament.getmatchcount())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>export</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_29C7CEA8820F4C909755C72A480FCB78">#request.content.tournament_tournament_rowtype_label_export_league#</label>
		<input type="text" class="textInput" name="export_league" id="formrow_29C7CEA8820F4C909755C72A480FCB78" value="#Trim(otournament_tournament.getexport_league())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_ADFCAFD840E44ECEBE44AA0C08B5004B">#request.content.tournament_tournament_rowtype_label_export_league_data#</label>
		<input type="text" class="textInput" name="export_league_data" id="formrow_ADFCAFD840E44ECEBE44AA0C08B5004B" value="#Trim(otournament_tournament.getexport_league_data())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
