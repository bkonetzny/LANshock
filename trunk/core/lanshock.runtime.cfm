<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- encoding settings --->
<cfprocessingdirective pageEncoding="utf-8">
<cfcontent type="text/html; charset=utf-8">

<cfscript>
	// get tickkcount for processtime calculation
	request.ProcessTime_Part1 = GetTickCount();

	// encoding settings
	setEncoding("URL", "utf-8");
	setEncoding("FORM", "utf-8");

	// important constant (DO NOT REMOVE!)
	// self = "index.cfm";
	self = "";
</cfscript>

<!--- Load LANshock Version --->
<cfinclude template="lanshock.version.cfm">

<!--- Load User Defined Functions (Pre-Core Version) --->
<cfinclude template="lanshock.udf.lib.pre.cfm">

<!--- Load LANshock Configuration --->
<cfinclude template="lanshock.config.cfm">

<!--- Load LANshock Modules --->
<cfinclude template="lanshock.modules.cfm">

<!--- Load LANshock Locales --->
<cfinclude template="lanshock.locales.cfm">

<!--- Load LANshock Sessionmanagement --->
<cfinclude template="lanshock.session.cfm">

<!--- default locale --->
<cfif left(Server.ColdFusion.ProductVersion,1) EQ 7>
	<cfset SetLocale(session.lang)>
<cfelse>
	<cfset SetLocale("German (Standard)")>
</cfif>

<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="request.content">
	<cfinvokeargument name="base" value="#request.content#">
	<cfinvokeargument name="lang" value="#session.lang#">
	<cfinvokeargument name="path" value="core/_utils/">
</cfinvoke>

<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="request.content">
	<cfinvokeargument name="base" value="#request.content#">
	<cfinvokeargument name="lang" value="#session.lang#">
	<cfinvokeargument name="path" value="modules/comments/">
</cfinvoke>

<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="request.content">
	<cfinvokeargument name="base" value="#request.content#">
	<cfinvokeargument name="lang" value="#session.lang#">
	<cfinvokeargument name="path" value="templates/#application.lanshock.settings.layout.template#/">
</cfinvoke>

<cfsetting enablecfoutputonly="No">