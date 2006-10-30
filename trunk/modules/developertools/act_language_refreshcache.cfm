<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset application.lanshock.cache.language = StructNew()>

<cflocation url="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">