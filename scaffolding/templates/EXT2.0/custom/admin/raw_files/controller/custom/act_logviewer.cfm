<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.logfile" default="">

<cfdirectory action="list" directory="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/" name="qLogs" filter="*.log" sort="name ASC">

<cfif len(attributes.logfile) AND FileExists('#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#attributes.logfile#')>
	<cfcontent file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#attributes.logfile#" type="text/plain">
</cfif>

<cfsetting enablecfoutputonly="No">