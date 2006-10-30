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
	stDefaultModuleConfig.item.max_height = 480;
	stDefaultModuleConfig.tn = StructNew();
	stDefaultModuleConfig.tn.max_width = 160;
	stDefaultModuleConfig.tn.max_height = 120;
	stDefaultModuleConfig.items_per_col = 4;
	stDefaultModuleConfig.user_create = true;
	stDefaultModuleConfig.resize_smaller_items = false;
	stDefaultModuleConfig.public_download = true;
</cfscript>

<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="createConfig" returnvariable="stModuleConfig">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="data" value="#stDefaultModuleConfig#">
	<cfinvokeargument name="version" value="1.0">
</cfinvoke>

<cfscript>
	stModuleConfig.files.storage = "#UDF_Module('absPath')#galleries/";
	stModuleConfig.files.tmp = "#UDF_Module('absPath')#galleries/tmp/";
</cfscript>

<cfsetting enablecfoutputonly="No">