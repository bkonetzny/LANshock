<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcookie name="password" expires="NOW">

<cfloop list="#StructKeyList(session)#" index="idx">
	<cfset StructDelete(session,idx)>
</cfloop>

<cflocation url="#myself##myfusebox.thiscircuit#.login" addtoken="false">

<cfsetting enablecfoutputonly="No">