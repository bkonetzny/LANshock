<cfset ocore_configmanager = application.lanshock.oFactory.load("core_configmanager","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_configmanager.setmodule(attributes.module)>
		<cfset ocore_configmanager.load()>
	</cfif>
