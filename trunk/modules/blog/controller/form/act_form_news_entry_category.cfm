<cfset onews_entry_category = application.lanshock.oFactory.load("news_entry_category","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset onews_entry_category.setid(attributes.id)>
		<cfset onews_entry_category.load()>
	</cfif>
