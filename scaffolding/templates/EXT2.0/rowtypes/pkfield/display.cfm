<cfoutput>
	#chr(60)#cfif mode EQ "edit">
	<input type="hidden" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" value="##o#caller.objectName#.get#attributes.stFieldData.alias#()##" />
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#">##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###
	</div>
	#chr(60)#/cfif>
</cfoutput>