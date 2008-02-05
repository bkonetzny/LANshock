<cfoutput>
	<div class="ctrlHolder">
		<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].alias###</label>
		<textarea name="#aFields[i].alias#" id="formrow_##idFormRow##">###Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")###</textarea>
	</div>
</cfoutput>