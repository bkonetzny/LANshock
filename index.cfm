<cfsetting enablecfoutputonly="Yes">
<!---
$copyright$

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$

$license$
--->

<cftry>
	<cfinclude template="core/lanshock.runtime.cfm">
	<cfset FUSEBOX_APPLICATION_PATH = "">
	<cfinclude template="fusebox/fusebox4.runtime.cfmx.cfm">

	<cfcatch>
		<cfparam name="request.lanshock.settings.debug.show_plain_error" default="false">
		<cfif request.lanshock.settings.debug.show_plain_error>
			<cfrethrow>
		<cfelse>
			<cfinclude template="core/_errorhandler.cfm">
		</cfif>
		<cfabort>
	</cfcatch>
</cftry>

<cfsetting enablecfoutputonly="No">