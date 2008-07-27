<cfset otournament_ranking = application.lanshock.oFactory.load("tournament_ranking","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_ranking.setid(attributes.id)>
		<cfset otournament_ranking.load()>
	</cfif>
