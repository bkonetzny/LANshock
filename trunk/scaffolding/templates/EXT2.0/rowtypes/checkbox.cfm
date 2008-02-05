<cfoutput>
	<div class="ctrlHolder">
		<div>
			<label for="formrow_##idFormRow##" class="inlineLabel"><input type="checkbox" name="#aFields[i].alias#" id="formrow_##idFormRow##" value="1"#chr(60)#cfif o#objectName#.get#aFields[i].alias#()> checked="checked"#chr(60)#/cfif>/> ##request.content.#objectName#_rowtype_label_#aFields[i].alias###</label>
		</div>
	</div>
</cfoutput>