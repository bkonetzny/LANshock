<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/layoutHeader.cfm $
$LastChangedDate: 2006-10-23 00:39:57 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 51 $
--->

<cfset stRuntimeConfig = application.lanshock.oRuntime.getRuntimeConfig()>

<cfif StructKeyExists(attributes,'language')>
	<cfset session.oUser.setDataValue('lang',attributes.language)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" addtoken="false">
</cfif>

<!--- remove after 10 minutes of inactivity --->
<cfif len(session.oUser.getCustomDataValue('lanshockInstallerTimestamp')) AND DateDiff('N',session.oUser.getCustomDataValue('lanshockInstallerTimestamp'),now()) LTE 10>
	<cfset session.oUser.setCustomDataValue('lanshockInstallerTimestamp',now())>
<cfelse>
	<cfset session.oUser.setCustomDataValue('lanshockInstallerTimestamp','')>
</cfif>

<cfif NOT isDefined("stRuntimeConfig.lanshock.password")>
	<cfif myfusebox.thisfuseaction NEQ "setpassword">
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.setpassword')#" addtoken="false">
	</cfif>
<cfelse>
	<cfif NOT len(session.oUser.getCustomDataValue('lanshockInstallerTimestamp')) AND myfusebox.thisfuseaction NEQ "login">
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login')#" addtoken="false">
	<cfelseif myfusebox.thisfuseaction EQ "login" AND len(session.oUser.getCustomDataValue('lanshockInstallerTimestamp'))>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
	</cfif>
</cfif>

<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>#request.content.__globalmodule__name#</title>
	<cfset bRequestIncludeCss = false>
	<cfinclude template="../../templates/basic.header.inc.cfm">
	<link rel="stylesheet" href="#application.lanshock.oRuntime.getEnvironment().sWebPath#modules/installer/styles.css" type="text/css"/>
</head>
<body>
<div id="wrap">
	<div id="loginlogout">
		<cfif len(session.oUser.getCustomDataValue('lanshockInstallerTimestamp'))>
			<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.logout')#">#request.content.logout#</a>
		<cfelse>
			<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.login')#">#request.content.login#</a>
		</cfif>
		 | <a href="#application.lanshock.oHelper.buildUrl()#">#request.content.leave#</a>
	</div>
	<div id="languages">
		<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&language=de_DE')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/de.png" alt="de"/></a> 
		<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&language=en_US')#"><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/gb.png" alt="en"/></a>
	</div>
	<div id="logo"></div>
	<div id="content">
</cfoutput>

<cfsetting enablecfoutputonly="No">