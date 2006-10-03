<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif right(cgi.script_name, Len("index.cfm")) NEQ "index.cfm" AND right(cgi.script_name, 3) NEQ "cfc">
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<cfapplication name="lanshock_#LCase(hash(GetCurrentTemplatePath()))#" loginstorage="session" clientmanagement="no" sessionmanagement="yes" setclientcookies="yes" setdomaincookies="no" sessiontimeout="#CreateTimeSpan(0,0,20,0)#">

</cfsilent><cfsetting enablecfoutputonly="No">