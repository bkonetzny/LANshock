<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_type_se_ranking">
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
<h3>#request.content.__globalmodule__navigation__tournament_type_se_ranking_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_type_se_ranking_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_type_se_ranking_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_FD73C1DF526B45DA8B3E2669C9B325D1" value="#otournament_type_se_ranking.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_FD73C1DF526B45DA8B3E2669C9B325D1">#request.content.tournament_type_se_ranking_rowtype_label_id#</label>
		#Trim(otournament_type_se_ranking.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_73438E8A1FE044D38D7030F7A8EDA63A"><em>*</em> #request.content.tournament_type_se_ranking_rowtype_label_tournamentid#</label>
		<input type="text" class="textInput" name="tournamentid" id="formrow_73438E8A1FE044D38D7030F7A8EDA63A" value="#Trim(otournament_type_se_ranking.gettournamentid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_271A1B8C0B1E4E0B81A65B832A25F2A2"><em>*</em> #request.content.tournament_type_se_ranking_rowtype_label_teamid#</label>
		<input type="text" class="textInput" name="teamid" id="formrow_271A1B8C0B1E4E0B81A65B832A25F2A2" value="#Trim(otournament_type_se_ranking.getteamid())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_928837AB09B847C4B2D698DB6529C04B"><em>*</em> #request.content.tournament_type_se_ranking_rowtype_label_pos#</label>
		<input type="text" class="textInput" name="pos" id="formrow_928837AB09B847C4B2D698DB6529C04B" value="#Trim(otournament_type_se_ranking.getpos())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
