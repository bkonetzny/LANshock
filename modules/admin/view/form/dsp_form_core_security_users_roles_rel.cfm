<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocore_security_users_roles_rel">
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
<h3>#request.content.__globalmodule__navigation__core_security_users_roles_rel_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.core_security_users_roles_rel_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.core_security_users_roles_rel_grid_global_edit#</h4>
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
		<label for="formrow_B66BAD5021AB4018846E6527F9C9173B"><em>*</em> #request.content.core_security_users_roles_rel_rowtype_label_role_id#</label>
		<input type="text" class="textInput" name="role_id" id="formrow_B66BAD5021AB4018846E6527F9C9173B" value="#NumberFormat(ocore_security_users_roles_rel.getrole_id(),"9")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_2E99C32ACDAC4D45BA5FB0ED93DD2749"><em>*</em> #request.content.core_security_users_roles_rel_rowtype_label_user_id#</label>
		<input type="text" class="textInput" name="user_id" id="formrow_2E99C32ACDAC4D45BA5FB0ED93DD2749" value="#NumberFormat(ocore_security_users_roles_rel.getuser_id(),"9")#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aOneToMany</legend>
		
			
				
				
				
				
					

	
	
		<div class="ctrlHolder">
			attributes.stFieldData.links[1].name is not defined!
		</div>
	
				
			
			
				
				
				
				
					

	
	
		<div class="ctrlHolder">
			attributes.stFieldData.links[1].name is not defined!
		</div>
	
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
