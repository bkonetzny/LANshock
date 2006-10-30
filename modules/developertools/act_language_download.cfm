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

<cfset sFile = application.lanshock.environment.abspath & attributes.directory & attributes.file>

<cfif right(sFile,10) EQ 'properties'>
	<cfheader name="content-disposition" value="attachment;filename=#attributes.file#">
	<cfcontent file="#sFile#" reset="true" type="text/plain">
</cfif>

<cfsetting enablecfoutputonly="No">