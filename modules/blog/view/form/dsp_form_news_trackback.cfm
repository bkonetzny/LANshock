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
<form id="frmAddEdit" action="#application.lanshock.oHelper.buildUrl('#xfa.save#')#" method="post" class="uniForm" onsubmit="javascript: return validate();">
	<div class="hidden">
		<!---<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
		<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
		<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />--->
	</div>
	
	

	
		
		
		
		
		
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
				
				
				
				
			
		
				
		
	
	
	
	
				
	
	
	
	
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aTable</legend>
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_55D39CE3732F4CCDA4E8BDA9E9693CFF" value="#onews_trackback.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_55D39CE3732F4CCDA4E8BDA9E9693CFF">#request.content.news_trackback_rowtype_label_id#</label>
		#Trim(onews_trackback.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_542BF75FB9104950B1E1BD9696768C9B"><em>*</em> #request.content.news_trackback_rowtype_label_entry_id#</label>
		<input type="text" class="textInput" name="entry_id" id="formrow_542BF75FB9104950B1E1BD9696768C9B" value="#Trim(onews_trackback.getentry_id())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E356F986B6B54075A0F2B71783A1AA7E"><em>*</em> #request.content.news_trackback_rowtype_label_blog_name#</label>
		<input type="text" class="textInput" name="blog_name" id="formrow_E356F986B6B54075A0F2B71783A1AA7E" value="#Trim(onews_trackback.getblog_name())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_AB072C1B952B43E5A7B7828AC6C32246"><em>*</em> #request.content.news_trackback_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_AB072C1B952B43E5A7B7828AC6C32246" value="#Trim(onews_trackback.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_3D8FDE65ED7641919009E5E6D5351E1A"><em>*</em> #request.content.news_trackback_rowtype_label_text#</label>
		<textarea name="text" id="formrow_3D8FDE65ED7641919009E5E6D5351E1A">#Trim(onews_trackback.gettext())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(onews_trackback.getdate()))>
		<cfset onews_trackback.setdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_246B4F64EF72492D967E6E1B5BE3735B">#request.content.news_trackback_rowtype_label_date#</label>
		<div class="divInput" id="divDatePicker246B4F64EF72492D967E6E1B5BE3735B"></div>
		<input type="hidden" name="date" id="formrow_246B4F64EF72492D967E6E1B5BE3735B" value="#LsDateFormat(Trim(onews_trackback.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_trackback.getdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker246B4F64EF72492D967E6E1B5BE3735B = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_246B4F64EF72492D967E6E1B5BE3735B').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker246B4F64EF72492D967E6E1B5BE3735B.render('divDatePicker246B4F64EF72492D967E6E1B5BE3735B');
				var dt246B4F64EF72492D967E6E1B5BE3735B = new Date();
				dt246B4F64EF72492D967E6E1B5BE3735B = Date.parseDate("#LsDateFormat(Trim(onews_trackback.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_trackback.getdate()),'HH:MM')#","Y-m-d G:i");
				myDatePicker246B4F64EF72492D967E6E1B5BE3735B.setValue(dt246B4F64EF72492D967E6E1B5BE3735B);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E1FF9E522D3A4A87A5D40726679DFE85"><em>*</em> #request.content.news_trackback_rowtype_label_url#</label>
		<input type="text" class="textInput" name="url" id="formrow_E1FF9E522D3A4A87A5D40726679DFE85" value="#Trim(onews_trackback.geturl())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
