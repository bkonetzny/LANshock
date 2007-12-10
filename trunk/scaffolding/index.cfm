<cfif NOT isDefined("form.scaffolding_go")>
	<cfparam name="url.scaffolding_go" default="display">
</cfif>
<cfinclude template="/scaffolder/manager.cfm">