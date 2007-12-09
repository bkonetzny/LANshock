<cfoutput>
	<div class="formrow">
		<div class="formrow_label">
			<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].label###</label>
		</div>
		<div class="formrow_input">
			<input type="checkbox" name="#aFields[i].alias#" id="formrow_##idFormRow##" value="1"#chr(60)#cfif o#objectName#.get#aFields[i].alias#()> checked="checked"#chr(60)#/cfif>/>
		</div>
	</div>
</cfoutput>