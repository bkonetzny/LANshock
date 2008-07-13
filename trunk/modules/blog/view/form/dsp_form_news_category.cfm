<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="onews_category">
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
<h3>#request.content.__globalmodule__navigation__news_category_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.news_category_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.news_category_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_0C2837F238DB4628A7AD1F9C50F084E4" value="#onews_category.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_0C2837F238DB4628A7AD1F9C50F084E4">#request.content.news_category_rowtype_label_id#</label>
		#Trim(onews_category.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E8CCEC5C01624D5599630196D3BF1998"><em>*</em> #request.content.news_category_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_E8CCEC5C01624D5599630196D3BF1998" value="#Trim(onews_category.getname())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToMany</legend>
		
			
				
				
				
				
					

	
	<cfset lRelnews_entry_category = onews_category.getnews_entry_categoryiterator().getValueList('entry_id')>
	<div class="ctrlHolder">
		<label for="formrow_8509CFBB7A18403EA2FF3BB66F04B92D">news_entry_category</label>
		<select class="selectInput" name="news_entry_category" id="formrow_8509CFBB7A18403EA2FF3BB66F04B92D" multiple="multiple" size="6">
			<option value=""></option>
			<cfloop query="stRelated.stManyToMany.news_entry_category.qData">
				<option value="#stRelated.stManyToMany.news_entry_category.qData.optionvalue#"<cfif ListFind(lRelnews_entry_category,stRelated.stManyToMany.news_entry_category.qData.optionvalue)> selected="selected"</cfif>>#stRelated.stManyToMany.news_entry_category.qData.optionname#</option>
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
