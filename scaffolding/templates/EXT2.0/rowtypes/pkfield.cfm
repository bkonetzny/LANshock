<cfoutput>
	#chr(60)#cfif mode EQ "edit">
	<input type="hidden" name="#aFields[i].alias#" id="formrow_##idFormRow##" value="##o#objectName#.get#aFields[i].alias#()##" />
	<div class="ctrlHolder">
		<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].alias###</label>
		###Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")###
	</div>
	#chr(60)#/cfif>
</cfoutput>