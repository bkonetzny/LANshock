<cfoutput>
	#chr(60)#cfif NOT len(trim(attributes.#caller.aFields[caller.i].alias#))>
		#chr(60)#cfset attributes.#caller.aFields[caller.i].alias# = attributes.#caller.aFields[caller.i].alias#__hidden>
	#chr(60)#cfelse>
		#chr(60)#cfset attributes.#caller.aFields[caller.i].alias# = hash(attributes.#caller.aFields[caller.i].alias#)>
	#chr(60)#/cfif>
</cfoutput>