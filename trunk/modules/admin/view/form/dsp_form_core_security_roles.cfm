<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocore_security_roles">
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
<h3>#request.content.__globalmodule__navigation__core_security_roles_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.core_security_roles_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.core_security_roles_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_7EC128104CCE4633A535FCDE27F651E6" value="#ocore_security_roles.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_7EC128104CCE4633A535FCDE27F651E6">#request.content.core_security_roles_rowtype_label_id#</label>
		#NumberFormat(ocore_security_roles.getid(),"9.99")#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_EAF46ECCC28540C49409D59082179047"><em>*</em> #request.content.core_security_roles_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_EAF46ECCC28540C49409D59082179047" value="#Trim(ocore_security_roles.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="module" id="formrow_9D248148A17340AAA0D0734391512375" value="#ocore_security_roles.getmodule()#" />
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToMany</legend>
		
			
				
				
				
				
					

	
	
		<cfset lRelcore_security_roles_permissions_rel = ocore_security_roles.getcore_security_roles_permissions_reliterator().getValueList('permission_id')>
		<div class="ctrlHolder">
			<label for="formrow_4A772A06AA5F4CE190DD31D0503D095C">core_security_roles_permissions_rel</label>
			<select class="selectInput" name="core_security_roles_permissions_rel" id="formrow_4A772A06AA5F4CE190DD31D0503D095C" multiple="multiple" size="6">
				<option value=""></option>
				<cfloop query="stRelated.stManyToMany.core_security_roles_permissions_rel.qData">
					<option value="#stRelated.stManyToMany.core_security_roles_permissions_rel.qData.optionvalue#"<cfif ListFind(lRelcore_security_roles_permissions_rel,stRelated.stManyToMany.core_security_roles_permissions_rel.qData.optionvalue)> selected="selected"</cfif>>#stRelated.stManyToMany.core_security_roles_permissions_rel.qData.optionname#</option>
				</cfloop>
			</select>
		</div>
	
				
			
			
				
				
				
				
					

	
	
		<cfset lRelcore_security_users_roles_rel = ocore_security_roles.getcore_security_users_roles_reliterator().getValueList('user_id')>
		<div class="ctrlHolder">
			<label for="formrow_2650D3F79D6740378A3CA6D2AD583939">core_security_users_roles_rel</label>
			<select class="selectInput" name="core_security_users_roles_rel" id="formrow_2650D3F79D6740378A3CA6D2AD583939" multiple="multiple" size="6">
				<option value=""></option>
				<cfloop query="stRelated.stManyToMany.core_security_users_roles_rel.qData">
					<option value="#stRelated.stManyToMany.core_security_users_roles_rel.qData.optionvalue#"<cfif ListFind(lRelcore_security_users_roles_rel,stRelated.stManyToMany.core_security_users_roles_rel.qData.optionvalue)> selected="selected"</cfif>>#stRelated.stManyToMany.core_security_users_roles_rel.qData.optionname#</option>
				</cfloop>
			</select>
		</div>
	
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
