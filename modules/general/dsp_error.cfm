<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.type" default="">
<cfparam name="attributes.message" default="">

<cfoutput>
	<h3>#request.content.error_headline#</h3>
	<h4>#attributes.type#</h4>
	<p>#attributes.message#</p>
</cfoutput>
	
<cfsetting enablecfoutputonly="No">