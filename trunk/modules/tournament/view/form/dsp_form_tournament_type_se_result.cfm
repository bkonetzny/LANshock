<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_type_se_result">
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
<h3>#request.content.__globalmodule__navigation__tournament_type_se_result_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_type_se_result_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_type_se_result_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_8D30EBD70E1A4CDABF84331C788BD7B4" value="#otournament_type_se_result.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_8D30EBD70E1A4CDABF84331C788BD7B4">#request.content.tournament_type_se_result_rowtype_label_id#</label>
		#Trim(otournament_type_se_result.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_DA154772A18347DFAE9B397D06C1C34C"><em>*</em> #request.content.tournament_type_se_result_rowtype_label_matchid#</label>
		<input type="text" class="textInput" name="matchid" id="formrow_DA154772A18347DFAE9B397D06C1C34C" value="#Trim(otournament_type_se_result.getmatchid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_97B70258FF0E45DAB44FDCD60CF4EF4F"><em>*</em> #request.content.tournament_type_se_result_rowtype_label_team1_result#</label>
		<input type="text" class="textInput" name="team1_result" id="formrow_97B70258FF0E45DAB44FDCD60CF4EF4F" value="#Trim(otournament_type_se_result.getteam1_result())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_CD81E0E52EC14234A181A0DB516F534B"><em>*</em> #request.content.tournament_type_se_result_rowtype_label_team2_result#</label>
		<input type="text" class="textInput" name="team2_result" id="formrow_CD81E0E52EC14234A181A0DB516F534B" value="#Trim(otournament_type_se_result.getteam2_result())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
