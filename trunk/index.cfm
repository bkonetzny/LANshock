<cfsetting enablecfoutputonly="Yes">
<!-------------------------------------------------------------------------+
 | Copyright (C) 2002 - 2005 LANshock.com                                  |
 |                                                                         |
 | lastmodified: $Date: 2002-07-22 21:42:37 -0700 (Mon, 22 Jul 2002) $     |
 |           by: $Author: harry $                                          |
 |                               http://sourceforge.net/projects/lanshock/ |
 | Released Under the GNU General Public License (v2) (see license.txt)    |
 +------------------------------------------------------------------------->

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