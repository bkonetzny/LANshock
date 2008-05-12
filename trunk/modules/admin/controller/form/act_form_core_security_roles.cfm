<cfset ocore_security_roles = application.lanshock.oFactory.load("core_security_roles","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_security_roles.setid(attributes.id)>
		<cfset ocore_security_roles.load()>
	</cfif>
