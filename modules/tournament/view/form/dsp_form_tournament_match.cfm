<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_match">
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
<h3>#request.content.__globalmodule__navigation__tournament_match_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_match_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_match_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_A64C352464F24B48A6940B9F13010FF7" value="#otournament_match.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_A64C352464F24B48A6940B9F13010FF7">#request.content.tournament_match_rowtype_label_id#</label>
		#Trim(otournament_match.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_D6D437DC58F845899BFEDAC527E80ECB">#request.content.tournament_match_rowtype_label_status#</label>
		<input type="text" class="textInput" name="status" id="formrow_D6D437DC58F845899BFEDAC527E80ECB" value="#Trim(otournament_match.getstatus())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_CAB0C93CA43E456488751853CC60A3B1">#request.content.tournament_match_rowtype_label_row#</label>
		<input type="text" class="textInput" name="row" id="formrow_CAB0C93CA43E456488751853CC60A3B1" value="#Trim(otournament_match.getrow())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2AAEC21A6C4D481EBE8A5A976A5F6D1F">#request.content.tournament_match_rowtype_label_col#</label>
		<input type="text" class="textInput" name="col" id="formrow_2AAEC21A6C4D481EBE8A5A976A5F6D1F" value="#Trim(otournament_match.getcol())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_FF0BA3D5E47D4879991E938E767BD310">#request.content.tournament_match_rowtype_label_team1#</label>
		<input type="text" class="textInput" name="team1" id="formrow_FF0BA3D5E47D4879991E938E767BD310" value="#Trim(otournament_match.getteam1())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_32E8F49B0C1346F6AECABA0AA7EA4ECD">#request.content.tournament_match_rowtype_label_team2#</label>
		<input type="text" class="textInput" name="team2" id="formrow_32E8F49B0C1346F6AECABA0AA7EA4ECD" value="#Trim(otournament_match.getteam2())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_7C859886D1274D258C7A1F23BAB9935D">#request.content.tournament_match_rowtype_label_winner#</label>
		<input type="text" class="textInput" name="winner" id="formrow_7C859886D1274D258C7A1F23BAB9935D" value="#Trim(otournament_match.getwinner())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_862FBBB86F6F467EAD20A6E080B871E8">#request.content.tournament_match_rowtype_label_submittedby_userid#</label>
		<input type="text" class="textInput" name="submittedby_userid" id="formrow_862FBBB86F6F467EAD20A6E080B871E8" value="#Trim(otournament_match.getsubmittedby_userid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C10B620BE8684BEE82D00183B96E76EF">#request.content.tournament_match_rowtype_label_submittedby_teamid#</label>
		<input type="text" class="textInput" name="submittedby_teamid" id="formrow_C10B620BE8684BEE82D00183B96E76EF" value="#Trim(otournament_match.getsubmittedby_teamid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_match.getsubmittedby_dt()))>
		<cfset otournament_match.setsubmittedby_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_A50963EDAF4F45B8AE8D66E064265237">#request.content.tournament_match_rowtype_label_submittedby_dt#</label>
		<div class="divInput" id="divDatePickerA50963EDAF4F45B8AE8D66E064265237"></div>
		<input type="hidden" name="submittedby_dt" id="formrow_A50963EDAF4F45B8AE8D66E064265237" value="#LsDateFormat(Trim(otournament_match.getsubmittedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getsubmittedby_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerA50963EDAF4F45B8AE8D66E064265237 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_A50963EDAF4F45B8AE8D66E064265237').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerA50963EDAF4F45B8AE8D66E064265237.render('divDatePickerA50963EDAF4F45B8AE8D66E064265237');
				var dtA50963EDAF4F45B8AE8D66E064265237 = new Date();
				dtA50963EDAF4F45B8AE8D66E064265237 = Date.parseDate("#LsDateFormat(Trim(otournament_match.getsubmittedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getsubmittedby_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePickerA50963EDAF4F45B8AE8D66E064265237.setValue(dtA50963EDAF4F45B8AE8D66E064265237);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_FF84C6FC1ABC4910B3DE77939CF8B743">#request.content.tournament_match_rowtype_label_checkedby_userid#</label>
		<input type="text" class="textInput" name="checkedby_userid" id="formrow_FF84C6FC1ABC4910B3DE77939CF8B743" value="#Trim(otournament_match.getcheckedby_userid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_DE33CB09300040BF9634ADAEC8725A6C">#request.content.tournament_match_rowtype_label_checkedby_teamid#</label>
		<input type="text" class="textInput" name="checkedby_teamid" id="formrow_DE33CB09300040BF9634ADAEC8725A6C" value="#Trim(otournament_match.getcheckedby_teamid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_match.getcheckedby_dt()))>
		<cfset otournament_match.setcheckedby_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_4C9DABC26A7B4D7D8891C5238FA84C3C">#request.content.tournament_match_rowtype_label_checkedby_dt#</label>
		<div class="divInput" id="divDatePicker4C9DABC26A7B4D7D8891C5238FA84C3C"></div>
		<input type="hidden" name="checkedby_dt" id="formrow_4C9DABC26A7B4D7D8891C5238FA84C3C" value="#LsDateFormat(Trim(otournament_match.getcheckedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker4C9DABC26A7B4D7D8891C5238FA84C3C = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_4C9DABC26A7B4D7D8891C5238FA84C3C').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker4C9DABC26A7B4D7D8891C5238FA84C3C.render('divDatePicker4C9DABC26A7B4D7D8891C5238FA84C3C');
				var dt4C9DABC26A7B4D7D8891C5238FA84C3C = new Date();
				dt4C9DABC26A7B4D7D8891C5238FA84C3C = Date.parseDate("#LsDateFormat(Trim(otournament_match.getcheckedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePicker4C9DABC26A7B4D7D8891C5238FA84C3C.setValue(dt4C9DABC26A7B4D7D8891C5238FA84C3C);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_145D2BB474CA49DE9203DB0684E1112F">#request.content.tournament_match_rowtype_label_checkedby_admin#</label>
		<input type="text" class="textInput" name="checkedby_admin" id="formrow_145D2BB474CA49DE9203DB0684E1112F" value="#Trim(otournament_match.getcheckedby_admin())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_match.getcheckedby_admin_dt()))>
		<cfset otournament_match.setcheckedby_admin_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_87401DF90F9649EE950966A895F2E87D">#request.content.tournament_match_rowtype_label_checkedby_admin_dt#</label>
		<div class="divInput" id="divDatePicker87401DF90F9649EE950966A895F2E87D"></div>
		<input type="hidden" name="checkedby_admin_dt" id="formrow_87401DF90F9649EE950966A895F2E87D" value="#LsDateFormat(Trim(otournament_match.getcheckedby_admin_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_admin_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker87401DF90F9649EE950966A895F2E87D = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_87401DF90F9649EE950966A895F2E87D').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker87401DF90F9649EE950966A895F2E87D.render('divDatePicker87401DF90F9649EE950966A895F2E87D');
				var dt87401DF90F9649EE950966A895F2E87D = new Date();
				dt87401DF90F9649EE950966A895F2E87D = Date.parseDate("#LsDateFormat(Trim(otournament_match.getcheckedby_admin_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_admin_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePicker87401DF90F9649EE950966A895F2E87D.setValue(dt87401DF90F9649EE950966A895F2E87D);
			});
			//-->
		</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_tournament = otournament_match.gettournament_tournament().getid()>
	<div class="ctrlHolder">
		<label for="formrow_26569A20D2DD4F239D9C64A7EF7276D0">tournament_tournament</label>
		<select class="selectInput" name="tournamentid" id="formrow_26569A20D2DD4F239D9C64A7EF7276D0">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_tournament.qData">
				<option value="#stRelated.stManyToOne.tournament_tournament.qData.optionvalue#"<cfif sReltournament_tournament EQ stRelated.stManyToOne.tournament_tournament.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_tournament.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aOneToMany</legend>
		
			
				
				
				
				
					

	
	
		<div class="ctrlHolder">
			OneToMany: attributes.stFieldData.links[1].name is not defined!
		</div>
	
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
