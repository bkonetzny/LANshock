<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/admin/raw_files/controller/custom/act_logviewer.cfm $
$LastChangedDate: 2008-05-12 14:49:49 +0200 (Mo, 12 Mai 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 298 $
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