<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_logout.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfcookie name="password" expires="NOW">

<cfloop list="#StructKeyList(session)#" index="idx">
	<cfset StructDelete(session,idx)>
</cfloop>

<cflocation url="#myself##myfusebox.thiscircuit#.login" addtoken="false">

<cfsetting enablecfoutputonly="No">