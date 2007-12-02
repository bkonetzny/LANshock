<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_login_validation.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfparam name="attributes.relocationurl" default="#myself##myfusebox.thiscircuit#.userdetails&#request.session.urltoken#">

<!--- Fixes the Login Bug --->
<cfif NOT isDefined("request.session.UserID") OR NOT len(request.session.UserID) OR NOT isNumeric(request.session.UserID)>
	<cflocation url="#myself##myfusebox.thiscircuit#.login&#request.session.urltoken#" addtoken="false">
<cfelse>
	<cflocation url="#attributes.relocationurl#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">
