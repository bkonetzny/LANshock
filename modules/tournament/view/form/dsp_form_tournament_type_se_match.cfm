<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_type_se_match">
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
<h3>#request.content.__globalmodule__navigation__tournament_type_se_match_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_type_se_match_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_type_se_match_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_1464081E8F9F4CC4A65A2C907DB39223" value="#otournament_type_se_match.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_1464081E8F9F4CC4A65A2C907DB39223">#request.content.tournament_type_se_match_rowtype_label_id#</label>
		#Trim(otournament_type_se_match.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_74BB2A08CDCE4DE1A1CA3C3FCAADCCFC">#request.content.tournament_type_se_match_rowtype_label_tournamentid#</label>
		<input type="text" class="textInput" name="tournamentid" id="formrow_74BB2A08CDCE4DE1A1CA3C3FCAADCCFC" value="#Trim(otournament_type_se_match.gettournamentid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C9C37EADD2A642FB9F60189BA20643CA">#request.content.tournament_type_se_match_rowtype_label_status#</label>
		<input type="text" class="textInput" name="status" id="formrow_C9C37EADD2A642FB9F60189BA20643CA" value="#Trim(otournament_type_se_match.getstatus())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_54FB31AEF2F7408EA7F3218B240DCE3A">#request.content.tournament_type_se_match_rowtype_label_row#</label>
		<input type="text" class="textInput" name="row" id="formrow_54FB31AEF2F7408EA7F3218B240DCE3A" value="#Trim(otournament_type_se_match.getrow())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0B14A2FB0247450D84ACEACC6402FA1E">#request.content.tournament_type_se_match_rowtype_label_col#</label>
		<input type="text" class="textInput" name="col" id="formrow_0B14A2FB0247450D84ACEACC6402FA1E" value="#Trim(otournament_type_se_match.getcol())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_46E845FB32004C2A98B56F2F0534C13D">#request.content.tournament_type_se_match_rowtype_label_team1#</label>
		<input type="text" class="textInput" name="team1" id="formrow_46E845FB32004C2A98B56F2F0534C13D" value="#Trim(otournament_type_se_match.getteam1())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0B3231F8AB684378BFEC7114AF060007">#request.content.tournament_type_se_match_rowtype_label_team2#</label>
		<input type="text" class="textInput" name="team2" id="formrow_0B3231F8AB684378BFEC7114AF060007" value="#Trim(otournament_type_se_match.getteam2())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_298ACA09D5DF4106846649897B7AA9F5">#request.content.tournament_type_se_match_rowtype_label_winner#</label>
		<input type="text" class="textInput" name="winner" id="formrow_298ACA09D5DF4106846649897B7AA9F5" value="#Trim(otournament_type_se_match.getwinner())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_DE4E42AF5622493C94AFD1283B180AA7">#request.content.tournament_type_se_match_rowtype_label_submittedby_userid#</label>
		<input type="text" class="textInput" name="submittedby_userid" id="formrow_DE4E42AF5622493C94AFD1283B180AA7" value="#Trim(otournament_type_se_match.getsubmittedby_userid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F0FBFE46A09A47759C4EDD67C8A989F1">#request.content.tournament_type_se_match_rowtype_label_submittedby_teamid#</label>
		<input type="text" class="textInput" name="submittedby_teamid" id="formrow_F0FBFE46A09A47759C4EDD67C8A989F1" value="#Trim(otournament_type_se_match.getsubmittedby_teamid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_type_se_match.getsubmittedby_dt()))>
		<cfset otournament_type_se_match.setsubmittedby_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_65334E384C8A40FA88B2B47F9D88E698">#request.content.tournament_type_se_match_rowtype_label_submittedby_dt#</label>
		<div class="divInput" id="divDatePicker65334E384C8A40FA88B2B47F9D88E698"></div>
		<input type="hidden" name="submittedby_dt" id="formrow_65334E384C8A40FA88B2B47F9D88E698" value="#LsDateFormat(Trim(otournament_type_se_match.getsubmittedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_type_se_match.getsubmittedby_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker65334E384C8A40FA88B2B47F9D88E698 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_65334E384C8A40FA88B2B47F9D88E698').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker65334E384C8A40FA88B2B47F9D88E698.render('divDatePicker65334E384C8A40FA88B2B47F9D88E698');
				var dt65334E384C8A40FA88B2B47F9D88E698 = new Date();
				dt65334E384C8A40FA88B2B47F9D88E698 = Date.parseDate("#LsDateFormat(Trim(otournament_type_se_match.getsubmittedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_type_se_match.getsubmittedby_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePicker65334E384C8A40FA88B2B47F9D88E698.setValue(dt65334E384C8A40FA88B2B47F9D88E698);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_42FD6749B3AC40E1B083565E7969DBE0">#request.content.tournament_type_se_match_rowtype_label_checkedby_userid#</label>
		<input type="text" class="textInput" name="checkedby_userid" id="formrow_42FD6749B3AC40E1B083565E7969DBE0" value="#Trim(otournament_type_se_match.getcheckedby_userid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_24666242BE88406DA01B5BE55D9826BF">#request.content.tournament_type_se_match_rowtype_label_checkedby_teamid#</label>
		<input type="text" class="textInput" name="checkedby_teamid" id="formrow_24666242BE88406DA01B5BE55D9826BF" value="#Trim(otournament_type_se_match.getcheckedby_teamid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_type_se_match.getcheckedby_dt()))>
		<cfset otournament_type_se_match.setcheckedby_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_FB85E9E25AD347C78F15B31B8F74F27B">#request.content.tournament_type_se_match_rowtype_label_checkedby_dt#</label>
		<div class="divInput" id="divDatePickerFB85E9E25AD347C78F15B31B8F74F27B"></div>
		<input type="hidden" name="checkedby_dt" id="formrow_FB85E9E25AD347C78F15B31B8F74F27B" value="#LsDateFormat(Trim(otournament_type_se_match.getcheckedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_type_se_match.getcheckedby_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerFB85E9E25AD347C78F15B31B8F74F27B = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_FB85E9E25AD347C78F15B31B8F74F27B').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerFB85E9E25AD347C78F15B31B8F74F27B.render('divDatePickerFB85E9E25AD347C78F15B31B8F74F27B');
				var dtFB85E9E25AD347C78F15B31B8F74F27B = new Date();
				dtFB85E9E25AD347C78F15B31B8F74F27B = Date.parseDate("#LsDateFormat(Trim(otournament_type_se_match.getcheckedby_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_type_se_match.getcheckedby_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePickerFB85E9E25AD347C78F15B31B8F74F27B.setValue(dtFB85E9E25AD347C78F15B31B8F74F27B);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_7749A1B386E4432D88D4C4CD52225F22">#request.content.tournament_type_se_match_rowtype_label_checkedby_admin#</label>
		<input type="text" class="textInput" name="checkedby_admin" id="formrow_7749A1B386E4432D88D4C4CD52225F22" value="#Trim(otournament_type_se_match.getcheckedby_admin())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(otournament_type_se_match.getcheckedby_admin_dt()))>
		<cfset otournament_type_se_match.setcheckedby_admin_dt(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_6B403247562249428B8666E452CA1302">#request.content.tournament_type_se_match_rowtype_label_checkedby_admin_dt#</label>
		<div class="divInput" id="divDatePicker6B403247562249428B8666E452CA1302"></div>
		<input type="hidden" name="checkedby_admin_dt" id="formrow_6B403247562249428B8666E452CA1302" value="#LsDateFormat(Trim(otournament_type_se_match.getcheckedby_admin_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_type_se_match.getcheckedby_admin_dt()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker6B403247562249428B8666E452CA1302 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_6B403247562249428B8666E452CA1302').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker6B403247562249428B8666E452CA1302.render('divDatePicker6B403247562249428B8666E452CA1302');
				var dt6B403247562249428B8666E452CA1302 = new Date();
				dt6B403247562249428B8666E452CA1302 = Date.parseDate("#LsDateFormat(Trim(otournament_type_se_match.getcheckedby_admin_dt()),'YYYY-MM-DD')# #LsTimeFormat(Trim(otournament_type_se_match.getcheckedby_admin_dt()),'HH:MM')#","Y-m-d G:i");
				myDatePicker6B403247562249428B8666E452CA1302.setValue(dt6B403247562249428B8666E452CA1302);
			});
			//-->
		</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
