<cfset ocore_navigation = application.lanshock.oFactory.load("core_navigation","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_navigation.setaction(attributes.action)>
		<cfset ocore_navigation.load()>
	</cfif>
