<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocore_cron">
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
<h3>#request.content.__globalmodule__navigation__core_cron_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.core_cron_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.core_cron_grid_global_edit#</h4>
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
		<label for="formrow_6DDF28BBCD1D401392260BD2112E7225">#request.content.core_cron_rowtype_label_executions#</label>
		<input type="text" class="textInput" name="executions" id="formrow_6DDF28BBCD1D401392260BD2112E7225" value="#NumberFormat(ocore_cron.getexecutions(),"9.99")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6D2FCF59C8E24595B38BF524FDC39EF1">#request.content.core_cron_rowtype_label_id#</label>
		<input type="text" class="textInput" name="id" id="formrow_6D2FCF59C8E24595B38BF524FDC39EF1" value="#NumberFormat(ocore_cron.getid(),"9.99")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_1CC6FA35F7584A978CA133A2F5E66C28">#request.content.core_cron_rowtype_label_lastrun_dt#</label>
		<input type="text" class="textInput" name="lastrun_dt" id="formrow_1CC6FA35F7584A978CA133A2F5E66C28" value="#Trim(ocore_cron.getlastrun_dt())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6598C227DF1F4D4189A6EAD58183F24C">#request.content.core_cron_rowtype_label_active#</label>
		<input type="text" class="textInput" name="active" id="formrow_6598C227DF1F4D4189A6EAD58183F24C" value="#NumberFormat(ocore_cron.getactive(),"9.99")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_8E6C0B296ECD48F58149033715798EE5">#request.content.core_cron_rowtype_label_action#</label>
		<textarea name="action" id="formrow_8E6C0B296ECD48F58149033715798EE5">#Trim(ocore_cron.getaction())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2EBBDC87CEC04E179DCB67FCD5DEF023">#request.content.core_cron_rowtype_label_module#</label>
		<textarea name="module" id="formrow_2EBBDC87CEC04E179DCB67FCD5DEF023">#Trim(ocore_cron.getmodule())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_8B83D4CFEC154FC48B8CF1049EFBDA46">#request.content.core_cron_rowtype_label_result#</label>
		<textarea name="result" id="formrow_8B83D4CFEC154FC48B8CF1049EFBDA46">#Trim(ocore_cron.getresult())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_1BD213E2397C4F9D8565CDF0D455D443">#request.content.core_cron_rowtype_label_run#</label>
		<textarea name="run" id="formrow_1BD213E2397C4F9D8565CDF0D455D443">#Trim(ocore_cron.getrun())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_545EDC2895A24CA5A2103AEC36F8F1E8">#request.content.core_cron_rowtype_label_lastrun_time#</label>
		<input type="text" class="textInput" name="lastrun_time" id="formrow_545EDC2895A24CA5A2103AEC36F8F1E8" value="#NumberFormat(ocore_cron.getlastrun_time(),"9.99")#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
