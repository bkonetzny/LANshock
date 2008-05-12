<cfset onews_entry_category = application.lanshock.oFactory.load("news_entry_category","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset onews_entry_category.setcategory_id(attributes.category_id)>
		<cfset onews_entry_category.load()>
	</cfif>
