<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfquery datasource="#application.lanshock.environment.datasource#">
	#PreserveSingleQuotes(stLocal.sSqlCode)#
</cfquery>

<cfsetting enablecfoutputonly="No">