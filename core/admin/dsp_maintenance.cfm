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
<div class="headline"><!--- TODO: $$$ ---> Maintenance</div>

<div class="headline2"><!--- TODO: $$$ ---> #request.content.onlineupdate#</div>
<!--- TODO: $$$ ---> $$$ Text
<br><a href="#myself##myfusebox.thiscircuit#.onlineupdate&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Edit General Settings</a>

<div class="headline2"><!--- TODO: $$$ ---> System Check</div>
<!--- TODO: $$$ ---> $$$ Text
<br><a href="#myself##myfusebox.thiscircuit#.system_check&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Edit General Settings</a>

<div class="headline2"><!--- TODO: $$$ ---> Config DB Editor</div>
<!--- TODO: $$$ ---> $$$ Text
<br><a href="#myself##myfusebox.thiscircuit#.config_editor&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Adjust System Security</a>

<div class="headline2">#request.content.logviewer_headline#</div>
<!--- TODO: $$$ ---> $$$ Text
<br><a href="#myself##myfusebox.thiscircuit#.logviewer&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Adjust System Security</a>

<div class="headline2">#request.content.datadump#</div>
<!--- TODO: $$$ ---> $$$ Text
<br><a href="#myself##myfusebox.thiscircuit#.datadump&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Configure Session Management</a>

<div class="headline2">Tabledump</div>
<!--- TODO: $$$ ---> $$$ Text
<br><a href="#myself##myfusebox.thiscircuit#.tabledump&#request.session.UrlToken#" class="link_extended"><!--- TODO: $$$ ---> Configure Session Management</a>
</cfoutput>

<cfsetting enablecfoutputonly="No">