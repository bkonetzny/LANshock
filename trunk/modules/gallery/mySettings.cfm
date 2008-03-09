<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- create default config --->
<cfscript>
	stDefaultModuleConfig = StructNew();
	stDefaultModuleConfig.item = StructNew();
	stDefaultModuleConfig.item.max_width = 640;
	stDefaultModuleConfig.item.max_height = 640;
	stDefaultModuleConfig.tn = StructNew();
	stDefaultModuleConfig.tn.max_width = 160;
	stDefaultModuleConfig.tn.max_height = 120;
	stDefaultModuleConfig.items_per_col = 4;
</cfscript>

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.configmanager" method="createConfig" returnvariable="stModuleConfig">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="data" value="#stDefaultModuleConfig#">
	<cfinvokeargument name="version" value="2.0">
</cfinvoke>

<cfscript>
	stModuleConfig.files.storage = "#application.lanshock.oHelper.UDF_Module('absStoragePathPublic')#galleries/";
	stModuleConfig.files.tmp = getTempDirectory();
</cfscript>

<cfsetting enablecfoutputonly="No">