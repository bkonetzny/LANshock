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
	<input type="hidden" name="id" id="formrow_EF510058536B432693733BD59DE3D2DC" value="#onews_entry.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_EF510058536B432693733BD59DE3D2DC">#request.content.news_entry_rowtype_label_id#</label>
		#Trim(onews_entry.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_D3657039340A4A2785961017F2952294"><em>*</em> #request.content.news_entry_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_D3657039340A4A2785961017F2952294" value="#Trim(onews_entry.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_67132B506EDE44468A12B7EF6C26A1DB"><em>*</em> #request.content.news_entry_rowtype_label_text#</label>
		<textarea name="text" id="formrow_67132B506EDE44468A12B7EF6C26A1DB">#Trim(onews_entry.gettext())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_67132B506EDE44468A12B7EF6C26A1DB = new FCKeditor('text');
				oFCKeditor_formrow_67132B506EDE44468A12B7EF6C26A1DB.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_67132B506EDE44468A12B7EF6C26A1DB.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_67132B506EDE44468A12B7EF6C26A1DB.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_67132B506EDE44468A12B7EF6C26A1DB.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(Trim(onews_entry.getdate()))>
		<cfset onews_entry.setdate(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_0374F34BBD004F838669AE3430418939">#request.content.news_entry_rowtype_label_date#</label>
		<div class="divInput" id="divDatePicker0374F34BBD004F838669AE3430418939"></div>
		<input type="hidden" name="date" id="formrow_0374F34BBD004F838669AE3430418939" value="#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker0374F34BBD004F838669AE3430418939 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_0374F34BBD004F838669AE3430418939').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker0374F34BBD004F838669AE3430418939.render('divDatePicker0374F34BBD004F838669AE3430418939');
				var dt0374F34BBD004F838669AE3430418939 = new Date();
				dt0374F34BBD004F838669AE3430418939 = Date.parseDate("#LsDateFormat(Trim(onews_entry.getdate()),'YYYY-MM-DD')# #LsTimeFormat(Trim(onews_entry.getdate()),'HH:MM')#","Y-m-d G:i");
				myDatePicker0374F34BBD004F838669AE3430418939.setValue(dt0374F34BBD004F838669AE3430418939);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_AFB74A46370D406CA448CCBEC71FE4DC">#request.content.news_entry_rowtype_label_mp3url#</label>
		<input type="text" class="textInput" name="mp3url" id="formrow_AFB74A46370D406CA448CCBEC71FE4DC" value="#Trim(onews_entry.getmp3url())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReluser = onews_entry.getuser().getid()>
	<div class="ctrlHolder">
		<label for="formrow_75A668A8F0F041FDA10B51B0522678B7">user</label>
		<select class="selectInput" name="author" id="formrow_75A668A8F0F041FDA10B51B0522678B7">
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
		<label for="formrow_40B43F436B0D41868D655163D886719C">news_entry_category</label>
		<select class="selectInput" name="news_entry_category" id="formrow_40B43F436B0D41868D655163D886719C" multiple="multiple" size="6">
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
