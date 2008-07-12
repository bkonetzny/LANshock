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
	<input type="hidden" name="id" id="formrow_EC997CDBB917410BAA2D551B8DD91910" value="#ocontent_content.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_EC997CDBB917410BAA2D551B8DD91910">#request.content.content_content_rowtype_label_id#</label>
		#Trim(ocontent_content.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_FC7C7539F65B42348E374AAF54E31E51"><em>*</em> #request.content.content_content_rowtype_label_codename#</label>
		<input type="text" class="textInput" name="codename" id="formrow_FC7C7539F65B42348E374AAF54E31E51" value="#Trim(ocontent_content.getcodename())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_6FF8B7F0BF5A44FC998908E4994FB8AC"><em>*</em> #request.content.content_content_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_6FF8B7F0BF5A44FC998908E4994FB8AC" value="#Trim(ocontent_content.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_DCDF207CDBEA47959F673A32A08EDCC6"><em>*</em> #request.content.content_content_rowtype_label_content#</label>
		<textarea name="content" id="formrow_DCDF207CDBEA47959F673A32A08EDCC6">#Trim(ocontent_content.getcontent())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_DCDF207CDBEA47959F673A32A08EDCC6 = new FCKeditor('content');
				oFCKeditor_formrow_DCDF207CDBEA47959F673A32A08EDCC6.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_DCDF207CDBEA47959F673A32A08EDCC6.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_DCDF207CDBEA47959F673A32A08EDCC6.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_DCDF207CDBEA47959F673A32A08EDCC6.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="user_id" id="formrow_7413DCCBC2804BEC978D7C4857C16A9A" value="#ocontent_content.getuser_id()#" />
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtcreated" id="formrow_D7DFE4CD7A4F4291B85853F5D5ECE6F2" value="#ocontent_content.getdtcreated()#" />
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtchanged" id="formrow_B5E3546F43514F13889588DBA4DE796C" value="#ocontent_content.getdtchanged()#" />
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_E284B3A196594B819993FE5D47ACFFEA" class="inlineLabel"><input type="checkbox" name="bactive" id="formrow_E284B3A196594B819993FE5D47ACFFEA" value="1"<cfif ocontent_content.getbactive()> checked="checked"</cfif>/> <em>*</em>  #request.content.content_content_rowtype_label_bactive#</label>
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
