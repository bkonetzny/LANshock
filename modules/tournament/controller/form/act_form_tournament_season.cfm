<cfset otournament_season = application.lanshock.oFactory.load("tournament_season","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_season.setid(attributes.id)>
		<cfset otournament_season.load()>
	</cfif>
