<cfset otournament_player = application.lanshock.oFactory.load("tournament_player","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_player.setid(attributes.id)>
		<cfset otournament_player.load()>
	</cfif>
