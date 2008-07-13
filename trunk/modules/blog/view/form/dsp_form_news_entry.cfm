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
	<input type="hidden" name="id" id="formrow_08BC21EA09D64CA7ADB8E993B84E5C72" value="#onews_entry.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_08BC21EA09D64CA7ADB8E993B84E5C72">#request.content.news_entry_rowtype_label_id#</label>
		#Trim(onews_entry.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_028BF9C3992E445F88D4802A58CBE122"><em>*</em> #request.content.news_entry_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_028BF9C3992E445F88D4802A58CBE122" value="#Trim(onews_entry.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C3B1C851353644899D34724D07DE7B98"><em>*</em> #request.content.news_entry_rowtype_label_text#</label>
		<textarea name="text" id="formrow_C3B1C851353644899D34724D07DE7B98">#Trim(onews_entry.gettext())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_C3B1C851353644899D34724D07DE7B98 = new FCKeditor('text');
				oFCKeditor_formrow_C3B1C851353644899D34724D07DE7B98.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_C3B1C851353644899D34724D07DE7B98.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_C3B1C851353644899D34724D07DE7B98.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_C3B1C851353644899D34724D07DE7B98.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(onews_entry.getdate()))>
		<cfset onews_entry.setdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_56EBA5703FD24521BE232FD78BEE9FE3">#request.content.news_entry_rowtype_label_date#</label>
		<div class="divInput" id="divDatePicker56EBA5703FD24521BE232FD78BEE9FE3"></div>
		<input type="hidden" name="date" id="formrow_56EBA5703FD24521BE232FD78BEE9FE3" value="#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker56EBA5703FD24521BE232FD78BEE9FE3 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_56EBA5703FD24521BE232FD78BEE9FE3').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker56EBA5703FD24521BE232FD78BEE9FE3.render('divDatePicker56EBA5703FD24521BE232FD78BEE9FE3');
				var dt56EBA5703FD24521BE232FD78BEE9FE3 = new Date();
				dt56EBA5703FD24521BE232FD78BEE9FE3 = Date.parseDate("#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM')#","Y-m-d G:i");
				myDatePicker56EBA5703FD24521BE232FD78BEE9FE3.setValue(dt56EBA5703FD24521BE232FD78BEE9FE3);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_CEDF744499234B2BB359630213C2EDBF">#request.content.news_entry_rowtype_label_mp3url#</label>
		<input type="text" class="textInput" name="mp3url" id="formrow_CEDF744499234B2BB359630213C2EDBF" value="#Trim(onews_entry.getmp3url())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReluser = onews_entry.getuser().getid()>
	<div class="ctrlHolder">
		<label for="formrow_EB9EA727808143C09884623D4D1F3F9B">user</label>
		<select class="selectInput" name="author" id="formrow_EB9EA727808143C09884623D4D1F3F9B">
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
		<label for="formrow_33658CAEDFEE4C7CBA2EA89355417B15">news_entry_category</label>
		<select class="selectInput" name="news_entry_category" id="formrow_33658CAEDFEE4C7CBA2EA89355417B15" multiple="multiple" size="6">
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
