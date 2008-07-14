<cfsetting enablecfoutputonly="Yes"> 
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif ReFindNoCase("Alexa Toolbar",arguments.sUserAgent)
	OR ReFindNoCase("Ask Jeeves",arguments.sUserAgent)
	OR ReFindNoCase("Exabot",arguments.sUserAgent)
	OR ReFindNoCase("Feedfetcher-Google",arguments.sUserAgent)
	OR ReFindNoCase("Gigabot",arguments.sUserAgent)
	OR ReFindNoCase("Googlebot",arguments.sUserAgent)
	OR ReFindNoCase("libwww",arguments.sUserAgent)
	OR ReFindNoCase("LinkWalker",arguments.sUserAgent)
	OR ReFindNoCase("msnbot",arguments.sUserAgent)
	OR ReFindNoCase("myWebbot",arguments.sUserAgent)
	OR ReFindNoCase("TurnitinBot",arguments.sUserAgent)
	OR ReFindNoCase("Twiceler",arguments.sUserAgent)
	OR ReFindNoCase("WebAlta Crawler",arguments.sUserAgent)
	OR ReFindNoCase("wget",arguments.sUserAgent)
	OR ReFindNoCase("Yahoo! Slurp",arguments.sUserAgent)>
	<cfset bReturn = true>
</cfif>

<cfsetting enablecfoutputonly="No">