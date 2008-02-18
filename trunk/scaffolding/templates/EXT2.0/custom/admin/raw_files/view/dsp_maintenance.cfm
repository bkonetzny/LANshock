<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/dsp_maintenance.cfm $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfoutput>
<h3><!--- TODO: $$$ ---> Maintenance</h3>

<h4><!--- TODO: $$$ ---> System Check</h4>
<p>
	<!--- TODO: $$$ ---> $$$ Text
	<br><a href="#myself##myfusebox.thiscircuit#.system_check&#session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Edit General Settings</a>
</p>

<h4>#request.content.logviewer_headline#</h4>
<p>
	<!--- TODO: $$$ ---> $$$ Text
	<br><a href="#myself##myfusebox.thiscircuit#.logviewer&#session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Adjust System Security</a>
</p>

<h4>#request.content.datadump#</h4>
<p>
	<!--- TODO: $$$ ---> $$$ Text
	<br><a href="#myself##myfusebox.thiscircuit#.datadump&#session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Configure Session Management</a>
</p>
</cfoutput>

<cfsetting enablecfoutputonly="No">