<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_error.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfparam name="attributes.type" default="">
<cfparam name="attributes.message" default="">

<cfoutput>
	<h4>#request.content.error_headline#</h4>
	<h3>#attributes.type#</h3>
	<p>#attributes.message#</p>
	
	<cfdump var="#StructKeyList(application.lanshock.oModules.getModules('installed'))#">
</cfoutput>
	
<cfsetting enablecfoutputonly="No">