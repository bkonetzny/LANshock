<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- get config --->
<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="getConfig" returnvariable="stModuleConfigNew">
	<cfinvokeargument name="module" value="__core_runtime">
</cfinvoke>

<cfsetting enablecfoutputonly="No">