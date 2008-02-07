<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<cfset stFields.aTable = oMetaData.getFieldsFromXML(objectName)>>
<<cfset stFields.aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfset stFields.aManyToMany = oMetaData.getRelationshipsFromXML(objectName,"manyToMany")>>
<<cfset stFields.aOneToMany = oMetaData.getRelationshipsFromXML(objectName,"oneToMany")>>
<<cfoutput>>
<cfsilent>

<!--- URL parameters so that we can return to the same position in the list. --->
<cfparam name="attributes._Startrow" default="1">
<cfparam name="attributes._Maxrows" default="10">
<cfparam name="attributes._listSortByFieldList" default="">
<!--- XFAs are required to specify the links to other pages --->
<cfparam name="XFA.save">
<cfparam name="XFA.cancel">
<!--- The object being edited or added --->
<cfparam name="o$$objectName$$">
<!--- This parameter specifies if we are to use Search Safe URLs or not --->
<cfparam name="request.searchSafe" default="false">
</cfsilent>

<cfoutput>
<script type="text/javascript">
<!--
	function reset(myform){
		myform.reset();
	};

	function save(myform, XFA){
		document.getElementById("btnSave").disabled=true;
		myform.fuseaction.value = XFA;
		myform.submit();
	};
//-->
</script>

<h3>#request.content.__globalmodule__navigation__$$objectName$$_Listing#</h3>
<cfif ListLast(XFA.save,'_') EQ 'Add'>
	<h4>#request.content.$$objectName$$_grid_global_add#</h4>
<cfelse>
	<h4>#request.content.$$objectName$$_grid_global_edit#</h4>
</cfif>

<cfif isDefined("aTranslatedErrors") AND ArrayLen(aTranslatedErrors)>
	<div class="errorBox">
		#request.content.error#
		<ul>
			<cfloop index="i" from="1" to="#arrayLen(aTranslatedErrors)#">
				<li>#aTranslatedErrors[i]#</li>
			</cfloop>
		</ul>
	</div>
</cfif>

<!--- Start of the form --->
<form name="frmAddEdit" action="#self#" method="post" class="uniForm">		
	<input type="hidden" name="_listSortByFieldList" value="#attributes._listSortByFieldList#" />
	<input type="hidden" name="_Maxrows" value="#attributes._Maxrows#" />
	<input type="hidden" name="_StartRow" value="#attributes._StartRow#" />
	<input type="hidden" name="fuseaction" value="#XFA.save#" />
	
	<<cfinclude template="../templates/EXT2.0/includes/form_structure.cfm">>
	
	<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/view/dsp_form.$$objectName$$.form_structures.fields.cfm")
			AND fileExists("../templates/EXT2.0/custom/$$sModule$$/view/dsp_form.$$objectName$$.form_structures.mover.cfm")>>
		<<cfinclude template="../templates/EXT2.0/custom/$$sModule$$/view/dsp_form.$$objectName$$.form_structures.fields.cfm">>
		<<cfinclude template="../templates/EXT2.0/includes/form_structure_mover.cfm">>
		<<cfinclude template="../templates/EXT2.0/custom/$$sModule$$/view/dsp_form.$$objectName$$.form_structures.mover.cfm">>
	<</cfif>>
	
	<<cfinclude template="../templates/EXT2.0/includes/form_layout.cfm">>
	
	<div class="buttonHolder">
		<cfset sortParams = appendParam("","_listSortByFieldList",attributes._listSortByFieldList)>
		<cfset sortParams = appendParam(sortParams,"_Maxrows",attributes._Maxrows)>
		<cfset sortParams = appendParam(sortParams,"_StartRow",attributes._Startrow)>
		<cfset sortParams = appendParam(sortParams,"fuseaction",XFA.cancel)>
		<button type="submit" class="submitButton" id="btnSave" onclick="javascript:save(this.form,'#XFA.Save#');">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset" onclick="javascript:reset(this.form);">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self##sortParams#';">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
<</cfoutput>>