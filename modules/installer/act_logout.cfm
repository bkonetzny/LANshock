<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/act_logout.cfm $
$LastChangedDate: 2006-10-23 00:39:57 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 51 $
--->

<cfset StructDelete(request.session,'lanshock_installer')>

<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.UrlToken#" addtoken="No">

<cfsetting enablecfoutputonly="No">