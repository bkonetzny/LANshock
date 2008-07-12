<cfif NOT LsIsDate(attributes.dtcreated)>
	<cfset attributes.dtcreated = now()>
</cfif>
<cfset attributes.dtchanged = now()>
<cfset attributes.user_id = session.oUser.getDataValue('userid')>