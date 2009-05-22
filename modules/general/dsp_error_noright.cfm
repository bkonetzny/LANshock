<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.right_module" default="">
<cfparam name="attributes.right_area" default="">

<cfoutput>
	<h3>#request.content.righterr1#</h3>
	
	<p>#request.content.righterr2#</p>

	<cfif len(attributes.right_module) AND len(attributes.right_area)>
		<p><strong>#HtmlEditFormat(attributes.right_module)#: #HtmlEditFormat(attributes.right_area)#</strong></p>
	</cfif>
	<cfif len(cgi.http_referer)>
		<a href="#cgi.http_referer#">#request.content.back#</a>
	</cfif>
</cfoutput>

<cfsetting enablecfoutputonly="false">