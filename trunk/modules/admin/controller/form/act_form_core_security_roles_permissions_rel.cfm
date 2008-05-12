<cfset ocore_security_roles_permissions_rel = application.lanshock.oFactory.load("core_security_roles_permissions_rel","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_security_roles_permissions_rel.setid(attributes.id)>
		<cfset ocore_security_roles_permissions_rel.load()>
	</cfif>
