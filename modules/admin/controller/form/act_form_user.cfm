<cfset ouser = application.lanshock.oFactory.load("user","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ouser.setid(attributes.id)>
		<cfset ouser.load()>
	</cfif>
