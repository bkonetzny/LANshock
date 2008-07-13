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
	function validate(){
		$('##btnSave').attr('disabled','disabled');
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
	<input type="hidden" name="module" id="formrow_7A4ED5BE142A441A936329B805B00A94" value="#ocore_configmanager.getmodule()#" />
	<div class="ctrlHolder">
		<label for="formrow_7A4ED5BE142A441A936329B805B00A94">#request.content.core_configmanager_rowtype_label_module#</label>
		#Trim(ocore_configmanager.getmodule())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_065AC802140E4C1FAB997C9338C71D6B"><em>*</em> #request.content.core_configmanager_rowtype_label_version#</label>
		<input type="text" class="textInput" name="version" id="formrow_065AC802140E4C1FAB997C9338C71D6B" value="#Trim(ocore_configmanager.getversion())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_56C6BCDEDB8D4738A98B7B715D2B8B72"><em>*</em> #request.content.core_configmanager_rowtype_label_data#</label>
		<textarea name="data" id="formrow_56C6BCDEDB8D4738A98B7B715D2B8B72">#Trim(ocore_configmanager.getdata())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(ocore_configmanager.getdtlastchanged()))>
		<cfset ocore_configmanager.setdtlastchanged(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_DB80D332C6C24FF0B23AE968970900BA">#request.content.core_configmanager_rowtype_label_dtlastchanged#</label>
		<div class="divInput" id="divDatePickerDB80D332C6C24FF0B23AE968970900BA"></div>
		<input type="hidden" name="dtlastchanged" id="formrow_DB80D332C6C24FF0B23AE968970900BA" value="#LsDateFormat(Trim(ocore_configmanager.getdtlastchanged()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ocore_configmanager.getdtlastchanged()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerDB80D332C6C24FF0B23AE968970900BA = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_DB80D332C6C24FF0B23AE968970900BA').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerDB80D332C6C24FF0B23AE968970900BA.render('divDatePickerDB80D332C6C24FF0B23AE968970900BA');
				var dtDB80D332C6C24FF0B23AE968970900BA = new Date();
				dtDB80D332C6C24FF0B23AE968970900BA = Date.parseDate("#LsDateFormat(Trim(ocore_configmanager.getdtlastchanged()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ocore_configmanager.getdtlastchanged()),'HH:MM')#","Y-m-d G:i");
				myDatePickerDB80D332C6C24FF0B23AE968970900BA.setValue(dtDB80D332C6C24FF0B23AE968970900BA);
			});
			//-->
		</script>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
