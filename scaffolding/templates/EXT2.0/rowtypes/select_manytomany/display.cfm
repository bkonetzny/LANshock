<cfoutput>
	<cfif isDefined("attributes.stFieldData.links[1].name")>
		#chr(60)#cfset lRel#attributes.stFieldData.alias# = o#caller.objectName#.get#attributes.stFieldData.alias#iterator().getValueList('#attributes.stFieldData.links[1].name#')>
		<div class="ctrlHolder">
			<label for="formrow_#attributes.stFieldData.uuid#">#attributes.stFieldData.alias#<!--- ##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias### ---></label>
			<select name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" multiple="true" size="6">
				<option value=""></option>
				#chr(60)#cfloop query="stRelated.stManyToMany.#attributes.stFieldData.alias#.qData">
					<option value="##stRelated.stManyToMany.#attributes.stFieldData.alias#.qData.optionvalue##"#chr(60)#cfif ListFind(lRel#attributes.stFieldData.alias#,stRelated.stManyToMany.#attributes.stFieldData.alias#.qData.optionvalue)> selected="selected"#chr(60)#/cfif>>##stRelated.stManyToMany.#attributes.stFieldData.alias#.qData.optionname##</option>
				#chr(60)#/cfloop>
			</select>
		</div>
	<cfelse>
		<div class="ctrlHolder">
			attributes.stFieldData.links[1].name is not defined!
		</div>
	</cfif>
</cfoutput>