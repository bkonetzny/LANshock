<cfset ocore_modules = application.lanshock.oFactory.load("core_modules","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		
		<cfset ocore_modules.setfolder(attributes.folder)>
		<cfset ocore_modules.load()>
	</cfif>
