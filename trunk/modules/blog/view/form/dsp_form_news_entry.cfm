<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="onews_entry">
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
<h3>#request.content.__globalmodule__navigation__news_entry_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.news_entry_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.news_entry_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_460609F6B4F14863B1E776F99BDA503A" value="#onews_entry.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_460609F6B4F14863B1E776F99BDA503A">#request.content.news_entry_rowtype_label_id#</label>
		#Trim(onews_entry.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_BE8D935C0B3B48728B1150C6A48177D0"><em>*</em> #request.content.news_entry_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_BE8D935C0B3B48728B1150C6A48177D0" value="#Trim(onews_entry.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_52929EE79C234F33BA5762EC644E4CEA"><em>*</em> #request.content.news_entry_rowtype_label_text#</label>
		<textarea name="text" id="formrow_52929EE79C234F33BA5762EC644E4CEA">#Trim(onews_entry.gettext())#</textarea>
		<script type="text/javascript">
			<!--
				$(document).ready(function(){
					var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
					var oFCKeditor_formrow_52929EE79C234F33BA5762EC644E4CEA = new FCKeditor('text');
					oFCKeditor_formrow_52929EE79C234F33BA5762EC644E4CEA.BasePath = sBasePath + "fckeditor/";
					oFCKeditor_formrow_52929EE79C234F33BA5762EC644E4CEA.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
					oFCKeditor_formrow_52929EE79C234F33BA5762EC644E4CEA.Value = '';
					oFCKeditor_formrow_52929EE79C234F33BA5762EC644E4CEA.ReplaceTextarea();
				});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(onews_entry.getdate()))>
		<cfset onews_entry.setdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_F3BF397376564F9BA8F5B8E1CB291644">#request.content.news_entry_rowtype_label_date#</label>
		<div class="divInput" id="divDatePickerF3BF397376564F9BA8F5B8E1CB291644"></div>
		<input type="hidden" name="date" id="formrow_F3BF397376564F9BA8F5B8E1CB291644" value="#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePickerF3BF397376564F9BA8F5B8E1CB291644 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_F3BF397376564F9BA8F5B8E1CB291644').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerF3BF397376564F9BA8F5B8E1CB291644.render('divDatePickerF3BF397376564F9BA8F5B8E1CB291644');
				var dtF3BF397376564F9BA8F5B8E1CB291644 = new Date();
				dtF3BF397376564F9BA8F5B8E1CB291644 = Date.parseDate("#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM')#","Y-m-d G:i");
				myDatePickerF3BF397376564F9BA8F5B8E1CB291644.setValue(dtF3BF397376564F9BA8F5B8E1CB291644);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_CAEC057866294DD9A5E740FCF828EFA7">#request.content.news_entry_rowtype_label_mp3url#</label>
		<input type="text" class="textInput" name="mp3url" id="formrow_CAEC057866294DD9A5E740FCF828EFA7" value="#Trim(onews_entry.getmp3url())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReluser = onews_entry.getuser().getid()>
	<div class="ctrlHolder">
		<label for="formrow_1E6A8404C78147208D8791F225F20CF5">user</label>
		<select class="selectInput" name="author" id="formrow_1E6A8404C78147208D8791F225F20CF5">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.user.qData">
				<option value="#stRelated.stManyToOne.user.qData.optionvalue#"<cfif sReluser EQ stRelated.stManyToOne.user.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.user.qData.optionname#</option>
			</cfloop>
		</select>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToMany</legend>
		
			
				
				
				
				
					

	
	<cfset lRelnews_entry_category = onews_entry.getnews_entry_categoryiterator().getValueList('category_id')>
	<div class="ctrlHolder">
		<label for="formrow_B8C98258C5BB4E159E45FF27117A8494">news_entry_category</label>
		<select class="selectInput" name="news_entry_category" id="formrow_B8C98258C5BB4E159E45FF27117A8494" multiple="multiple" size="6">
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
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#jsStringFormat(application.lanshock.oHelper.buildUrl('#xfa.cancel#'))#<!---&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#--->';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
