<cfset otournament_type_se_match = application.lanshock.oFactory.load("tournament_type_se_match","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_type_se_match.setid(attributes.id)>
		<cfset otournament_type_se_match.load()>
	</cfif>
