<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#">##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		<input type="text" class="textInput" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" value="###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###"/>
	</div>
</cfoutput>