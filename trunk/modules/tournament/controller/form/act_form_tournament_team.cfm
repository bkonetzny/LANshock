<cfset otournament_team = application.lanshock.oFactory.load("tournament_team","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_team.setid(attributes.id)>
		<cfset otournament_team.load()>
	</cfif>
