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
	<input type="hidden" name="id" id="formrow_92B951BFE49842C7AA91F229DC72251A" value="#ocontent_content.getid()#" />
	<div class="ctrlHolder">
		<label for="formrow_92B951BFE49842C7AA91F229DC72251A">#request.content.content_content_rowtype_label_id#</label>
		#NumberFormat(ocontent_content.getid(),"9")#
	</div>
	</cfif>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C3F6F24C84FA4F6981EEB4717C040ACC"><em>*</em> #request.content.content_content_rowtype_label_title#</label>
		<input type="text" class="textInput" name="title" id="formrow_C3F6F24C84FA4F6981EEB4717C040ACC" value="#Trim(ocontent_content.gettitle())#"/>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_662C4864AEA349CEB499375E2726A509"><em>*</em> #request.content.content_content_rowtype_label_content#</label>
		<textarea name="content" id="formrow_662C4864AEA349CEB499375E2726A509">#Trim(ocontent_content.getcontent())#</textarea>
			<script type="text/javascript">
			<!--
				var sBasePath = "#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/js/";
				var oFCKeditor_formrow_662C4864AEA349CEB499375E2726A509 = new FCKeditor('content');
				oFCKeditor_formrow_662C4864AEA349CEB499375E2726A509.BasePath = sBasePath + "fckeditor/";
				oFCKeditor_formrow_662C4864AEA349CEB499375E2726A509.Config['CustomConfigurationsPath'] = sBasePath + "lanshock_fckeditor_config.js";
				oFCKeditor_formrow_662C4864AEA349CEB499375E2726A509.Value = '';
				Ext.onReady(function(){
					oFCKeditor_formrow_662C4864AEA349CEB499375E2726A509.ReplaceTextarea();
				});
			//-->
			</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_EAF265951A644CBAA32D609E4AE8D4B9"><em>*</em> #request.content.content_content_rowtype_label_user_id#</label>
		
			<select class="selectInput" name="user_id" id="formrow_EAF265951A644CBAA32D609E4AE8D4B9">
				<option value=""></option>
				<cfloop query="stRelated.stManyToOne.user.qData">
					<option value="#stRelated.stManyToOne.user.qData.optionvalue#"<cfif ocontent_content.getuser_id() EQ stRelated.stManyToOne.user.qData.optionvalue> selected="selected"</cfif>>#stRelated.stManyToOne.user.qData.optionname#</option>
				</cfloop>
			</select>
		
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(LSDateFormat(ocontent_content.getdtcreated()))>
		<cfset ocontent_content.setdtcreated(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_89FBB796B13C4F5984B5330FC5522CB5">#request.content.content_content_rowtype_label_dtcreated#</label>
		<div class="divInput" id="divDatePicker89FBB796B13C4F5984B5330FC5522CB5"></div>
		<input type="hidden" name="dtcreated" id="formrow_89FBB796B13C4F5984B5330FC5522CB5" value="#LsDateFormat(LSDateFormat(ocontent_content.getdtcreated()),'YYYY-MM-DD')# #LsTimeFormat(LSDateFormat(ocontent_content.getdtcreated()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker89FBB796B13C4F5984B5330FC5522CB5 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_89FBB796B13C4F5984B5330FC5522CB5').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker89FBB796B13C4F5984B5330FC5522CB5.render('divDatePicker89FBB796B13C4F5984B5330FC5522CB5');
				var dt89FBB796B13C4F5984B5330FC5522CB5 = new Date();
				dt89FBB796B13C4F5984B5330FC5522CB5 = Date.parseDate("#LsDateFormat(LSDateFormat(ocontent_content.getdtcreated()),'YYYY-MM-DD')# #LsTimeFormat(LSDateFormat(ocontent_content.getdtcreated()),'HH:MM')#","Y-m-d G:i");
				myDatePicker89FBB796B13C4F5984B5330FC5522CB5.setValue(dt89FBB796B13C4F5984B5330FC5522CB5);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<cfif NOT isDate(LSDateFormat(ocontent_content.getdtchanged()))>
		<cfset ocontent_content.setdtchanged(now())>
	</cfif>
	<div class="ctrlHolder">
		<label for="formrow_3FADDF8C6D114E71BDACABD7230D5A86">#request.content.content_content_rowtype_label_dtchanged#</label>
		<div class="divInput" id="divDatePicker3FADDF8C6D114E71BDACABD7230D5A86"></div>
		<input type="hidden" name="dtchanged" id="formrow_3FADDF8C6D114E71BDACABD7230D5A86" value="#LsDateFormat(LSDateFormat(ocontent_content.getdtchanged()),'YYYY-MM-DD')# #LsTimeFormat(LSDateFormat(ocontent_content.getdtchanged()),'HH:MM:SS')#"/>
		<script type="text/javascript">
			<!--
			var myDatePicker3FADDF8C6D114E71BDACABD7230D5A86 = new Ext.ux.form.DateTime({
				handler: function(value){
					$('##formrow_3FADDF8C6D114E71BDACABD7230D5A86').val(value);
				}
			});
			Ext.onReady(function(){
				myDatePicker3FADDF8C6D114E71BDACABD7230D5A86.render('divDatePicker3FADDF8C6D114E71BDACABD7230D5A86');
				var dt3FADDF8C6D114E71BDACABD7230D5A86 = new Date();
				dt3FADDF8C6D114E71BDACABD7230D5A86 = Date.parseDate("#LsDateFormat(LSDateFormat(ocontent_content.getdtchanged()),'YYYY-MM-DD')# #LsTimeFormat(LSDateFormat(ocontent_content.getdtchanged()),'HH:MM')#","Y-m-d G:i");
				myDatePicker3FADDF8C6D114E71BDACABD7230D5A86.setValue(dt3FADDF8C6D114E71BDACABD7230D5A86);
			});
			//-->
		</script>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<div>
			<label for="formrow_9C18EF09750F48F0965A5351942FBB7E" class="inlineLabel"><input type="checkbox" name="bactive" id="formrow_9C18EF09750F48F0965A5351942FBB7E" value="1"<cfif ocontent_content.getbactive()> checked="checked"</cfif>/> <em>*</em>  #request.content.content_content_rowtype_label_bactive#</label>
		</div>
	</div>
				
			
			
				
				
				
				
					

	
	<div class="ctrlHolder">
		<label for="formrow_C45CFE927B6D444086F8BEF0D172B1D4"><em>*</em> #request.content.content_content_rowtype_label_codename#</label>
		<input type="text" class="textInput" name="codename" id="formrow_C45CFE927B6D444086F8BEF0D172B1D4" value="#Trim(ocontent_content.getcodename())#"/>
	</div>
				
			
			
		
			</fieldset>
		
	
	
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
