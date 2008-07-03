<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset application.lanshock.oLogger.writeLog('core.http404','UserAgent: "#cgi.http_user_agent#"','error')>

<cfheader statuscode="404">
<cfoutput>
	<h3>404 - Page Not Found</h3>
	<p>The Page you are looking for was not found.</p>
</cfoutput>

<cfsetting enablecfoutputonly="No">