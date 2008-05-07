<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#"><cfif attributes.stFieldData.required><em>*</em> </cfif>##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<textarea name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#">###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###</textarea>
	</div>
</cfoutput>