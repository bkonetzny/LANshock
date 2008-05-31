<cfset ocontent_content = application.lanshock.oFactory.load("content_content","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocontent_content.setid(attributes.id)>
		<cfset ocontent_content.load()>
	</cfif>
