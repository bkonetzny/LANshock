<cfsilent>
<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="ocontent_content">
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
<h3>#request.content.__globalmodule__navigation__content_content_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.content_content_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.content_content_grid_global_edit#</h4>
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
	<input type="hidden" name="id" id="formrow_D491265397334AC5AA860C3C87A07FB2" value="#ocontent_content.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_D491265397334AC5AA860C3C87A07FB2">#request.content.content_content_rowtype_label_id#</label>
		#Trim(ocontent_content.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_46FD0B94957340F993E9CEEA8EE8EDFB"><em>*</em> #request.content.content_content_rowtype_label_codename#</label>
		<input type="text" class="textInput" name="codename" id="formrow_46FD0B94957340F993E9CEEA8EE8EDFB" value="#Trim(ocontent_content.getcodename())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_23562DC72D484CBB96605803F34CE22B"><em>*</em> #request.content.content_content_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_23562DC72D484CBB96605803F34CE22B" value="#Trim(ocontent_content.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_E6475AC8C4A24E788CB352145FEF1166"><em>*</em> #request.content.content_content_rowtype_label_content#</label>
		<textarea name="content" id="formrow_E6475AC8C4A24E788CB352145FEF1166">#Trim(ocontent_content.getcontent())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_E6475AC8C4A24E788CB352145FEF1166 = new FCKeditor('content');
				oFCKeditor_formrow_E6475AC8C4A24E788CB352145FEF1166.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_E6475AC8C4A24E788CB352145FEF1166.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_E6475AC8C4A24E788CB352145FEF1166.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_E6475AC8C4A24E788CB352145FEF1166.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtcreated" id="formrow_B2994138529447F4B69C34A0C2DC62A7" value="#ocontent_content.getdtcreated()#" />
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtchanged" id="formrow_7CD80D91D6514794BA1F0E0C9BD55F67" value="#ocontent_content.getdtchanged()#" />
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_38FF644FAFC444BFBAEC051CFB21A3A4" class="inlineLabel"><input type="checkbox" name="bactive" id="formrow_38FF644FAFC444BFBAEC051CFB21A3A4" value="1"<cfif ocontent_content.getbactive()> checked="checked"</cfif>/> <em>*</em>  #request.content.content_content_rowtype_label_bactive#</label>
		</div>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	<cfset sReluser = ocontent_content.getuser().getid()>
	<div class="ctrlHolder">
		<label for="formrow_39E00CC339AA49EBB980D066F3E39E29">user</label>
		<select class="selectInput" name="user_id" id="formrow_39E00CC339AA49EBB980D066F3E39E29">
			<option value=""></option>
			<cfloop query="stRelated.stManyToOne.user.qData">
				<option value="#stRelated.stManyToOne.user.qData.optionvalue#"<cfif sReluser EQ stRelated.stManyToOne.user.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.user.qData.optionname#</option>
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
