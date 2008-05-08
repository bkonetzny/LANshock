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

<cfloop collection="#cookie#" item="idx">
	<cfcookie name="#idx#" expires="now">
</cfloop>
<cfloop collection="#session#" item="idx2">
	<cfset StructDelete(session,idx2)>
</cfloop>

<cffile action="append" file="#application.lanshock.oRuntime.getEnvironment().sBasePath#storage/secure/logs/core_general_sessionhijacking.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #attributes.ip_session# / #cgi.remote_addr#">

<cfoutput>
	<h3>#request.content.session_hijack#</h3>
	<p>
		#request.content.session_hijack_txt#<br/>
		<strong>#attributes.ip_session# / #cgi.remote_addr#</strong>
	</p>
</cfoutput>

<cfsetting enablecfoutputonly="No">