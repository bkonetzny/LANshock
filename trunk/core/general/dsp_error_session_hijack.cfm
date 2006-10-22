<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.ip_session" default="">

<cfloop collection="#cookie#" item="idx">
	<cfcookie name="#idx#" expires="now">
</cfloop>
<cfloop collection="#session#" item="idx2">
	<cfset StructDelete(session,idx2)>
</cfloop>

<cffile action="append" file="#application.lanshock.environment.abspath#logs/core_general_sessionhijacking.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #attributes.ip_session# / #cgi.remote_addr#">

<cfoutput>
	<div class="headline">#request.content.session_hijack#</div>
	<div align="center">
		#request.content.session_hijack_txt#<br>&nbsp;<br>
		<strong>#attributes.ip_session# / #cgi.remote_addr#</strong>
	</div>
</cfoutput>

<cfsetting enablecfoutputonly="No">