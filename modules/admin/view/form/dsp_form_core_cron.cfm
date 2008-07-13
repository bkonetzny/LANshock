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
	function validate(){
		$('##btnSave').attr('disabled','disabled');
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
	<input type="hidden" name="id" id="formrow_00B6C661182B4F1D91EDC6361301A6A3" value="#ocore_cron.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_00B6C661182B4F1D91EDC6361301A6A3">#request.content.core_cron_rowtype_label_id#</label>
		#Trim(ocore_cron.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_6FE647D8AA3C4A8D8BC8FF9E16C92198" class="inlineLabel"><input type="checkbox" name="active" id="formrow_6FE647D8AA3C4A8D8BC8FF9E16C92198" value="1"<cfif ocore_cron.getactive()> checked="checked"</cfif>/> <em>*</em>  #request.content.core_cron_rowtype_label_active#</label>
		</div>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C7843490336D400AB793154A98B0868C">#request.content.core_cron_rowtype_label_run#</label>
		<input type="text" class="textInput" name="run" id="formrow_C7843490336D400AB793154A98B0868C" value="#Trim(ocore_cron.getrun())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2D41C8A68DA84D18B305203A9D13460F">#request.content.core_cron_rowtype_label_module#</label>
		<input type="text" class="textInput" name="module" id="formrow_2D41C8A68DA84D18B305203A9D13460F" value="#Trim(ocore_cron.getmodule())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_043F2DF84D50445DAD41ACECFC8A9AD2">#request.content.core_cron_rowtype_label_action#</label>
		<input type="text" class="textInput" name="action" id="formrow_043F2DF84D50445DAD41ACECFC8A9AD2" value="#Trim(ocore_cron.getaction())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sValue = Trim(ocore_cron.getexecutions())>
	<input type="hidden" name="executions" id="formrow_80CFA59BDB7049B18F56C04D0797CF4E" value="#Trim(ocore_cron.getexecutions())#"/>
	<div class="ctrlHolder">
		<label for="formrow_80CFA59BDB7049B18F56C04D0797CF4E">#request.content.core_cron_rowtype_label_executions#</label>
		<cfif LsIsDate(sValue)>
			#session.oUser.DateTimeFormat(sValue)#
		<cfelse>
			#sValue#
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sValue = Trim(ocore_cron.getlastrun_dt())>
	<input type="hidden" name="lastrun_dt" id="formrow_7409872AF3B44F6F8A3F8802BE8BA51D" value="#Trim(ocore_cron.getlastrun_dt())#"/>
	<div class="ctrlHolder">
		<label for="formrow_7409872AF3B44F6F8A3F8802BE8BA51D">#request.content.core_cron_rowtype_label_lastrun_dt#</label>
		<cfif LsIsDate(sValue)>
			#session.oUser.DateTimeFormat(sValue)#
		<cfelse>
			#sValue#
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sValue = Trim(ocore_cron.getlastrun_time())>
	<input type="hidden" name="lastrun_time" id="formrow_D0CA895C92ED4A3CAE7BB01237C16536" value="#Trim(ocore_cron.getlastrun_time())#"/>
	<div class="ctrlHolder">
		<label for="formrow_D0CA895C92ED4A3CAE7BB01237C16536">#request.content.core_cron_rowtype_label_lastrun_time#</label>
		<cfif LsIsDate(sValue)>
			#session.oUser.DateTimeFormat(sValue)#
		<cfelse>
			#sValue#
		</cfif>
	</div>
				
			
			
				
				
				
				
					

	
	<cfset sValue = Trim(ocore_cron.getresult())>
	<input type="hidden" name="result" id="formrow_774CEECB1EB74125ADC184886040C412" value="#Trim(ocore_cron.getresult())#"/>
	<div class="ctrlHolder">
		<label for="formrow_774CEECB1EB74125ADC184886040C412">#request.content.core_cron_rowtype_label_result#</label>
		<cfif LsIsDate(sValue)>
			#session.oUser.DateTimeFormat(sValue)#
		<cfelse>
			#sValue#
		</cfif>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
