<cfoutput>
	#chr(60)#cfquery datasource="##request.lanshock.environment.datasource##" name="q#aFields[i].parent#">
		SELECT *
		FROM #aFields[i].parent#
	#chr(60)#/cfquery>
	<div class="formrow">
		<div class="formrow_label">
			<label for="formrow_##idFormRow##">##request.content.#objectName#_rowtype_label_#aFields[i].label###</label>
		</div>
		<div class="formrow_input">
			<select name="#aFields[i].alias#" id="formrow_##idFormRow##">
				<option value=""></option>
				#chr(60)#cfloop query="q#aFields[i].parent#">
					<option value="##q#aFields[i].parent#.#oMetaData.getPKListFromXML(aFields[i].parent)###"#chr(60)#cfif o#objectName#.get#aFields[i].alias#() EQ "##q#aFields[i].parent#.#oMetaData.getPKListFromXML(aFields[i].parent)###"> selected="selected"#chr(60)#/cfif>><cfloop list="#lJoinedFields#" index="thisField">##q#aFields[i].parent#.#thisField###</cfloop></option>
				#chr(60)#/cfloop>
			</select>
		</div>
	</div>
</cfoutput>