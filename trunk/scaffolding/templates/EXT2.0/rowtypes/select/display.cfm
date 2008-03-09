<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#">##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<cfif StructKeyExists(attributes.stFieldData,'parent')>
			<select name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#">
				<option value=""></option>
				#chr(60)#cfloop query="stRelated.stManyToOne.#attributes.stFieldData.parent#.qData">
					<option value="##stRelated.stManyToOne.#attributes.stFieldData.parent#.qData.optionvalue##"#chr(60)#cfif o#caller.objectName#.get#attributes.stFieldData.alias#() EQ stRelated.stManyToOne.#attributes.stFieldData.parent#.qData.optionvalue> selected="selected"#chr(60)#/cfif>>##stRelated.stManyToOne.#attributes.stFieldData.parent#.qData.optionname##</option>
				#chr(60)#/cfloop>
			</select>
		<cfelse>
			#chr(60)#cfif isDefined("stRelated.#attributes.stFieldData.alias#_custom.qData")>
			<select name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#">
				<option value=""></option>
				#chr(60)#cfloop query="stRelated.#attributes.stFieldData.alias#_custom.qData">
					<option value="##stRelated.#attributes.stFieldData.alias#_custom.qData.optionvalue##"#chr(60)#cfif o#caller.objectName#.get#attributes.stFieldData.alias#() EQ stRelated.#attributes.stFieldData.alias#_custom.qData.optionvalue> selected="selected"#chr(60)#/cfif>>##stRelated.#attributes.stFieldData.alias#_custom.qData.optionname##</option>
				#chr(60)#/cfloop>
			</select>
			#chr(60)#/cfif>
		</cfif>
	</div>
</cfoutput>