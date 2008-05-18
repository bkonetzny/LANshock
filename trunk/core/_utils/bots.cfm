<cfsetting enablecfoutputonly="Yes"> 
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/_utils/_pseudocode.cfm $
$LastChangedDate: 2007-11-20 13:53:48 +0100 (Di, 20 Nov 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 109 $
--->

<cfif ReFindNoCase("Googlebot",arguments.sUserAgent)
	OR ReFindNoCase("Yahoo! Slurp",arguments.sUserAgent)
	OR ReFindNoCase("msnbot",arguments.sUserAgent)
	OR ReFindNoCase("WebAlta Crawler",arguments.sUserAgent)
	OR ReFindNoCase("Exabot",arguments.sUserAgent)
	OR ReFindNoCase("Twiceler",arguments.sUserAgent)>
	<cfset bReturn = true>
</cfif>

<cfsetting enablecfoutputonly="No">