<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/act_logviewer.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfparam name="attributes.logfile" default="">

<cfdirectory action="list" directory="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/" name="qLogs" filter="*.log" sort="name ASC">

<cfif len(attributes.logfile) AND FileExists('#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#attributes.logfile#')>
	<cfcontent file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/logs/#attributes.logfile#" type="text/plain">
</cfif>

<cfsetting enablecfoutputonly="No">