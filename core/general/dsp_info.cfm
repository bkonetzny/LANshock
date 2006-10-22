<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfoutput>
	<div class="headline">#request.content.informations#</div>
	
	<div align="center">
		<div class="headline2">#request.content.gpl_txt#</div><br><br>
		<a href="http://lanshock.com" target="_blank">
			<img src="#stImageDir.module#/logo_lanshock.gif"><br>
			http://lanshock.com</a>
		
		<br>&nbsp;<br>&nbsp;<br>
		<em style="border: 1px dotted gray; padding: 5px;">#request.lanshock.settings.version# [#request.lanshock.settings.version_build#]</em>
		<br>&nbsp;<br>

	</div>
	
	<table width="100%">
		<tr>
			<td valign="top">
				<div class="headline2">#request.content.concept_scripts#</div>
				
				<ul>
					<li><a href="mailto:webmaster@lanshock.com">Bastian 'Majestixs' Konetzny</a></li>
					<li><a href="mailto:maniak@gmx.at ">Sascha 'AS' Heisig</a></li>
					<li><a href="http://www.north-lan.de" target="_blank">Team North-LAN</a></li>
				</ul>
			</td>
			<td valign="top">
				<div class="headline2">#request.content.translations#</div>
	
				<ul>
					<li><a href="mailto:webmaster@lanshock.com">Bastian 'Majestixs' Konetzny</a></li>
					<li><a href="mailto:sascha@north-lan.de">Sascha 'AS' Heisig</a></li>
					<li><a href="mailto:chris@narx.net">Chris 'pulse' Tweedie</a></li>
					<li><a href="mailto:michael@koping.net">Michael 'snake' Holmberg</a></li>
					<li><a href="mailto:lasse@frederiksen.dk">Lasse 'Ashutor' Frederiksen</a></li>
					<li><a href="mailto:danny@netgear.com.my">Danny Pun</a></li>
					<li><a href="mailto:francais@netgear.com.my">Francis Yap</a></li>
				</ul>
			</td>
		</tr>
	</table>
</cfoutput>

<cfsetting enablecfoutputonly="No">