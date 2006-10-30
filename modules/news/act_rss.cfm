<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.mode" default="short">

<cfif NOT ListFind('short,full', attributes.mode)>
	<cfset attributes.mode = 'short'>
</cfif>

<cfinvoke component="news" method="generateRSS" returnvariable="sRSS">
	<cfinvokeargument name="mode" value="#attributes.mode#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">