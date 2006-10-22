<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif len(application.lanshock.settings.startpage)>
	<cflocation url="#myself##application.lanshock.settings.startpage#&#request.session.urltoken#" addtoken="false">
</cfif>

<cfoutput>
	<div class="headline">#request.content.welcome_headline#</div>
	<br>&nbsp;<br>
	<div align="center">#request.content.welcome1#</div>
	<br>&nbsp;<br>&nbsp;<br>
	<table align="center" width="80%" cellpadding="5">
		<tr>
			<td>&nbsp;<br><a class="link_extended" href="#myself##myfusebox.thiscircuit#.language&#request.session.urltoken#">#request.content.welcome_change_language#</a></td>
		</tr>
		<tr>
			<td>#request.content.welcome_change_language_txt#</td>
		</tr>
		<tr>
			<td>&nbsp;<br><a class="link_extended" href="#myself##request.lanshock.settings.modulePrefix.core#user.login&#request.session.urltoken#">#request.content.welcome_login#</a></td>
		</tr>
		<tr>
			<td>#request.content.welcome_login_txt#</td>
		</tr>
		<tr>
			<td>&nbsp;<br><a class="link_extended" href="#myself##myfusebox.thiscircuit#.online&#request.session.urltoken#">#request.content.welcome_online#</a></td>
		</tr>
		<tr>
			<td>#request.content.welcome_online_txt#</td>
		</tr>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">