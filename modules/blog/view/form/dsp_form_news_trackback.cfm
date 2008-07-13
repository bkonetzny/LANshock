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
		
			
				
				
				
				
					

	
	<cfif mode EQ "edit">
	<input type="hidden" name="id" id="formrow_AE7923157E66428CB0DE8B42F71691AE" value="#onews_trackback.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_AE7923157E66428CB0DE8B42F71691AE">#request.content.news_trackback_rowtype_label_id#</label>
		#Trim(onews_trackback.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_38700342EF774DA8887206543A6213E7"><em>*</em> #request.content.news_trackback_rowtype_label_entry_id#</label>
		<input type="text" class="textInput" name="entry_id" id="formrow_38700342EF774DA8887206543A6213E7" value="#Trim(onews_trackback.getentry_id())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_99CF57BEF9614043A2445627F4E9840F"><em>*</em> #request.content.news_trackback_rowtype_label_blog_name#</label>
		<input type="text" class="textInput" name="blog_name" id="formrow_99CF57BEF9614043A2445627F4E9840F" value="#Trim(onews_trackback.getblog_name())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_1D83085578E24C61B112F24ABCC3D9FA"><em>*</em> #request.content.news_trackback_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_1D83085578E24C61B112F24ABCC3D9FA" value="#Trim(onews_trackback.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_43EC79648D174F3991892FEFA637BE92"><em>*</em> #request.content.news_trackback_rowtype_label_text#</label>
		<textarea name="text" id="formrow_43EC79648D174F3991892FEFA637BE92">#Trim(onews_trackback.gettext())#</textarea>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(onews_trackback.getdate()))>
		<cfset onews_trackback.setdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_F5E68C5D9147491CB17D3EA58080F9A2">#request.content.news_trackback_rowtype_label_date#</label>
		<div class="divInput" id="divDatePickerF5E68C5D9147491CB17D3EA58080F9A2"></div>
		<input type="hidden" name="date" id="formrow_F5E68C5D9147491CB17D3EA58080F9A2" value="#LsDateFormat(Trim(onews_trackback.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_trackback.getdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerF5E68C5D9147491CB17D3EA58080F9A2 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_F5E68C5D9147491CB17D3EA58080F9A2').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerF5E68C5D9147491CB17D3EA58080F9A2.render('divDatePickerF5E68C5D9147491CB17D3EA58080F9A2');
				var dtF5E68C5D9147491CB17D3EA58080F9A2 = new Date();
				dtF5E68C5D9147491CB17D3EA58080F9A2 = Date.parseDate("#LsDateFormat(Trim(onews_trackback.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_trackback.getdate()),'HH:MM')#","Y-m-d G:i");
				myDatePickerF5E68C5D9147491CB17D3EA58080F9A2.setValue(dtF5E68C5D9147491CB17D3EA58080F9A2);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_B755159758CC4C9AA7C6834A5210F694"><em>*</em> #request.content.news_trackback_rowtype_label_url#</label>
		<input type="text" class="textInput" name="url" id="formrow_B755159758CC4C9AA7C6834A5210F694" value="#Trim(onews_trackback.geturl())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
