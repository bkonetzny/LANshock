<<cfset sModule = oMetaData.getModule()>>
<<cfif fileExists("../templates/EXT2.0/custom/$$sModule$$/raw_files/controller/custom_settings.cfm")>>
	<cfinclude template="custom_settings.cfm">
<</cfif>>