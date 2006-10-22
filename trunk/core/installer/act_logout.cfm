<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset StructDelete(request.session,'lanshock_installer')>

<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.UrlToken#" addtoken="No">

<cfsetting enablecfoutputonly="No">