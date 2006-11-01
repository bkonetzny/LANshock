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

	<cfparam name="attributes.group_maxsignups" default="false">
	<cfparam name="attributes.coin_system" default="false">
	<cfparam name="attributes.layout_listview_user_change" default="false">

	<!--- create config --->
	<cfscript>
		stModuleConfigNew = StructNew();
		stModuleConfigNew.groupmaxsignups = attributes.group_maxsignups;
		stModuleConfigNew.coinsystem = attributes.coin_system;
		stModuleConfigNew.coinsystem_usercoins = attributes.coinsystem_usercoins;
		stModuleConfigNew.layout.listview.default = attributes.layout_listview_default;
		stModuleConfigNew.layout.listview.user_change = attributes.layout_listview_user_change;
	</cfscript>

	<!--- set config --->
	<cfinvoke component="#application.lanshock.environment.componentpath#core.configmanager" method="setConfig">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="data" value="#stModuleConfigNew#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfdirectory action="LIST" directory="#UDF_Module('absPath')#/rules" name="qRules" sort="name ASC" recurse="true">

<cfsetting enablecfoutputonly="No">