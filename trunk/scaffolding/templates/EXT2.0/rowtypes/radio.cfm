<cfsilent>
	<cfset optionValues = ListWrap(oMetaData.getPKListFromXML(aFields[i].parent),"##q#aFields[i].parent#.","##","_")>
</cfsilent>

<cfoutput>
	<div class="formrow">
		<div class="formrow_label">
			<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].label###</label>
		</div>
		<div class="formrow_input">
			<cfloop query="q#aFields[i].parent#">
				<input type="radio" name="#aFields[i].alias#" id="formrow_##idFormRow##_#optionValues#" value="#optionValues#"#chr(60)#cfif o#objectName#.get#aFields[i].alias#() EQ "#optionValues#"> checked="checked"</cfif>/><cfloop list="#lJoinedFields#" index="thisField">##q#aFields[i].parent#.#thisField###</cfloop><br />
			</cfloop>
		</div>
	</div>
</cfoutput>