<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_error_noright.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfparam name="attributes.right_module" default="">
<cfparam name="attributes.right_area" default="">

<cfoutput>
	<h4>#request.content.righterr1#</h4>
	
	<p>#request.content.righterr2#</p>

	<cfif len(attributes.right_module) AND len(attributes.right_area)>
		<p><strong>#attributes.right_module#: #attributes.right_area#</strong></p>
	</cfif>
	<cfif len(cgi.http_referer)>
		<a href="#cgi.http_referer#" class="link_extended">#request.content.back#</a>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="No">