<cfoutput>
	#chr(60)#cfset sRel#attributes.stFieldData.name# = o#caller.objectName#.get#attributes.stFieldData.name#().get#attributes.stFieldData.links[1].to#()>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#"><cfif attributes.stFieldData.required><em>*</em> </cfif>#attributes.stFieldData.name#<!--- ##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.name### ---></label>
		<select class="selectInput" name="#attributes.stFieldData.links[1].from#" id="formrow_#attributes.stFieldData.uuid#">
			<option value=""></option>
			#chr(60)#cfloop query="stRelated.stManyToOne.#attributes.stFieldData.name#.qData">
				<option value="##stRelated.stManyToOne.#attributes.stFieldData.name#.qData.optionvalue##"#chr(60)#cfif sRel#attributes.stFieldData.name# EQ stRelated.stManyToOne.#attributes.stFieldData.name#.qData.optionvalue> selected="selected"#chr(60)#/cfif>>##stRelated.stManyToOne.#attributes.stFieldData.name#.qData.optionname##</option>
			#chr(60)#/cfloop>
		</select>
	</div>
</cfoutput>