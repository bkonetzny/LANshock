<cfset otournament_type_se_result = application.lanshock.oFactory.load("tournament_type_se_result","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_type_se_result.setid(attributes.id)>
		<cfset otournament_type_se_result.load()>
	</cfif>
