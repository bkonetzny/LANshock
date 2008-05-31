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

<cfquery name="qCurrentModule" dbtype="query">
	SELECT *
	FROM qNavigation
	WHERE module = '#myfusebox.thiscircuit#'
</cfquery>

<cfquery name="qCurrentModuleSubnavi" dbtype="query">
	SELECT *
	FROM qCurrentModule
	WHERE module = '#myfusebox.thiscircuit#'
	AND level > 1
</cfquery>

<cfquery name="qPrimaryNavigation" dbtype="query">
	SELECT *
	FROM qNavigation
	WHERE level = 1
</cfquery>

<cfcontent type="text/html; charset=UTF-8" reset="true"><cfoutput><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<cfinclude template="../header.inc.cfm">
</head>
<body>
<div id="container">
	<div id="banner"><img src="#stImageDir.template#/layout/logo_lanshock.gif"></div>
	<table id="main" cellpadding="0" cellspacing="0">
		<tr>
			<td valign="top">
				<div id="sidebar">
					<cfif session.oUser.isLoggedIn()>
						<h1>#application.lanshock.oHelper.getUsernameById(session.userid)#</h1>
						<ul>
							<li><a href="#application.lanshock.oHelper.buildUrl('user.userdetails')#">$$$ Profile</a></li>
							<li><a href="javascript:Panel();">#request.content.template_show_panel#</a></li>
							<li><a href="#application.lanshock.oHelper.buildUrl('mail.main')#">$$$ Mail</a></li>
							<li><a href="#application.lanshock.oHelper.buildUrl('user.logout')#">$$$ Logout</a></li>
						</ul>
					<cfelse>
						<h1>#request.content.template_profile#</h1>
						<ul>
							<li><a href="#application.lanshock.oHelper.buildUrl('user.login')#">#request.content.template_login#</a></li>
						</ul>
					</cfif>
					
					<cfif qCurrentModule.recordcount>
						<h1><a href="#application.lanshock.oHelper.buildUrl('#qCurrentModule.module[1]#.#qCurrentModule.action[1]#')#">#qCurrentModule.label[1]#</a></h1>
						<ul>
						<cfif qCurrentModuleSubnavi.recordcount	AND (NOT len(qCurrentModule.permissions) OR session.oUser.checkPermissions(qCurrentModule.permissions,qCurrentModule.module))>
							<cfloop query="qCurrentModuleSubnavi">
								<li<cfif qCurrentModuleSubnavi.permissions EQ 'admin'> class="admin"</cfif>><a href="#application.lanshock.oHelper.buildUrl('#qCurrentModuleSubnavi.module#.#qCurrentModuleSubnavi.action#')#">#qCurrentModuleSubnavi.label#</a></li>
							</cfloop>
						</cfif>
						</ul>
					</cfif>
					
					<h1>#request.content.template_navigation#</h1>
					<ul>
					<cfif session.isAdmin>
						<cfset idx = 'c_admin'>
						<li class="admin"><a href="#application.lanshock.oHelper.buildUrl('#idx#.#stNav[idx].action#')#">#stNav[idx].name#</a></li>
					</cfif>
					<cfloop query="qPrimaryNavigation">
						<cfif NOT len(qPrimaryNavigation.permissions) OR session.oUser.checkPermissions(qPrimaryNavigation.permissions,qPrimaryNavigation.module)>
							<li><a href="#application.lanshock.oHelper.buildUrl('#qPrimaryNavigation.module#.#qPrimaryNavigation.action#')#" title="#qPrimaryNavigation.label#">#qPrimaryNavigation.label#</a></li>
						</cfif>
					</cfloop>
					</ul>

					<h1>#request.content.template_info#</h1>
					<ul>
						<li><a href="#application.lanshock.oHelper.buildUrl('general.info')#">LANshock</a></li>
						<li><a href="#application.lanshock.oHelper.buildUrl('general.online')#"><strong>#request.content.template_online_user# #application.lanshock.oSessionmanager.getSessionCount()#</a></li>
						<li><a href="#application.lanshock.oHelper.buildUrl('general.language')#">#GetLocaleDisplayName(session.lang)#</a></li>
						<li>#session.oUser.dateTimeFormat(now(),'datetime')#</li>
					</ul>
				</div>
			</td>
			<td id="content" style="width: 100%;" valign="top">&nbsp;<br>
</cfoutput>

<cfsetting enablecfoutputonly="No"> 