<cfset otournament_group = application.lanshock.oFactory.load("tournament_group","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset otournament_group.setid(attributes.id)>
		<cfset otournament_group.load()>
	</cfif>
