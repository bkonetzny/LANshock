<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#"><cfif attributes.stFieldData.required><em>*</em> </cfif>##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<input type="file" class="fileUpload" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#"/>
	</div>
</cfoutput>