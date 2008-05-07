<cfoutput>
	#chr(60)#cfif NOT StructKeyExists(attributes,'#caller.aFields[caller.i].alias#')>
		#chr(60)#cfset attributes.#caller.aFields[caller.i].alias# = ''>
	#chr(60)#/cfif>
</cfoutput>