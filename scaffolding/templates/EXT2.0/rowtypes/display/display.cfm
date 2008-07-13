<cfoutput>
	#chr(60)#cfset sValue = #caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")#>
	<input type="hidden" name="#attributes.stFieldData.alias#" id="formrow_#attributes.stFieldData.uuid#" value="###caller.Format("o#caller.objectName#.get#attributes.stFieldData.alias#()","#attributes.stFieldData.format#")###"/>
	<div class="ctrlHolder">
		<label for="formrow_#attributes.stFieldData.uuid#">##request.content.#caller.objectName#_rowtype_label_#attributes.stFieldData.alias###</label>
		#chr(60)#cfif LsIsDate(sValue)>
			##session.oUser.DateTimeFormat(sValue)##
		#chr(60)#cfelse>
			##sValue##
		#chr(60)#/cfif>
	</div>
</cfoutput>