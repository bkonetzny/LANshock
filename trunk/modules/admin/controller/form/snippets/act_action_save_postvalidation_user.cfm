<cfset qEmailLookup = application.lanshock.oFactory.load('user','reactorGateway').getByFields(email=attributes.email)>

<cfif qEmailLookup.recordcount AND ((StructKeyExists(attributes,'id') AND qEmailLookup.id NEQ attributes.id) OR NOT StructKeyExists(attributes,'id'))>
	<cfset bHasErrors = true>
	<cfset ArrayAppend(aErrors,"user.email.duplicateEntry")>
	<cfset ArrayAppend(aTranslatedErrors,"Email duplicate")>
</cfif>