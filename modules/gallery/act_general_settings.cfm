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
	</cfscript>

	<!--- set config --->
	<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core.configmanager" method="setConfig">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="data" value="#stModuleConfig#">
	</cfinvoke>

</cfif>

<cfsetting enablecfoutputonly="No">