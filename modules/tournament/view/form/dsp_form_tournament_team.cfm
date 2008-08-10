<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_team">
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
<h3>#request.content.__globalmodule__navigation__tournament_team_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_team_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_team_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_804F7A9F149144989C8BA64394DCA9F3" value="#otournament_team.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_804F7A9F149144989C8BA64394DCA9F3">#request.content.tournament_team_rowtype_label_id#</label>
		#Trim(otournament_team.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_861055094C054D87A1C4E46DA40C44F1"><em>*</em> #request.content.tournament_team_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_861055094C054D87A1C4E46DA40C44F1" value="#Trim(otournament_team.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C2BFB21BDA484BA2B46400760007712F">#request.content.tournament_team_rowtype_label_autoacceptids#</label>
		<input type="text" class="textInput" name="autoacceptids" id="formrow_C2BFB21BDA484BA2B46400760007712F" value="#Trim(otournament_team.getautoacceptids())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_BA7178FBC0F640938CFFE9006758D081">#request.content.tournament_team_rowtype_label_leagueid#</label>
		<input type="text" class="textInput" name="leagueid" id="formrow_BA7178FBC0F640938CFFE9006758D081" value="#Trim(otournament_team.getleagueid())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_tournament = otournament_team.gettournament_tournament().getid()>
	<div class="ctrlHolder">
		<label for="formrow_C89E4972669847CF8AD094C73CD33743">tournament_tournament</label>
		<select class="selectInput" name="tournamentid" id="formrow_C89E4972669847CF8AD094C73CD33743">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_tournament.qData">
				<option value="#stRelated.stManyToOne.tournament_tournament.qData.optionvalue#"<cfif sReltournament_tournament EQ stRelated.stManyToOne.tournament_tournament.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_tournament.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sReluser = otournament_team.getuser().getid()>
	<div class="ctrlHolder">
		<label for="formrow_2AABB03570524050952923A99EE01CDC">user</label>
		<select class="selectInput" name="leaderid" id="formrow_2AABB03570524050952923A99EE01CDC">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.user.qData">
				<option value="#stRelated.stManyToOne.user.qData.optionvalue#"<cfif sReluser EQ stRelated.stManyToOne.user.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.user.qData.optionname#</option>
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
