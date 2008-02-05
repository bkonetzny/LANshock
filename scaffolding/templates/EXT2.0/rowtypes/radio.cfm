<cfsilent>
	<cfset optionValues = ListWrap(oMetaData.getPKListFromXML(aFields[i].parent),"##q#aFields[i].parent#.","##","_")>
</cfsilent>

<cfoutput>
	<div class="ctrlHolder">
		<p class="label">##request.content.#objectName#_rowtype_label_#aFields[i].alias###</p>
		<cfloop query="q#aFields[i].parent#">
			<label for="formrow_##idFormRow##_#optionValues#" class="inlineLabel"><input type="radio" name="#aFields[i].alias#" id="formrow_##idFormRow##_#optionValues#" value="#optionValues#"#chr(60)#cfif o#objectName#.get#aFields[i].alias#() EQ "#optionValues#"> checked="checked"</cfif>/><cfloop list="#lJoinedFields#" index="thisField">##q#aFields[i].parent#.#thisField###</cfloop></label>
		</cfloop>
	</div>
</cfoutput>