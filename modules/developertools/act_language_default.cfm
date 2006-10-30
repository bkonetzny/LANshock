<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.file" default="">
<cfparam name="attributes.directory" default="">
<cfset attributes.langFile = application.lanshock.environment.abspath & attributes.directory & attributes.file>

<cfif fileExists(attributes.langFile)>
	<cffile action="write" file="#GetDirectoryFromPath(attributes.langFile)#lang.default" output="#GetFileFromPath(attributes.langFile)#" addnewline="false">
</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.language_main&directory=#UrlEncodedFormat(attributes.directory)#&#request.session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">