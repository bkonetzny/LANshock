<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_login_validation.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfparam name="attributes.relocationurl" default="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#">

<!--- Fixes the Login Bug --->
<cfif NOT isDefined("session.UserID") OR NOT len(session.UserID) OR NOT isNumeric(session.UserID)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login')#" addtoken="false">
<cfelse>
	<cflocation url="#attributes.relocationurl#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">
