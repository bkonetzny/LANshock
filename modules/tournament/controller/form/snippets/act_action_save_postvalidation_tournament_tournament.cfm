<cfif attributes.maxteams LTE 1>
	<cfset bHasErrors = true>
	<cfset ArrayAppend(aErrors,"tournament.maxteams.invalid")>
	<cfset ArrayAppend(aTranslatedErrors,"The maxteams must be higher than 1.")>
</cfif>

<cfif attributes.teamsize LTE 0>
	<cfset bHasErrors = true>
	<cfset ArrayAppend(aErrors,"tournament.teamsize.invalid")>
	<cfset ArrayAppend(aTranslatedErrors,"The teamsize must be higher than 0.")>
</cfif>

<cfif attributes.matchcount LTE 0>
	<cfset bHasErrors = true>
	<cfset ArrayAppend(aErrors,"tournament.matchcount.invalid")>
	<cfset ArrayAppend(aTranslatedErrors,"The match count must be higher than 0.")>
</cfif>