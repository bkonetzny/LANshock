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
	<input type="hidden" name="id" id="formrow_62DD6D43BD1543AD9EADA51DB94477E7" value="#otournament_match.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_62DD6D43BD1543AD9EADA51DB94477E7">#request.content.tournament_match_rowtype_label_id#</label>
		#Trim(otournament_match.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_41D3E4654EDB4B1C90D7985A887C1686">#request.content.tournament_match_rowtype_label_status#</label>
		<input type="text" class="textInput" name="status" id="formrow_41D3E4654EDB4B1C90D7985A887C1686" value="#Trim(otournament_match.getstatus())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_4801F5A377A44FA886A684C9F7612F5A">#request.content.tournament_match_rowtype_label_row#</label>
		<input type="text" class="textInput" name="row" id="formrow_4801F5A377A44FA886A684C9F7612F5A" value="#Trim(otournament_match.getrow())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_FB0CB4ADB307451B8E05653FAB342D40">#request.content.tournament_match_rowtype_label_col#</label>
		<input type="text" class="textInput" name="col" id="formrow_FB0CB4ADB307451B8E05653FAB342D40" value="#Trim(otournament_match.getcol())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_8363CA7D100141D885629542AFD8A361">#request.content.tournament_match_rowtype_label_team1#</label>
		<input type="text" class="textInput" name="team1" id="formrow_8363CA7D100141D885629542AFD8A361" value="#Trim(otournament_match.getteam1())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_80FBE2D9459B44AAB6654906F85AFF82">#request.content.tournament_match_rowtype_label_team2#</label>
		<input type="text" class="textInput" name="team2" id="formrow_80FBE2D9459B44AAB6654906F85AFF82" value="#Trim(otournament_match.getteam2())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_3ABD633F53B84EB1866CCA8603C2B779">#request.content.tournament_match_rowtype_label_winner#</label>
		<input type="text" class="textInput" name="winner" id="formrow_3ABD633F53B84EB1866CCA8603C2B779" value="#Trim(otournament_match.getwinner())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_668C2ED3C5E849CE85884EBF73E87718">#request.content.tournament_match_rowtype_label_submittedby_userid#</label>
		<input type="text" class="textInput" name="submittedby_userid" id="formrow_668C2ED3C5E849CE85884EBF73E87718" value="#Trim(otournament_match.getsubmittedby_userid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0BC90BBE5DD04BE481F4CB7D9C16CBFA">#request.content.tournament_match_rowtype_label_submittedby_teamid#</label>
		<input type="text" class="textInput" name="submittedby_teamid" id="formrow_0BC90BBE5DD04BE481F4CB7D9C16CBFA" value="#Trim(otournament_match.getsubmittedby_teamid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_match.getsubmittedby_dt()))>
		<cfset otournament_match.setsubmittedby_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_03385D0FBBF24E8C8AE09935EF3E3715">#request.content.tournament_match_rowtype_label_submittedby_dt#</label>
		<div class="divInput" id="divDatePicker03385D0FBBF24E8C8AE09935EF3E3715"></div>
		<input type="hidden" name="submittedby_dt" id="formrow_03385D0FBBF24E8C8AE09935EF3E3715" value="#LsDateFormat(Trim(otournament_match.getsubmittedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getsubmittedby_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker03385D0FBBF24E8C8AE09935EF3E3715 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_03385D0FBBF24E8C8AE09935EF3E3715').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker03385D0FBBF24E8C8AE09935EF3E3715.render('divDatePicker03385D0FBBF24E8C8AE09935EF3E3715');
				var dt03385D0FBBF24E8C8AE09935EF3E3715 = new Date();
				dt03385D0FBBF24E8C8AE09935EF3E3715 = Date.parseDate("#LsDateFormat(Trim(otournament_match.getsubmittedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getsubmittedby_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePicker03385D0FBBF24E8C8AE09935EF3E3715.setValue(dt03385D0FBBF24E8C8AE09935EF3E3715);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_BA7C04224DCC4EB4AC6DCBACA1F745BC">#request.content.tournament_match_rowtype_label_checkedby_userid#</label>
		<input type="text" class="textInput" name="checkedby_userid" id="formrow_BA7C04224DCC4EB4AC6DCBACA1F745BC" value="#Trim(otournament_match.getcheckedby_userid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_4AEE165F69EE4346A336D59CC9C1F033">#request.content.tournament_match_rowtype_label_checkedby_teamid#</label>
		<input type="text" class="textInput" name="checkedby_teamid" id="formrow_4AEE165F69EE4346A336D59CC9C1F033" value="#Trim(otournament_match.getcheckedby_teamid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_match.getcheckedby_dt()))>
		<cfset otournament_match.setcheckedby_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_23E2870FB31945C1A8A4197B92D12D28">#request.content.tournament_match_rowtype_label_checkedby_dt#</label>
		<div class="divInput" id="divDatePicker23E2870FB31945C1A8A4197B92D12D28"></div>
		<input type="hidden" name="checkedby_dt" id="formrow_23E2870FB31945C1A8A4197B92D12D28" value="#LsDateFormat(Trim(otournament_match.getcheckedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker23E2870FB31945C1A8A4197B92D12D28 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_23E2870FB31945C1A8A4197B92D12D28').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker23E2870FB31945C1A8A4197B92D12D28.render('divDatePicker23E2870FB31945C1A8A4197B92D12D28');
				var dt23E2870FB31945C1A8A4197B92D12D28 = new Date();
				dt23E2870FB31945C1A8A4197B92D12D28 = Date.parseDate("#LsDateFormat(Trim(otournament_match.getcheckedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePicker23E2870FB31945C1A8A4197B92D12D28.setValue(dt23E2870FB31945C1A8A4197B92D12D28);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C3C6DF81A80B4363B09196B296D2D6E1">#request.content.tournament_match_rowtype_label_checkedby_admin#</label>
		<input type="text" class="textInput" name="checkedby_admin" id="formrow_C3C6DF81A80B4363B09196B296D2D6E1" value="#Trim(otournament_match.getcheckedby_admin())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_match.getcheckedby_admin_dt()))>
		<cfset otournament_match.setcheckedby_admin_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_6110979AEA6941EDAF237EDD90068698">#request.content.tournament_match_rowtype_label_checkedby_admin_dt#</label>
		<div class="divInput" id="divDatePicker6110979AEA6941EDAF237EDD90068698"></div>
		<input type="hidden" name="checkedby_admin_dt" id="formrow_6110979AEA6941EDAF237EDD90068698" value="#LsDateFormat(Trim(otournament_match.getcheckedby_admin_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_admin_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker6110979AEA6941EDAF237EDD90068698 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_6110979AEA6941EDAF237EDD90068698').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker6110979AEA6941EDAF237EDD90068698.render('divDatePicker6110979AEA6941EDAF237EDD90068698');
				var dt6110979AEA6941EDAF237EDD90068698 = new Date();
				dt6110979AEA6941EDAF237EDD90068698 = Date.parseDate("#LsDateFormat(Trim(otournament_match.getcheckedby_admin_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_match.getcheckedby_admin_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePicker6110979AEA6941EDAF237EDD90068698.setValue(dt6110979AEA6941EDAF237EDD90068698);
			});
			//-->
		</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_tournament = otournament_match.gettournament_tournament().getid()>
	<div class="ctrlHolder">
		<label for="formrow_E4EF1AA0F0E041D8960ACC5BA0902049">tournament_tournament</label>
		<select class="selectInput" name="tournamentid" id="formrow_E4EF1AA0F0E041D8960ACC5BA0902049">
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
