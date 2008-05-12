<cfset ocore_security_users_roles_rel = application.lanshock.oFactory.load("core_security_users_roles_rel","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_security_users_roles_rel.setuser_id(attributes.user_id)>
		<cfset ocore_security_users_roles_rel.load()>
	</cfif>
