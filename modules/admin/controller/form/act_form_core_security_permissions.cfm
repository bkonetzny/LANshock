<cfset ocore_security_permissions = application.lanshock.oFactory.load("core_security_permissions","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_security_permissions.setid(attributes.id)>
		<cfset ocore_security_permissions.load()>
	</cfif>
