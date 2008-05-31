<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/dsp_login.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfoutput>
	<h3>Team</h3>
	
	<cfloop query="qUsers">
		<h4>#qUsers.name#</h4>
		<div style="float: left; margin-right: 20px; width: 80px; height: 80px;">
			#application.lanshock.oHelper.UserShowAvatar(qUsers.id)#
		</div>
		<div style="float: left;">
			<p>#qUsers.firstname# #qUsers.lastname#<br/>
				<a href="mailto:#qUsers.email#">#qUsers.email#</a><br/>
				<br/>
				<a href="#application.lanshock.oHelper.buildUrl('user.userdetails&id=#qUsers.id#')#">Profil</a>
			</p>
		</div>
		<div class="clearer"></div>
	</cfloop>
</cfoutput>

<cfsetting enablecfoutputonly="No">