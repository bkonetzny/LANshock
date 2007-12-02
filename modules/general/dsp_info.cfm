<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/dsp_info.cfm $
$LastChangedDate: 2006-10-23 00:36:12 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 50 $
--->

<cfoutput>
	<h3>#request.content.informations#</h3>
	
	<h4>#request.content.gpl_txt#</h4>
	<a href="http://lanshock.com" target="_blank">
		<img src="#stImageDir.module#/logo_lanshock.gif">
	</a><br />
	<a href="http://lanshock.com" target="_blank">
		http://lanshock.com
	</a><br />
	<em>#request.lanshock.settings.version# [#request.lanshock.settings.version_build#]</em>

	<h4>#request.content.concept_scripts#</h4>
	
	<ul>
		<li><a href="mailto:webmaster@lanshock.com">Bastian 'Majestixs' Konetzny</a></li>
		<li><a href="mailto:maniak@gmx.at ">Sascha 'AS' Heisig</a></li>
		<li><a href="http://www.north-lan.de" target="_blank">Team North-LAN</a></li>
	</ul>
	
	<h4>#request.content.translations#</h4>

	<ul>
		<li><a href="mailto:webmaster@lanshock.com">Bastian 'Majestixs' Konetzny</a></li>
		<li><a href="mailto:sascha@north-lan.de">Sascha 'AS' Heisig</a></li>
		<li><a href="mailto:chris@narx.net">Chris 'pulse' Tweedie</a></li>
		<li><a href="mailto:michael@koping.net">Michael 'snake' Holmberg</a></li>
		<li><a href="mailto:lasse@frederiksen.dk">Lasse 'Ashutor' Frederiksen</a></li>
		<li><a href="mailto:danny@netgear.com.my">Danny Pun</a></li>
		<li><a href="mailto:francais@netgear.com.my">Francis Yap</a></li>
	</ul>
</cfoutput>

<cfsetting enablecfoutputonly="No">