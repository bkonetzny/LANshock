<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/act_rss.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfparam name="attributes.mode" default="short">

<cfif NOT ListFind('short,full', attributes.mode)>
	<cfset attributes.mode = 'short'>
</cfif>

<cfinvoke component="#application.modulecache.news.cfc.news#" method="generateRSS" returnvariable="sRSS">
	<cfinvokeargument name="mode" value="#attributes.mode#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">