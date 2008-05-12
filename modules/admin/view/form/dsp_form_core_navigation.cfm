<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocore_navigation">
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
<h3>#request.content.__globalmodule__navigation__core_navigation_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.core_navigation_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.core_navigation_grid_global_edit#</h4>
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
<form id="frmAddEdit" action="#self#" method="post" class="uniForm" onsubmit="javascript: return validate();">
	<div class="hidden">
		<input type="hidden" name="fuseaction" value="#XFA.save#" />
		<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
		<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
		<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />
	</div>
	
	

	
		
		
		
		
		
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
		
				
		
	
	
	
	
				
	
	
	
	
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aTable</legend>
		
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_277B5AC383F64AED89AC09775F4EAAD3"><em>*</em> #request.content.core_navigation_rowtype_label_module#</label>
		<textarea name="module" id="formrow_277B5AC383F64AED89AC09775F4EAAD3">#Trim(ocore_navigation.getmodule())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0E64C2B2A17749D08AF0282954369BD8"><em>*</em> #request.content.core_navigation_rowtype_label_permissions#</label>
		<textarea name="permissions" id="formrow_0E64C2B2A17749D08AF0282954369BD8">#Trim(ocore_navigation.getpermissions())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_568E508E542F42AD90DF5F1A79637C61"><em>*</em> #request.content.core_navigation_rowtype_label_action#</label>
		<textarea name="action" id="formrow_568E508E542F42AD90DF5F1A79637C61">#Trim(ocore_navigation.getaction())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F20B7BB0573B4924A3C8782CB6437F05"><em>*</em> #request.content.core_navigation_rowtype_label_level#</label>
		<input type="text" class="textInput" name="level" id="formrow_F20B7BB0573B4924A3C8782CB6437F05" value="#NumberFormat(ocore_navigation.getlevel(),"9")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_1D3162A2D4244F81AE6A816CB40E7525"><em>*</em> #request.content.core_navigation_rowtype_label_sortorder#</label>
		<input type="text" class="textInput" name="sortorder" id="formrow_1D3162A2D4244F81AE6A816CB40E7525" value="#NumberFormat(ocore_navigation.getsortorder(),"9")#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
