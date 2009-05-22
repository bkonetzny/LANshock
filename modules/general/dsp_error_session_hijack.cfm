<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.ip_session" default="">

<cfoutput>
	<h3>#request.content.session_hijack#</h3>
	<p>
		#request.content.session_hijack_txt#<br/>
		<strong>#attributes.ip_session# / #cgi.remote_addr#</strong>
	</p>
</cfoutput>

<cfsetting enablecfoutputonly="false">