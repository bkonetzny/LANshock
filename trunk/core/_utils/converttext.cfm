<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="sConvertedText" default="">

<cfset sConvertedText = ' ' & sConvertedText>

<cfif application.lanshock.settings.layout.converttext.escapehtml AND NOT arguments.allow_html>
	<cfset sConvertedText = replaceList(sConvertedText, '<,>', '&lt;,&gt;')>
</cfif>
<cfif len(application.lanshock.settings.layout.smileyset)>
	<cfinclude template="_smileys.cfm">
</cfif>
<cfif application.lanshock.settings.layout.converttext.pseudocode>
	<cfinclude template="_pseudocode.cfm">
</cfif>

<cfset sConvertedText = trim(sConvertedText)>

<cfsetting enablecfoutputonly="No">