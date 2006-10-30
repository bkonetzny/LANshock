<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">

<cfif attributes.form_submitted>

	<cfparam name="attributes.user_create" default="false">
	<cfparam name="attributes.resize_smaller_items" default="false">
	<cfparam name="attributes.public_download" default="false">

	<!--- create config --->
	<cfscript>
		stModuleConfig = StructNew();
		stModuleConfig.item = StructNew();
		stModuleConfig.item.max_width = attributes.item_max_width;
		stModuleConfig.item.max_height = attributes.item_max_height;
		stModuleConfig.tn = StructNew();
		stModuleConfig.tn.max_width = attributes.tn_max_width;
		stModuleConfig.tn.max_height = attributes.tn_max_height;
		stModuleConfig.items_per_col = attributes.items_per_col;
		stModuleConfig.user_create = attributes.user_create;
		stModuleConfig.resize_smaller_items = attributes.resize_smaller_items;
		stModuleConfig.public_download = attributes.public_download;
	</cfscript>

	<!--- set config --->
	<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="setConfig">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="data" value="#stModuleConfig#">
	</cfinvoke>

</cfif>

<cfsetting enablecfoutputonly="No">