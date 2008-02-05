<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].alias###</label>
		<cfif StructKeyExists(aFields[i],'parent')>
			<select name="#aFields[i].alias#" id="formrow_##idFormRow##">
				<option value=""></option>
				#chr(60)#cfloop query="stRelated.#aFields[i].parent#.qData">
					<option value="##stRelated.#aFields[i].parent#.qData.optionvalue##"#chr(60)#cfif o#objectName#.get#aFields[i].alias#() EQ stRelated.#aFields[i].parent#.qData.optionvalue> selected="selected"#chr(60)#/cfif>>##stRelated.#aFields[i].parent#.qData.optionname##</option>
				#chr(60)#/cfloop>
			</select>
		<cfelse>
			Error: Key 'parent' doesn't exist:
			<cfdump var="#aFields[i]#"><cfabort>
		</cfif>
	</div>
</cfoutput>