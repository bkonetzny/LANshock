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
<!--- Specify the list of fields to be displayed --->
<cfparam name="fieldlist" default="$$lFields$$" />
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
	<input type="hidden" name="lFields" value="#fieldlist#" />
	<input type="hidden" name="fuseaction" value="#XFA.save#" />
	
	<<cfloop list="aTable,aManyToOne,aManyToMany,aOneToMany" index="idxRelation">>
		<<cfif NOT ArrayIsEmpty(stFields[idxRelation])>>
		<fieldset class="inlineLabels">
		<legend>$$idxRelation$$</legend>
		<<cfif idxRelation EQ "aTable">>
			<<cftry>>
			<cfloop list="#fieldlist#" index="thisField">
				<cfset idFormRow = replace(CreateUUID(),'-','','ALL')>
				<cfswitch expression="#thisField#">
					<<cfloop from="1" to="$$ArrayLen(stFields[idxRelation])$$" index="i">>
						<<cfif stFields[idxRelation][i].showOnForm>>
							<cfcase value="$$stFields[idxRelation][i].alias$$">
								<<cfif ListFindNoCase(lPKFields,stFields[idxRelation][i].alias)>>
									<<cfinclude template="../templates/EXT2.0/rowtypes/pkfield.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Dropdown">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/select.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Radio">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/radio.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Datetime">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/datetime.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Checkbox">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/checkbox.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Text">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/text.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Textarea">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/textarea.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "FckEditor">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/fckeditor.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Hidden">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/hidden.cfm">>
								<<cfelseif stFields[idxRelation][i].formType IS "Display">>
									<<cfinclude template="../templates/EXT2.0/rowtypes/display.cfm">>
								<<cfelse>> 
									<<cfinclude template="../templates/EXT2.0/rowtypes/unknown.cfm">>
								<</cfif>>
							</cfcase>
						<</cfif>>
					<</cfloop>>
					<<cfloop from="1" to="$$ArrayLen(stFields[idxRelation])$$" index="i">>
						<<cfif NOT stFields[idxRelation][i].showOnForm>>
							<cfcase value="$$stFields[idxRelation][i].alias$$">
								<<cfinclude template="../templates/EXT2.0/rowtypes/hidden.cfm">>
							</cfcase>
						<</cfif>>
					<</cfloop>>
				</cfswitch>
			</cfloop>
				<<cfcatch>>
					<<cfdump var="$$stFields[idxRelation]$$">><<cfabort>>
				<</cfcatch>>
			<</cftry>>
		<<cfelseif idxRelation EQ "aManyToOne">>
			<<cfloop from="1" to="$$ArrayLen(stFields[idxRelation])$$" index="i">>
				<<cfinclude template="../templates/EXT2.0/rowtypes/select_manytomany.cfm">>
			<</cfloop>>
		<<cfelseif idxRelation EQ "aManyToMany">>
			<<cfloop from="1" to="$$ArrayLen(stFields[idxRelation])$$" index="i">>
				<<cfinclude template="../templates/EXT2.0/rowtypes/select_manytomany.cfm">>
			<</cfloop>>
		<<cfelseif idxRelation EQ "aOneToMany">>
			<<cfloop from="1" to="$$ArrayLen(stFields[idxRelation])$$" index="i">>
				<<cfinclude template="../templates/EXT2.0/rowtypes/select_manytomany.cfm">>
			<</cfloop>>
		<</cfif>>
		</fieldset>
		<</cfif>>
	<</cfloop>>
	
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