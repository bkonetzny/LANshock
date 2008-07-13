<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<cfset stFields.aTable = oMetaData.getFieldsFromXML(objectName)>>
<<cfset stFields.aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfset stFields.aManyToMany = oMetaData.getRelationshipsFromXML(objectName,"manyToMany")>>
<<cfset stFields.aOneToMany = oMetaData.getRelationshipsFromXML(objectName,"oneToMany")>>
<<cfset lExcludeFields = ''>>
<<cfloop from="1" to="$$ArrayLen(stFields.aManyToOne)$$" index="idx">>
	<<cfset lExcludeFields = ListAppend(lExcludeFields,stFields.aManyToOne[idx].links[1].from)>>
<</cfloop>>
<<cfloop from="$$ArrayLen(stFields.aTable)$$" to="1" step="-1" index="idx">>
	<<cfif ListFind(lExcludeFields,stFields.aTable[idx].name)>>
		<<cfset ArrayDeleteAt(stFields.aTable,idx)>>
	<</cfif>>
<</cfloop>>
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
	function validate(){
		$('##btnSave').attr('disabled','disabled');
		return true;
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
	
	<<cfinclude template="../templates/EXT2.0/includes/form_structure.cfm">>
	
	<<cfif fileExists(expandPath('modules/$$sModule$$/scaffolding/view/form/dsp_form.$$objectName$$.form_structures.fields.cfm'))
			AND fileExists(expandPath('modules/$$sModule$$/scaffolding/view/form/dsp_form.$$objectName$$.form_structures.mover.cfm'))>>
		<<cfinclude template="../../modules/$$sModule$$/scaffolding/view/form/dsp_form.$$objectName$$.form_structures.fields.cfm">>
		<<cfinclude template="../templates/EXT2.0/includes/form_structure_mover.cfm">>
		<<cfinclude template="../../modules/$$sModule$$/scaffolding/view/form/dsp_form.$$objectName$$.form_structures.mover.cfm">>
	<</cfif>>
	
	<<cfinclude template="../templates/EXT2.0/includes/form_layout.cfm">>
	
	<div class="buttonHolder">
		<button type="submit" class="submitButton" id="btnSave">#request.content.form_save#</button>
		<button type="reset" class="resetButton" id="btnReset">#request.content.form_reset#</button>
		<button type="cancel" class="cancelButton" id="btnCancel" onclick="javascript:location.href='#self#?fuseaction=#XFA.cancel#&_listSortByFieldList=#attributes._listSortByFieldList#&_Maxrows=#attributes._Maxrows#&_StartRow=#attributes._Startrow#';return false;">#request.content.form_cancel#</button>
	</div>
</form>
</cfoutput>
<</cfoutput>>