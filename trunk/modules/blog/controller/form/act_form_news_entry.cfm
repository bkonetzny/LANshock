<cfset onews_entry = application.lanshock.oFactory.load("news_entry","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset onews_entry.setid(attributes.id)>
		<cfset onews_entry.load()>
	</cfif>
