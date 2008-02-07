<cfoutput>
	<div class="ctrlHolder">
		<div>
			<label for="formrow_#attributes.stFieldData.uuid#" class="inlineLabel"><input type="checkbox" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" value="1"#chr(60)#cfif o#caller.objectName#.get#attributes.stFieldData.alias#()> checked="checked"#chr(60)#/cfif>/> ##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		</div>
	</div>
</cfoutput>