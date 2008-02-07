<cfsilent>
	<cfset optionValues = ListWrap(oMetaData.getPKListFromXML(aFields[i].parent),"##q#attributes.stFieldData.parent#.","##","_")>
</cfsilent>

<cfoutput>
	<div class="ctrlHolder">
		<p class="label">##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</p>
		<cfloop query="q#attributes.stFieldData.parent#">
			<label for="formrow_#attributes.stFieldData.uuid#_#optionValues#" class="inlineLabel"><input type="radio" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#_#optionValues#" value="#optionValues#"#chr(60)#cfif o#caller.objectName#.get#attributes.stFieldData.alias#() EQ "#optionValues#"> checked="checked"</cfif>/><cfloop list="#lJoinedFields#" index="thisField">##q#attributes.stFieldData.parent#.#thisField###</cfloop></label>
		</cfloop>
	</div>
</cfoutput>