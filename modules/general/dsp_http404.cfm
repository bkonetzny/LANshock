<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_error.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfset application.lanshock.oLogger.writeLog('core.http404','UserAgent: "#cgi.http_user_agent#"','error')>

<cfheader statuscode="404">
<cfoutput>
	<h4>404 - Page Not Found</h4>
	<p>The Page you are looking for was not found.</p>
</cfoutput>

<cfsetting enablecfoutputonly="No">