<cfset ocore_cron = application.lanshock.oFactory.load("core_cron","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_cron.setid(attributes.id)>
		<cfset ocore_cron.load()>
	</cfif>
