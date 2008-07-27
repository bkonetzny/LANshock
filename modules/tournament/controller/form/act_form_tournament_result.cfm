<cfset otournament_result = application.lanshock.oFactory.load("tournament_result","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_result.setid(attributes.id)>
		<cfset otournament_result.load()>
	</cfif>
