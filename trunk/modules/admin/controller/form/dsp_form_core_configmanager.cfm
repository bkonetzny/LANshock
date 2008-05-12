<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocore_configmanager">
<!--- This parameter specifies if we are to use Search Safe URLs or not --->
<cfparam name="request.searchSafe" default="false">
</cfsilent>
<cfoutput>
<script type="text/javascript">
<!--
	function validate(myform, XFA){
		$('##btnSave').disabled = true;
		return true;
	};
//-->
</script>
<h3>#request.content.__globalmodule__navigation__core_configmanager_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.core_configmanager_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.core_configmanager_grid_global_edit#</h4>
</cfif>
<cfif isDefined("aTranslatedErrors") AND ArrayLen(aTranslatedErrors)>
	<div class="errorBox">
		#request.content.error#
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
		<label for="formrow_5C79F10C0762454CBA1E30B7382E395E">#request.content.core_configmanager_rowtype_label_module#</label>
		<textarea name="module" id="formrow_5C79F10C0762454CBA1E30B7382E395E">#Trim(ocore_configmanager.getmodule())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A12A35263B35469E8711EBF79977D2EF">#request.content.core_configmanager_rowtype_label_version#</label>
		<textarea name="version" id="formrow_A12A35263B35469E8711EBF79977D2EF">#Trim(ocore_configmanager.getversion())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_3270A8C4B9014BD5B91B61B13D45C444">#request.content.core_configmanager_rowtype_label_data#</label>
		<textarea name="data" id="formrow_3270A8C4B9014BD5B91B61B13D45C444">#Trim(ocore_configmanager.getdata())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_DA1DB8A617184A788F42B470641A39E2">#request.content.core_configmanager_rowtype_label_dtlastchanged#</label>
		<input type="text" class="textInput" name="dtlastchanged" id="formrow_DA1DB8A617184A788F42B470641A39E2" value="#Trim(ocore_configmanager.getdtlastchanged())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<cfset sortParams = appendParam("","_listSortByFieldList",attributes._listSortByFieldList)>
		<cfset sortParams = appendParam(sortParams,"_Maxrows",attributes._Maxrows)>
		<cfset sortParams = appendParam(sortParams,"_StartRow",attributes._Startrow)>
		<cfset sortParams = appendParam(sortParams,"fuseaction",XFA.cancel)>
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self##sortParams#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
