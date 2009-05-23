<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinclude template="module.config.cfm">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.configmanager')#" method="createConfig" returnvariable="stConfig">
	<cfinvokeargument name="module" value="__core_runtime">
	<cfinvokeargument name="data" value="#stConfig#">
	<cfinvokeargument name="version" value="2.0">
</cfinvoke>

<cfsetting enablecfoutputonly="false">