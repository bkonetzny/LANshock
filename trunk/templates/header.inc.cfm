<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset qNavigation = application.lanshock.oModules.getNavigation(lang=session.lang)>

<cfquery name="qPageTitle" dbtype="query">
	SELECT label
	FROM qNavigation
	WHERE module = '#myfusebox.thiscircuit#'
	AND level = 1
</cfquery>

<cfquery name="qPageTitleSub" dbtype="query">
	SELECT label
	FROM qNavigation
	WHERE module = '#myfusebox.thiscircuit#'
	AND action = '#myfusebox.thisfuseaction#'
</cfquery>

<cfoutput>
	<title><cfif len(request.lanshock.settings.appname)>#request.lanshock.settings.appname#</cfif><cfif qPageTitle.recordcount> -- #qPageTitle.label#</cfif><cfif qPageTitleSub.recordcount> -- #qPageTitleSub.label#</cfif></title>
</cfoutput>

<cfinclude template="basic.header.inc.cfm">

<cfsetting enablecfoutputonly="No">