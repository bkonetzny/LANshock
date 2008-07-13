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
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_FE432593E36245B4AD77D24B87B0D564" value="#ocore_logs.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_FE432593E36245B4AD77D24B87B0D564">#request.content.core_logs_rowtype_label_id#</label>
		#Trim(ocore_logs.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_BC9DA5353E8F4CD2B35DEB1B8F577252"><em>*</em> #request.content.core_logs_rowtype_label_logname#</label>
		<input type="text" class="textInput" name="logname" id="formrow_BC9DA5353E8F4CD2B35DEB1B8F577252" value="#Trim(ocore_logs.getlogname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_48C35EDF264F440DB2D5E3F7833C10B9"><em>*</em> #request.content.core_logs_rowtype_label_level#</label>
		<input type="text" class="textInput" name="level" id="formrow_48C35EDF264F440DB2D5E3F7833C10B9" value="#Trim(ocore_logs.getlevel())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_76388ECE75994DCAB667B1C4749BF3E3"><em>*</em> #request.content.core_logs_rowtype_label_data#</label>
		<textarea name="data" id="formrow_76388ECE75994DCAB667B1C4749BF3E3">#Trim(ocore_logs.getdata())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(ocore_logs.gettimestamp()))>
		<cfset ocore_logs.settimestamp(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_8EB07AE5F9844EDF9571F3067730581B">#request.content.core_logs_rowtype_label_timestamp#</label>
		<div class="divInput" id="divDatePicker8EB07AE5F9844EDF9571F3067730581B"></div>
		<input type="hidden" name="timestamp" id="formrow_8EB07AE5F9844EDF9571F3067730581B" value="#LsDateFormat(Trim(ocore_logs.gettimestamp()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ocore_logs.gettimestamp()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker8EB07AE5F9844EDF9571F3067730581B = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_8EB07AE5F9844EDF9571F3067730581B').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker8EB07AE5F9844EDF9571F3067730581B.render('divDatePicker8EB07AE5F9844EDF9571F3067730581B');
				var dt8EB07AE5F9844EDF9571F3067730581B = new Date();
				dt8EB07AE5F9844EDF9571F3067730581B = Date.parseDate("#LsDateFormat(Trim(ocore_logs.gettimestamp()),'YYYY-MM-DD')# #LsTimeFormat(Trim(ocore_logs.gettimestamp()),'HH:MM')#","Y-m-d G:i");
				myDatePicker8EB07AE5F9844EDF9571F3067730581B.setValue(dt8EB07AE5F9844EDF9571F3067730581B);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_1B3E071001E9450E952CDA709FF56D75"><em>*</em> #request.content.core_logs_rowtype_label_userid#</label>
		<input type="text" class="textInput" name="userid" id="formrow_1B3E071001E9450E952CDA709FF56D75" value="#Trim(ocore_logs.getuserid())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
