<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="onews_ping_url">
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
<h3>#request.content.__globalmodule__navigation__news_ping_url_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.news_ping_url_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.news_ping_url_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_C9436C4F378A4C2D9794DF1216D3766B" value="#onews_ping_url.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_C9436C4F378A4C2D9794DF1216D3766B">#request.content.news_ping_url_rowtype_label_id#</label>
		#Trim(onews_ping_url.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_53264387A8024E94BB3D376AC9E9FA91"><em>*</em> #request.content.news_ping_url_rowtype_label_name#</label>
		<input type="text" class="textInput" name="name" id="formrow_53264387A8024E94BB3D376AC9E9FA91" value="#Trim(onews_ping_url.getname())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_CE1E90FD4ED44D8F803C46C02000CDA8"><em>*</em> #request.content.news_ping_url_rowtype_label_url#</label>
		<input type="text" class="textInput" name="url" id="formrow_CE1E90FD4ED44D8F803C46C02000CDA8" value="#Trim(onews_ping_url.geturl())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
