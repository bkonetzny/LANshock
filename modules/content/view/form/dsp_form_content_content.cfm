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
	<input type="hidden" name="id" id="formrow_9219E79E55054E5981DE6AC4E4326910" value="#ocontent_content.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_9219E79E55054E5981DE6AC4E4326910">#request.content.content_content_rowtype_label_id#</label>
		#Trim(ocontent_content.getid())#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_0EA3488F76ED4CF995C54DF41AED4F7A"><em>*</em> #request.content.content_content_rowtype_label_codename#</label>
		<input type="text" class="textInput" name="codename" id="formrow_0EA3488F76ED4CF995C54DF41AED4F7A" value="#Trim(ocontent_content.getcodename())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_97ACC7851D164727B58385F8A4D55296"><em>*</em> #request.content.content_content_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_97ACC7851D164727B58385F8A4D55296" value="#Trim(ocontent_content.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_7946783C875443A0AD417FADAE1863D2"><em>*</em> #request.content.content_content_rowtype_label_content#</label>
		<textarea name="content" id="formrow_7946783C875443A0AD417FADAE1863D2">#Trim(ocontent_content.getcontent())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_7946783C875443A0AD417FADAE1863D2 = new FCKeditor('content');
				oFCKeditor_formrow_7946783C875443A0AD417FADAE1863D2.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_7946783C875443A0AD417FADAE1863D2.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_7946783C875443A0AD417FADAE1863D2.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_7946783C875443A0AD417FADAE1863D2.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="user_id" id="formrow_B8C211EE3A544BC696553AA1E6602CCF" value="#ocontent_content.getuser_id()#" />
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtcreated" id="formrow_B9163198C7354456BD5C0D0A1C05E482" value="#ocontent_content.getdtcreated()#" />
				
			
			
				
				
				
				
					

	
	<input type="hidden" name="dtchanged" id="formrow_AFFB1E99D5BF4450BC9D7EEA7A54EDF3" value="#ocontent_content.getdtchanged()#" />
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_320F308A571D4A0AABE326F3DC44F29E" class="inlineLabel"><input type="checkbox" name="bactive" id="formrow_320F308A571D4A0AABE326F3DC44F29E" value="1"<cfif ocontent_content.getbactive()> checked="checked"</cfif>/> <em>*</em>  #request.content.content_content_rowtype_label_bactive#</label>
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
