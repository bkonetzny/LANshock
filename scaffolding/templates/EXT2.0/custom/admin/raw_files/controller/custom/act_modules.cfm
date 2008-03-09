<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.lModules" default="">
<cfparam name="attributes.mode" default="">
<cfparam name="attributes.bModulesSaved" default="false">

<cfinvoke component="#application.lanshock.oModules#" method="getCoreModules" returnvariable="lCoreModules"/>

<cfif attributes.form_submitted>
	
	<cfif attributes.mode EQ 'install'>
	
		<!--- <cfinvoke component="#application.lanshock.oModules#" method="resetModules"/>
		
		<cfset attributes.lModules = ListAppend(lCoreModules,attributes.lModules)> --->
		
		<cfloop list="#attributes.lModules#" index="idx">
		
			<cfinvoke component="#application.lanshock.oModules#" method="installModule" returnvariable="stReturn">
				<cfinvokeargument name="folder" value="#idx#">
			</cfinvoke>
			
			<cfif NOT stReturn.status>
				<cfdump var="#stReturn.data#">
				<cfabort>
			</cfif>
	
		</cfloop>
	
	<cfelseif attributes.mode EQ 'uninstall'>
		
		<cfloop list="#attributes.lModules#" index="idx">
		
			<cfinvoke component="#application.lanshock.oModules#" method="uninstallModule" returnvariable="stReturn">
				<cfinvokeargument name="folder" value="#idx#">
			</cfinvoke>
	
		</cfloop>
	
	</cfif>
	
	<cfinvoke component="#application.lanshock.oApplication#" method="reloadApplication"/>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&bModulesSaved=true')#" addtoken="false">
</cfif>

<cfif NOT len(application.lanshock.oRuntime.getEnvironment().sDatasource)>
	<cfset ArrayAppend(aError, request.content.error_no_datasource)>
</cfif>

<cfinvoke component="#application.lanshock.oModules#" method="getModules" returnvariable="stModulesInstalled">
	<cfinvokeargument name="type" value="installed">
</cfinvoke>

<!--- <cfinvoke component="#application.lanshock.oModules#" method="getModules" returnvariable="stModulesLoaded">
	<cfinvokeargument name="type" value="loaded">
</cfinvoke> --->

<cfinvoke component="#application.lanshock.oModules#" method="getModules" returnvariable="stModulesFilesystem">
	<cfinvokeargument name="type" value="notinstalled">
</cfinvoke>

<cfsetting enablecfoutputonly="No">