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

	<!--- create config --->
	<cfscript>
		stModuleConfigNew = StructNew();
		stModuleConfigNew.groupmaxsignups = attributes.group_maxsignups;
		stModuleConfigNew.coinsystem = attributes.coin_system;
		stModuleConfigNew.coinsystem_usercoins = attributes.coinsystem_usercoins;
	</cfscript>

	<!--- set config --->
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.configmanager')#" method="setConfig">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="data" value="#stModuleConfigNew#">
	</cfinvoke>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" addtoken="false">
</cfif>

<cfdirectory action="list" directory="#sStorageRules#" name="qRules" sort="name ASC" recurse="true">

<cfsetting enablecfoutputonly="No">