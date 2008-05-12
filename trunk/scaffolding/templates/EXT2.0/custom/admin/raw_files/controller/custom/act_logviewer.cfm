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

<cfif len(attributes.logfile) AND FileExists('#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#attributes.logfile#')>
	<cfcontent file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#attributes.logfile#" type="text/plain">
</cfif>

<cfdirectory action="list" directory="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/" name="qLogs" filter="*.log" sort="name ASC">

<cfquery name="qCoreLogs" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" maxrows="50">
	SELECT *
	FROM core_logs
	ORDER BY timestamp DESC
	<cfif application.lanshock.oRuntime.getEnvironment().sDatasourceType EQ 'mysql'>
		LIMIT 50
	</cfif>
</cfquery>

<cfsetting enablecfoutputonly="No">