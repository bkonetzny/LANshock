<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stNav = UDF_getNavigation()>

<cfoutput>
	<title><cfif len(request.lanshock.settings.appname)>#request.lanshock.settings.appname# -- </cfif>#stNav[myfusebox.thiscircuit].name#</title>
</cfoutput>

<cfinclude template="basic.header.inc.cfm">

<cfsetting enablecfoutputonly="No">