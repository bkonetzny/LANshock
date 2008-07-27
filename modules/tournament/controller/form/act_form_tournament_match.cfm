<cfset otournament_match = application.lanshock.oFactory.load("tournament_match","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_match.setid(attributes.id)>
		<cfset otournament_match.load()>
	</cfif>
