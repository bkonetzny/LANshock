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
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="module" id="formrow_359C8BF58D6D4CDF8FA8E6DB023C8813" value="#ocore_navigation.getmodule()#" />
	<div class="ctrlHolder">
		<label for="formrow_359C8BF58D6D4CDF8FA8E6DB023C8813">#request.content.core_navigation_rowtype_label_module#</label>
		#Trim(ocore_navigation.getmodule())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="action" id="formrow_232751FC716546249D502DB0CB85F7E7" value="#ocore_navigation.getaction()#" />
	<div class="ctrlHolder">
		<label for="formrow_232751FC716546249D502DB0CB85F7E7">#request.content.core_navigation_rowtype_label_action#</label>
		#Trim(ocore_navigation.getaction())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_924DAEDAABDB48D5B055F47579979AAE"><em>*</em> #request.content.core_navigation_rowtype_label_level#</label>
		<input type="text" class="textInput" name="level" id="formrow_924DAEDAABDB48D5B055F47579979AAE" value="#Trim(ocore_navigation.getlevel())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_AD39842D025D461B91C545B1C9A8ECA7"><em>*</em> #request.content.core_navigation_rowtype_label_sortorder#</label>
		<input type="text" class="textInput" name="sortorder" id="formrow_AD39842D025D461B91C545B1C9A8ECA7" value="#Trim(ocore_navigation.getsortorder())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_3888B5C8E9664C72ADB722D1CBEA50A7"><em>*</em> #request.content.core_navigation_rowtype_label_permissions#</label>
		<input type="text" class="textInput" name="permissions" id="formrow_3888B5C8E9664C72ADB722D1CBEA50A7" value="#Trim(ocore_navigation.getpermissions())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
