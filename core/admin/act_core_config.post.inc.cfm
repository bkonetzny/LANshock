<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- set config --->
<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="setConfig">
	<cfinvokeargument name="module" value="__core_runtime">
	<cfinvokeargument name="data" value="#stModuleConfigNew#">
</cfinvoke>
	
<cflocation url="#myself##myfusebox.thiscircuit#.core_config&#request.session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">