<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif NOT request.session.isAdmin>
	<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#general.error_access_denied&#request.session.urltoken#" addtoken="false">
</cfif>

<cfparam name="application.aslogin" default="#StructNew()#">

<cfsetting enablecfoutputonly="No">