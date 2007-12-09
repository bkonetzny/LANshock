<cfoutput>
	<input type="hidden" name="#aFields[i].alias#" id="formrow_##idFormRow##" value="##o#objectName#.get#aFields[i].alias#()##" />
	#chr(60)#cfif mode EQ "edit">
		<div class="formrow">
			<div class="formrow_label">
				##request.content.#objectName#_rowtype_label_#aFields[i].label###
			</div>
			<div class="formrow_input">
				###Format("o#objectName#.get#aFields[i].alias#()","#aFields[i].format#")###
			</div>
		</div>
	#chr(60)#/cfif>
</cfoutput>