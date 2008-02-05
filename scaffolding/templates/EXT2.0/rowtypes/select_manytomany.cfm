<cfoutput>
	<cfif isDefined("stFields[idxRelation][i].links[1].name")>
		#chr(60)#cfset lRel#stFields[idxRelation][i].alias# = ocore_security_roles.get#stFields[idxRelation][i].alias#iterator().getValueList('#stFields[idxRelation][i].links[1].name#')>
		<div class="ctrlHolder">
			<label for="formrow_##idFormRow##">#stFields[idxRelation][i].alias#<!--- ##request.content.#objectName#_rowtype_label_#aFields[i].alias### ---></label>
			<select name="#stFields[idxRelation][i].alias#" id="formrow_##idFormRow##" multiple="true" size="6">
				<option value=""></option>
				#chr(60)#cfloop query="stRelated.stManyToMany.#stFields[idxRelation][i].alias#.qData">
					<option value="##stRelated.stManyToMany.#stFields[idxRelation][i].alias#.qData.optionvalue##"#chr(60)#cfif ListFind(lRel#stFields[idxRelation][i].alias#,stRelated.stManyToMany.#stFields[idxRelation][i].alias#.qData.optionvalue)> selected="selected"#chr(60)#/cfif>>##stRelated.stManyToMany.#stFields[idxRelation][i].alias#.qData.optionname##</option>
				#chr(60)#/cfloop>
			</select>
		</div>
	<cfelse>
		<div class="ctrlHolder">
			stFields[idxRelation][i].links[1].name is not defined!
		</div>
	</cfif>
</cfoutput>