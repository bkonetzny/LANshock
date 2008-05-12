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
	<input type="hidden" name="id" id="formrow_34DC170C2FC34611AC0C8B1CEF92DFD6" value="#onews_entry.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_34DC170C2FC34611AC0C8B1CEF92DFD6">#request.content.news_entry_rowtype_label_id#</label>
		#NumberFormat(onews_entry.getid(),"9.99")#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_AD69F65A4A5B4A0A8026959438C6A97C"><em>*</em> #request.content.news_entry_rowtype_label_author#</label>
		
			<select class="selectInput" name="author" id="formrow_AD69F65A4A5B4A0A8026959438C6A97C">
				<option value=""></option>
				<cfloop query="stRelated.stManyToOne.user.qData">
					<option value="#stRelated.stManyToOne.user.qData.optionvalue#"<cfif onews_entry.getauthor() EQ stRelated.stManyToOne.user.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.user.qData.optionname#</option>
				</cfloop>
			</select>
		
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_69BFC8171B2647A698EF591B1EB93A40"><em>*</em> #request.content.news_entry_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_69BFC8171B2647A698EF591B1EB93A40" value="#Trim(onews_entry.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6507FEA3B63740379179D92B5FEB15F8"><em>*</em> #request.content.news_entry_rowtype_label_text#</label>
		<textarea name="text" id="formrow_6507FEA3B63740379179D92B5FEB15F8">#Trim(onews_entry.gettext())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_6507FEA3B63740379179D92B5FEB15F8 = new FCKeditor('text');
				oFCKeditor_formrow_6507FEA3B63740379179D92B5FEB15F8.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_6507FEA3B63740379179D92B5FEB15F8.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_6507FEA3B63740379179D92B5FEB15F8.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_6507FEA3B63740379179D92B5FEB15F8.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(onews_entry.getdate()))>
		<cfset onews_entry.setdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_C7FEEE49EAD44F808BC1BED7FEC68EC4">#request.content.news_entry_rowtype_label_date#</label>
		<div id="divDatePickerC7FEEE49EAD44F808BC1BED7FEC68EC4"></div>
		<input type="hidden" name="date" id="formrow_C7FEEE49EAD44F808BC1BED7FEC68EC4" value="#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			var myDatePickerC7FEEE49EAD44F808BC1BED7FEC68EC4 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_C7FEEE49EAD44F808BC1BED7FEC68EC4').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePickerC7FEEE49EAD44F808BC1BED7FEC68EC4.render('divDatePickerC7FEEE49EAD44F808BC1BED7FEC68EC4');
				var dtC7FEEE49EAD44F808BC1BED7FEC68EC4 = new Date();
				dtC7FEEE49EAD44F808BC1BED7FEC68EC4 = Date.parseDate("#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM')#","Y-m-d G:i");
				myDatePickerC7FEEE49EAD44F808BC1BED7FEC68EC4.setValue(dtC7FEEE49EAD44F808BC1BED7FEC68EC4);
			});
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_192687426D4C4C248D864368A52EAD7E">#request.content.news_entry_rowtype_label_mp3url#</label>
		<input type="text" class="textInput" name="mp3url" id="formrow_192687426D4C4C248D864368A52EAD7E" value="#Trim(onews_entry.getmp3url())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	
		<div class="ctrlHolder">
			attributes.stFieldData.links[1].name is not defined!
		</div>
	
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToMany</legend>
		
			
				
				
				
				
					

	
	
		<cfset lRelnews_entry_category = onews_entry.getnews_entry_categoryiterator().getValueList('category_id')>
		<div class="ctrlHolder">
			<label for="formrow_2951CB8408E04038A0063447268E11A3">news_entry_category</label>
			<select class="selectInput" name="news_entry_category" id="formrow_2951CB8408E04038A0063447268E11A3" multiple="multiple" size="6">
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
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
