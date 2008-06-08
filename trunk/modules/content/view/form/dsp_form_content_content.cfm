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
	<input type="hidden" name="id" id="formrow_EFACE480B1E6499E847E3BC81ECED374" value="#ocontent_content.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_EFACE480B1E6499E847E3BC81ECED374">#request.content.content_content_rowtype_label_id#</label>
		#NumberFormat(ocontent_content.getid(),"9")#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_D1E0CF54079447109034A5A7D885B4C1"><em>*</em> #request.content.content_content_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_D1E0CF54079447109034A5A7D885B4C1" value="#Trim(ocontent_content.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_EAA52BDA827F40E0BF95C4AE29A214F9"><em>*</em> #request.content.content_content_rowtype_label_codename#</label>
		<input type="text" class="textInput" name="codename" id="formrow_EAA52BDA827F40E0BF95C4AE29A214F9" value="#Trim(ocontent_content.getcodename())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_FCE052D94CA7466D8AD151D169059E93"><em>*</em> #request.content.content_content_rowtype_label_content#</label>
		<textarea name="content" id="formrow_FCE052D94CA7466D8AD151D169059E93">#Trim(ocontent_content.getcontent())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_FCE052D94CA7466D8AD151D169059E93 = new FCKeditor('content');
				oFCKeditor_formrow_FCE052D94CA7466D8AD151D169059E93.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_FCE052D94CA7466D8AD151D169059E93.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_FCE052D94CA7466D8AD151D169059E93.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_FCE052D94CA7466D8AD151D169059E93.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="user_id" id="formrow_617876087D8A49829ECBBD6003F96E35" value="#NumberFormat(ocontent_content.getuser_id(),"9.99")#"/>
	<div class="ctrlHolder">
		<label for="formrow_617876087D8A49829ECBBD6003F96E35">#request.content.content_content_rowtype_label_user_id#</label>
		#NumberFormat(ocontent_content.getuser_id(),"9.99")#
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtcreated" id="formrow_828DE9893DE14DD2B6A26A3071BACB5C" value="#Trim(ocontent_content.getdtcreated())#"/>
	<div class="ctrlHolder">
		<label for="formrow_828DE9893DE14DD2B6A26A3071BACB5C">#request.content.content_content_rowtype_label_dtcreated#</label>
		#Trim(ocontent_content.getdtcreated())#
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtchanged" id="formrow_C5D5560FC20D4DD3801D70F007798578" value="#Trim(ocontent_content.getdtchanged())#"/>
	<div class="ctrlHolder">
		<label for="formrow_C5D5560FC20D4DD3801D70F007798578">#request.content.content_content_rowtype_label_dtchanged#</label>
		#Trim(ocontent_content.getdtchanged())#
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_DBC1FA1FDD284F4F80746E3E9A05DCC3" class="inlineLabel"><input type="checkbox" name="bactive" id="formrow_DBC1FA1FDD284F4F80746E3E9A05DCC3" value="1"<cfif ocontent_content.getbactive()> checked="checked"</cfif>/> <em>*</em>  #request.content.content_content_rowtype_label_bactive#</label>
		</div>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
		
			<fieldset class="inlineLabels">
				<legend>aManyToOne</legend>
		
			
				
				
				
				
					

	
	
		<div class="ctrlHolder">
			attributes.stFieldData.links[1].name is not defined!
		</div>
	
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
