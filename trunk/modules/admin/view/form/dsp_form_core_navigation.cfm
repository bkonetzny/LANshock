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
	<input type="hidden" name="module" id="formrow_8C7745B9F29C4B61BE3A05A9F1C17840" value="#ocore_navigation.getmodule()#" />
	<div class="ctrlHolder">
		<label for="formrow_8C7745B9F29C4B61BE3A05A9F1C17840">#request.content.core_navigation_rowtype_label_module#</label>
		#Trim(ocore_navigation.getmodule())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="action" id="formrow_644A2FA708B14DE4BD5900611147D263" value="#ocore_navigation.getaction()#" />
	<div class="ctrlHolder">
		<label for="formrow_644A2FA708B14DE4BD5900611147D263">#request.content.core_navigation_rowtype_label_action#</label>
		#Trim(ocore_navigation.getaction())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_01F2626464B44CA3B445E62EFCC72251"><em>*</em> #request.content.core_navigation_rowtype_label_permissions#</label>
		<input type="text" class="textInput" name="permissions" id="formrow_01F2626464B44CA3B445E62EFCC72251" value="#Trim(ocore_navigation.getpermissions())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_297E85948384420EB8075CC86D7830F7"><em>*</em> #request.content.core_navigation_rowtype_label_level#</label>
		<input type="text" class="textInput" name="level" id="formrow_297E85948384420EB8075CC86D7830F7" value="#NumberFormat(ocore_navigation.getlevel(),"9")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F697EF9F8ADC4567AC073C31C98E80A2"><em>*</em> #request.content.core_navigation_rowtype_label_sortorder#</label>
		<input type="text" class="textInput" name="sortorder" id="formrow_F697EF9F8ADC4567AC073C31C98E80A2" value="#NumberFormat(ocore_navigation.getsortorder(),"9")#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
