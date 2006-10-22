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
	<div class="headline">#request.content.error_headline#</div>
	<div class="headline2">#attributes.type#</div>
	#attributes.message#
</cfoutput>
	
<cfsetting enablecfoutputonly="No">
