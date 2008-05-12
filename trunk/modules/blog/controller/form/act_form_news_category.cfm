<cfset onews_category = application.lanshock.oFactory.load("news_category","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset onews_category.setid(attributes.id)>
		<cfset onews_category.load()>
	</cfif>
