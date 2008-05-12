<cfset onews_trackback = application.lanshock.oFactory.load("news_trackback","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset onews_trackback.setid(attributes.id)>
		<cfset onews_trackback.load()>
	</cfif>
