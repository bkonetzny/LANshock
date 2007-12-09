<cfoutput>
	<div class="formrow">
		<div class="formrow_label">
			<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].label###</label>
		</div>
		<div class="formrow_input">
			<input type="text" name="#aFields[i].alias#" id="formrow_##idFormRow##" value="###Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")###"/>
		</div>
	</div>
</cfoutput>