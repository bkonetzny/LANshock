<cfset otournament_type_se_ranking = application.lanshock.oFactory.load("tournament_type_se_ranking","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_type_se_ranking.setid(attributes.id)>
		<cfset otournament_type_se_ranking.load()>
	</cfif>
