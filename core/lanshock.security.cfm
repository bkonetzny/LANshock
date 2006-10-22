<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- Included by plugins/Security.cfm --->

<!--- check session hijacking --->
<cfif application.lanshock.settings.security.check_sessionhijack>
	<cfif request.session.ip_address NEQ cgi.remote_addr AND myfusebox.thiscircuit NEQ '#request.lanshock.settings.modulePrefix.core#general'>
		<cfset ip_session = request.session.ip_address>
		<cfset session = StructNew()>
		<cfset request.session = StructNew()>
		<cfloop collection="#cookie#" item="idx">
			<cfcookie name="#idx#" expires="now">
		</cfloop>
		<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#general.error_session_hijack&ip_session=#UrlEncodedFormat(ip_session)#" addtoken="false">
	</cfif>
</cfif>

<!--- check if user may access the module --->
<cfif application.lanshock.settings.security.check_useraccess_module AND NOT request.session.userloggedin>
	<cfif StructKeyExists(application.module, myfusebox.thiscircuit) AND 
			StructKeyExists(application.module[myfusebox.thiscircuit], 'general') AND 
			StructKeyExists(application.module[myfusebox.thiscircuit].general, 'reqlogin') AND 
			application.module[myfusebox.thiscircuit].general.reqlogin AND 
			myfusebox.thiscircuit NEQ '#request.lanshock.settings.modulePrefix.core#user'>
		<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#general.error_access_denied&#request.session.urltoken#" addtoken="false">
	</cfif>
</cfif>

</cfsilent><cfsetting enablecfoutputonly="No">