<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_welcome.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfif len(application.lanshock.settings.startpage)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#application.lanshock.settings.startpage#')#" addtoken="false">
</cfif>

<cfoutput>
	<h3>#request.content.welcome_headline#</h3>
	
	<p>#request.content.welcome1#</p>
	
	<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.language')#">#request.content.welcome_change_language#</a></h4>
	
	<p>#request.content.welcome_change_language_txt#</p>
	
	<h4><a href="#application.lanshock.oHelper.buildUrl('user.login')#">#request.content.welcome_login#</a></h4>
	
	<p>#request.content.welcome_login_txt#</p>
	
	<h4><a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.online')#">#request.content.welcome_online#</a></h4>
	
	<p>#request.content.welcome_online_txt#</p>
</cfoutput>

<cfsetting enablecfoutputonly="No">