<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocore_logs">
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
<h3>#request.content.__globalmodule__navigation__core_logs_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.core_logs_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.core_logs_grid_global_edit#</h4>
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
		<label for="formrow_827E3BFACAD0447B83D0163079C55D9A"><em>*</em> #request.content.core_logs_rowtype_label_id#</label>
		<input type="text" class="textInput" name="id" id="formrow_827E3BFACAD0447B83D0163079C55D9A" value="#NumberFormat(ocore_logs.getid(),"9")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_B386F2BBF1B54396A034EDAFAD1F0986"><em>*</em> #request.content.core_logs_rowtype_label_logname#</label>
		<textarea name="logname" id="formrow_B386F2BBF1B54396A034EDAFAD1F0986">#Trim(ocore_logs.getlogname())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_83C6259B2CFF4982A7E75E90B2E92DA3"><em>*</em> #request.content.core_logs_rowtype_label_level#</label>
		<textarea name="level" id="formrow_83C6259B2CFF4982A7E75E90B2E92DA3">#Trim(ocore_logs.getlevel())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_01F33088BC314420B1274E210C1388BC"><em>*</em> #request.content.core_logs_rowtype_label_data#</label>
		<textarea name="data" id="formrow_01F33088BC314420B1274E210C1388BC">#Trim(ocore_logs.getdata())#</textarea>
	</div>
				
			
			
				
				
				
				
					
	
	
	<div class="ctrlHolder">
		<label for="formrow_B230C88FDD224D34AD6327AB8A8D7A43">#request.content.core_logs_rowtype_label_timestamp#</label>
		Unknown field type "Time"
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
