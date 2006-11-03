<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cftry>
	<cfinclude template="core/lanshock.runtime.cfm">
	<cfinclude template="fusebox5/fusebox5.cfm">
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