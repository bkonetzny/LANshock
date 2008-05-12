<cfset onews_ping_url = application.lanshock.oFactory.load("news_ping_url","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset onews_ping_url.setid(attributes.id)>
		<cfset onews_ping_url.load()>
	</cfif>
