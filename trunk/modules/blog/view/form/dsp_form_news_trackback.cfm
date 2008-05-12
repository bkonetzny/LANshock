<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="onews_trackback">
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
<h3>#request.content.__globalmodule__navigation__news_trackback_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.news_trackback_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.news_trackback_grid_global_edit#</h4>
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
		<label for="formrow_FF036E2F2E084245B1E706442A939030"><em>*</em> #request.content.news_trackback_rowtype_label_blog_name#</label>
		<input type="text" class="textInput" name="blog_name" id="formrow_FF036E2F2E084245B1E706442A939030" value="#Trim(onews_trackback.getblog_name())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_863AA37D0E5447CB8DF923FBF9AED2C5">#request.content.news_trackback_rowtype_label_date#</label>
		<input type="text" class="textInput" name="date" id="formrow_863AA37D0E5447CB8DF923FBF9AED2C5" value="#Trim(onews_trackback.getdate())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_70C9C77D21744339A879206E1A7AAB8F"><em>*</em> #request.content.news_trackback_rowtype_label_entry_id#</label>
		<input type="text" class="textInput" name="entry_id" id="formrow_70C9C77D21744339A879206E1A7AAB8F" value="#NumberFormat(onews_trackback.getentry_id(),"9.99")#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_DB3BE83CFD23471EB8870FFEE0CD8143" value="#onews_trackback.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_DB3BE83CFD23471EB8870FFEE0CD8143">#request.content.news_trackback_rowtype_label_id#</label>
		#NumberFormat(onews_trackback.getid(),"9.99")#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_26128A44C6B547F4BD05700513B7AE80"><em>*</em> #request.content.news_trackback_rowtype_label_text#</label>
		<textarea name="text" id="formrow_26128A44C6B547F4BD05700513B7AE80">#Trim(onews_trackback.gettext())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_F8476951506241CAA56E8CABB8DDCE52"><em>*</em> #request.content.news_trackback_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_F8476951506241CAA56E8CABB8DDCE52" value="#Trim(onews_trackback.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_353E4E003C21444D830AC9A32B55E48B"><em>*</em> #request.content.news_trackback_rowtype_label_url#</label>
		<input type="text" class="textInput" name="url" id="formrow_353E4E003C21444D830AC9A32B55E48B" value="#Trim(onews_trackback.geturl())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
