<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="onews_entry_category">
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
<h3>#request.content.__globalmodule__navigation__news_entry_category_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.news_entry_category_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.news_entry_category_grid_global_edit#</h4>
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
<form id="frmAddEdit" action="#application.lanshock.oHelper.buildUrl('#xfa.save#')#" method="post" class="uniForm" onsubmit="javascript: return validate();">
	<div class="hidden">
		<!---<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
		<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
		<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />--->
	</div>
	
	

	
		
		
		
		
		
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
		
				
		
	
	
	
	
		
		
		
		
		
			
				
				
				
				
				
						
					
				
				
			
				
				
				
				
				
						
					
				
				
			
		
				
		
	
				
	
	
	
	
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aTable</legend>
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_060BDAE38CCC4F58B2F22B926C70EEEB" value="#onews_entry_category.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_060BDAE38CCC4F58B2F22B926C70EEEB">#request.content.news_entry_category_rowtype_label_id#</label>
		#Trim(onews_entry_category.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_9DAAFC5737904630B5D26F033BBAC4A3"><em>*</em> #request.content.news_entry_category_rowtype_label_entry_id#</label>
		<input type="text" class="textInput" name="entry_id" id="formrow_9DAAFC5737904630B5D26F033BBAC4A3" value="#Trim(onews_entry_category.getentry_id())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6052C3371DB84419B5D1CAEE9F110909"><em>*</em> #request.content.news_entry_category_rowtype_label_category_id#</label>
		<input type="text" class="textInput" name="category_id" id="formrow_6052C3371DB84419B5D1CAEE9F110909" value="#Trim(onews_entry_category.getcategory_id())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aOneToMany</legend>
		
			
				
				
				
				
					

	
	
		<div class="ctrlHolder">
			OneToMany: attributes.stFieldData.links[1].name is not defined!
		</div>
	
				
			
			
				
				
				
				
					

	
	
		<div class="ctrlHolder">
			OneToMany: attributes.stFieldData.links[1].name is not defined!
		</div>
	
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
