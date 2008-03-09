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
<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.configmanager" method="setConfig">
	<cfinvokeargument name="module" value="__core_runtime">
	<cfinvokeargument name="data" value="#stModuleConfigNew#">
</cfinvoke>

<!--- get config --->
<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.configmanager" method="getConfig" returnvariable="stModuleConfigNew">
	<cfinvokeargument name="module" value="__core_runtime">
</cfinvoke>
	
<cflocation url="#myself##myfusebox.thiscircuit#.core_config&#session.urltoken#" addtoken="false">

<cfsetting enablecfoutputonly="No">