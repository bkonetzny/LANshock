<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput><cfset getPageContext().getOut().clearBuffer()>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
					<cfif request.session.UserLoggedIn>
						<h1>#getUsernameById(request.session.userid)#</h1>
						<ul>
							<li><a href="#myself##request.lanshock.settings.modulePrefix.core#user.userdetails&#request.session.UrlToken#">#stNav[request.lanshock.settings.modulePrefix.core & 'user'].sub[2].name#</a></li>
							<li><a href="javascript:Panel();">#request.content.template_show_panel#</a></li>
							<li><a href="#myself##request.lanshock.settings.modulePrefix.core#mail.main&#request.session.UrlToken#">#stNav[request.lanshock.settings.modulePrefix.core & 'mail'].name#</a></li>
							<li><a href="#myself##request.lanshock.settings.modulePrefix.core#team.main&#request.session.UrlToken#">#stNav[request.lanshock.settings.modulePrefix.core & 'team'].name#</a></li>
							<li><a href="#myself##request.lanshock.settings.modulePrefix.core#user.logout&#request.session.UrlToken#">#stNav[request.lanshock.settings.modulePrefix.core & 'user'].sub[3].name#</a></li>
						</ul>
					<cfelse>
						<h1>#request.content.template_profile#</h1>
						<ul>
							<li><a href="#myself##request.lanshock.settings.modulePrefix.core#user.login&#request.session.UrlToken#">#request.content.template_login#</a></li>
						</ul>
					</cfif>
					
					<cfif StructKeyExists(stNav,myfusebox.thiscircuit)>
						<h1><a href="#myself##myfusebox.thiscircuit#.#stNav[myfusebox.thiscircuit].action#&#request.session.UrlToken#">#stNav[myfusebox.thiscircuit].name#</a></h1>
						<ul>
						<cfif (stNav[myfusebox.thiscircuit].reqlogin AND request.session.userloggedin OR NOT stNav[myfusebox.thiscircuit].reqlogin)>
							<cfloop list="#ListSort(StructKeyList(stNav[myfusebox.thiscircuit].sub),'numeric')#" index="idx">
								<li<cfif stNav[myfusebox.thiscircuit].sub[idx].reqstatus EQ 'admin'> class="admin"</cfif>><a href="#myself##myfusebox.thiscircuit#.#stNav[myfusebox.thiscircuit].sub[idx].action#&#request.session.UrlToken#">#stNav[myfusebox.thiscircuit].sub[idx].name#</a></li>
							</cfloop>
						</cfif>
						</ul>
					</cfif>
					
					<h1>#request.content.template_navigation#</h1>
					<ul>
					<cfif request.session.isAdmin>
						<cfset idx = '#request.lanshock.settings.modulePrefix.core#admin'>
						<li class="admin"><a href="#myself##idx#.#stNav[idx].action#&#request.session.UrlToken#">#stNav[idx].name#</a></li>
					</cfif>
					<cfloop from="1" to="#ArrayLen(aNav)#" index="idxArray">
						<cfset idx = aNav[idxArray]>
						<cfif stNav[idx].type EQ 'module' AND (stNav[idx].reqlogin AND request.session.UserLoggedIn OR NOT stNav[idx].reqLogin)>
							<li><a href="#myself##idx#.#stNav[idx].action#&#request.session.UrlToken#" title="#stNav[idx].name#">#stNav[idx].name#</a></li>
						</cfif>
					</cfloop>
					</ul>
					
					<h1>#request.content.template_info#</h1>
					<ul>
						<li><a href="#myself##request.lanshock.settings.modulePrefix.core#general.info&#request.session.UrlToken#">#stNav[request.lanshock.settings.modulePrefix.core & 'general'].name#</a></li>
						<!--- <li><a href="#myself##request.lanshock.settings.modulePrefix.core#setup.main&#request.session.UrlToken#">#stNav[request.lanshock.settings.modulePrefix.core & 'setup'].name#</a></li> --->
						<li><a href="#myself##request.lanshock.settings.modulePrefix.core#general.online&#request.session.UrlToken#"><strong>#request.content.template_online_user# #request.application.sessions.iActiveSessions#<cfif request.application.sessions.iOnlineGuest GT 0> <em>(#request.content.template_online_guests# #request.application.sessions.iOnlineGuest#)</em></cfif></strong></a></li>
						<li><a href="#myself##request.lanshock.settings.modulePrefix.core#general.language&#request.session.UrlToken#">#stLocales[request.session.lang]#</a></li>
						<li>#UDF_DateTimeFormat(now())#</li>
					</ul>
				</div>
			</td>
			<td id="content" style="width: 100%;" valign="top">&nbsp;<br>
</cfoutput>

<cfsetting enablecfoutputonly="No"> 