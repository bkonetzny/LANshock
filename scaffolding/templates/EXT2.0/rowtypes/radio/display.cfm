<cfoutput>
	<div class="ctrlHolder">
		<p class="label"><cfif attributes.stFieldData.required><em>*</em> </cfif>##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</p>
		<cfif StructKeyExists(attributes.stFieldData,'parent')>
			#chr(60)#cfloop query="stRelated.#attributes.stFieldData.parent#.qData">
				<label for="formrow_#attributes.stFieldData.uuid#_##stRelated.#attributes.stFieldData.parent#.qData.optionvalue##" class="inlineLabel"><input type="radio" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#_##stRelated.#attributes.stFieldData.parent#.qData.optionvalue##" value="##stRelated.#attributes.stFieldData.parent#.qData.optionvalue##"#chr(60)#cfif o#caller.objectName#.get#attributes.stFieldData.alias#() EQ stRelated.#attributes.stFieldData.parent#.qData.optionvalue> checked="checked"#chr(60)#/cfif>/>##stRelated.#attributes.stFieldData.parent#.qData.optionname##</label>
			#chr(60)#/cfloop>
		<cfelse>
			#chr(60)#cfif isDefined("stRelated.#attributes.stFieldData.alias#_custom.qData")>
				#chr(60)#cfloop query="stRelated.#attributes.stFieldData.alias#_custom.qData">
					<label for="formrow_#attributes.stFieldData.uuid#_##stRelated.#attributes.stFieldData.alias#_custom.qData.optionvalue##" class="inlineLabel"><input type="radio" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#_##stRelated.#attributes.stFieldData.alias#_custom.qData.optionvalue##" value="##stRelated.#attributes.stFieldData.alias#_custom.qData.optionvalue##"#chr(60)#cfif o#caller.objectName#.get#attributes.stFieldData.alias#() EQ stRelated.#attributes.stFieldData.alias#_custom.qData.optionvalue> checked="checked"#chr(60)#/cfif>/>##stRelated.#attributes.stFieldData.alias#_custom.qData.optionname##</label>
				#chr(60)#/cfloop>
			#chr(60)#/cfif>
		</cfif>
	</div>
</cfoutput>