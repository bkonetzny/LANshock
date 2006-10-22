<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="lModulesInstalled" default="">
<cfparam name="stModulesInstalled" default="StructNew()">
<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.lmodules" default="">
<cfparam name="attributes.bModulesSaved" default="false">
<cfparam name="sDisabled" default="">

<cfif attributes.form_submitted>
	<cfinvoke component="setup" method="activateModules">
		<cfinvokeargument name="lActiveModules" value="#attributes.lmodules#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&bModulesSaved=true&#request.session.urltoken#" addtoken="false">
</cfif>

<!--- get Modules --->
<cfinvoke component="setup" method="getModulesByType" returnvariable="stModules">
	<cfinvokeargument name="type" value="module">
</cfinvoke>

<!--- get Core Modules --->
<cfinvoke component="setup" method="getModulesByType" returnvariable="stCoreModules">
	<cfinvokeargument name="type" value="core">
</cfinvoke>

<cfscript>
	if(isDefined("application.module")){
		lModulesInstalled = StructKeyList(application.module);
		stModulesInstalled = duplicate(application.module);
	}

	StructAppend(stModules, stCoreModules, "true");

	if(NOT len(application.lanshock.environment.datasource)) ArrayAppend(aError, request.content.error_no_datasource);
	
	if(ArrayLen(aError)) sDisabled = ' disabled';
</cfscript>

<!--- Get Details for all Modules --->
<cfinvoke component="setup" method="getModuleSettings" returnvariable="stModulesAvaible">
	<cfinvokeargument name="stModules" value="#stModules#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">