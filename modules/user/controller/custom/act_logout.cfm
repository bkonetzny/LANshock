<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_logout.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfcookie name="userid" expires="now">
<cfcookie name="password" expires="now">
<cfset StructDelete(cookie,'userid')>
<cfset StructDelete(cookie,'password')>
<cfset StructClear(session)>

<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login')#" addtoken="false">

<cfsetting enablecfoutputonly="No">