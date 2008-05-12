<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_error_session_hijack.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfparam name="attributes.ip_session" default="">

<cfoutput>
	<h3>#request.content.session_hijack#</h3>
	<p>
		#request.content.session_hijack_txt#<br/>
		<strong>#attributes.ip_session# / #cgi.remote_addr#</strong>
	</p>
</cfoutput>

<cfsetting enablecfoutputonly="No">