<cfif NOT isDefined("form.scaffolding.go")>
	<cfparam name="url.scaffolding_go" default="display">
</cfif>
<cfinclude template="/scaffolder/manager.cfm">