<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_result">
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
<h3>#request.content.__globalmodule__navigation__tournament_result_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_result_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_result_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_6FE6B63763FC457788DCD71CAA28134E" value="#otournament_result.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_6FE6B63763FC457788DCD71CAA28134E">#request.content.tournament_result_rowtype_label_id#</label>
		#Trim(otournament_result.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_B12A6EA049F84DCAB3B0C98DC80772EA"><em>*</em> #request.content.tournament_result_rowtype_label_team1_result#</label>
		<input type="text" class="textInput" name="team1_result" id="formrow_B12A6EA049F84DCAB3B0C98DC80772EA" value="#Trim(otournament_result.getteam1_result())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E486D79E16B24461AE36BECA5C4C30B5"><em>*</em> #request.content.tournament_result_rowtype_label_team2_result#</label>
		<input type="text" class="textInput" name="team2_result" id="formrow_E486D79E16B24461AE36BECA5C4C30B5" value="#Trim(otournament_result.getteam2_result())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_type_se_match = otournament_result.gettournament_type_se_match().getid()>
	<div class="ctrlHolder">
		<label for="formrow_C47F300ED0BA4F2B9D57098103021756">tournament_type_se_match</label>
		<select class="selectInput" name="matchid" id="formrow_C47F300ED0BA4F2B9D57098103021756">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_type_se_match.qData">
				<option value="#stRelated.stManyToOne.tournament_type_se_match.qData.optionvalue#"<cfif sReltournament_type_se_match EQ stRelated.stManyToOne.tournament_type_se_match.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_type_se_match.qData.optionname#</option>
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
