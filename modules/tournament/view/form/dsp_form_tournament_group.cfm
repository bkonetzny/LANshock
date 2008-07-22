<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="otournament_group">
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
<h3>#request.content.__globalmodule__navigation__tournament_group_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.tournament_group_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.tournament_group_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_3E1944AC80F24EEAA2A64BC4F363AC85" value="#otournament_group.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_3E1944AC80F24EEAA2A64BC4F363AC85">#request.content.tournament_group_rowtype_label_id#</label>
		#Trim(otournament_group.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_1A39D99494C243228031C744DE0C3B5E"><em>*</em> #request.content.tournament_group_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_1A39D99494C243228031C744DE0C3B5E" value="#Trim(otournament_group.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E76F033BA7DC4D1DA9BC6D8E2439D462"><em>*</em> #request.content.tournament_group_rowtype_label_description#</label>
		<textarea name="description" id="formrow_E76F033BA7DC4D1DA9BC6D8E2439D462">#Trim(otournament_group.getdescription())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_E76F033BA7DC4D1DA9BC6D8E2439D462 = new FCKeditor('description');
				oFCKeditor_formrow_E76F033BA7DC4D1DA9BC6D8E2439D462.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_E76F033BA7DC4D1DA9BC6D8E2439D462.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_E76F033BA7DC4D1DA9BC6D8E2439D462.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_E76F033BA7DC4D1DA9BC6D8E2439D462.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_4B11A8EBE85649C0BC56B7A61FA41B8E">#request.content.tournament_group_rowtype_label_maxsignups#</label>
		<input type="text" class="textInput" name="maxsignups" id="formrow_4B11A8EBE85649C0BC56B7A61FA41B8E" value="#Trim(otournament_group.getmaxsignups())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReltournament_season = otournament_group.gettournament_season().getid()>
	<div class="ctrlHolder">
		<label for="formrow_FCA08F857C54404CB642A753A8CDADFE">tournament_season</label>
		<select class="selectInput" name="season_id" id="formrow_FCA08F857C54404CB642A753A8CDADFE">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.tournament_season.qData">
				<option value="#stRelated.stManyToOne.tournament_season.qData.optionvalue#"<cfif sReltournament_season EQ stRelated.stManyToOne.tournament_season.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.tournament_season.qData.optionname#</option>
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
