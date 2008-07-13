<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocore_modules">
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
<h3>#request.content.__globalmodule__navigation__core_modules_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.core_modules_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.core_modules_grid_global_edit#</h4>
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
		<label for="formrow_7A10FFFFE1F846609AA4BECD330B0C89"><em>*</em> #request.content.core_modules_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_7A10FFFFE1F846609AA4BECD330B0C89" value="#Trim(ocore_modules.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_A99BB5B9CCC648568F409DD85913D465"><em>*</em> #request.content.core_modules_rowtype_label_version#</label>
		<input type="text" class="textInput" name="version" id="formrow_A99BB5B9CCC648568F409DD85913D465" value="#Trim(ocore_modules.getversion())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(ocore_modules.getdate()))>
		<cfset ocore_modules.setdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_81E6662A34F744CDA03C1407902A297C">#request.content.core_modules_rowtype_label_date#</label>
		<div class="divInput" id="divDatePicker81E6662A34F744CDA03C1407902A297C"></div>
		<input type="hidden" name="date" id="formrow_81E6662A34F744CDA03C1407902A297C" value="#LsDateFormat(Trim(ocore_modules.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ocore_modules.getdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker81E6662A34F744CDA03C1407902A297C = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_81E6662A34F744CDA03C1407902A297C').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker81E6662A34F744CDA03C1407902A297C.render('divDatePicker81E6662A34F744CDA03C1407902A297C');
				var dt81E6662A34F744CDA03C1407902A297C = new Date();
				dt81E6662A34F744CDA03C1407902A297C = Date.parseDate("#LsDateFormat(Trim(ocore_modules.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ocore_modules.getdate()),'HH:MM')#","Y-m-d G:i");
				myDatePicker81E6662A34F744CDA03C1407902A297C.setValue(dt81E6662A34F744CDA03C1407902A297C);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="folder" id="formrow_CD02FF824664408BAB28F8B248E5F1E7" value="#ocore_modules.getfolder()#" />
	<div class="ctrlHolder">
		<label for="formrow_CD02FF824664408BAB28F8B248E5F1E7">#request.content.core_modules_rowtype_label_folder#</label>
		#Trim(ocore_modules.getfolder())#
	</div>
	</cfif>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
