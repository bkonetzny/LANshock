<cfset otournament_tournament = application.lanshock.oFactory.load("tournament_tournament","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_tournament.setid(attributes.id)>
		<cfset otournament_tournament.load()>
	</cfif>
