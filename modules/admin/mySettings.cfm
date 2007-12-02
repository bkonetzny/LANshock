<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/mySettings.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfif NOT request.session.isAdmin>
	<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#general.error_access_denied&#request.session.urltoken#" addtoken="false">
</cfif>

<cfparam name="application.aslogin" default="#StructNew()#">

<cfsetting enablecfoutputonly="No">