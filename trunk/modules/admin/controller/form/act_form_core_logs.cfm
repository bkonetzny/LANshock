<cfset ocore_logs = application.lanshock.oFactory.load("core_logs","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_logs.setid(attributes.id)>
		<cfset ocore_logs.load()>
	</cfif>
