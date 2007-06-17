<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- check if there's an valid module structure in application --->
<cfif NOT isDefined("application.module") OR NOT isStruct(application.module) OR StructIsEmpty(application.module) OR NOT application.lanshock.config.modulesinitialized OR NOT application.lanshock.config.datasourceinitialized>

	<!--- delete invalid module key --->
	<cfset StructDelete(application,"module")>

	<!--- Check for modules.xml.cfm --->
	<cfif fileExists(application.lanshock.environment.abspath & "config/modules.xml.cfm")>
	
		<!--- Read modules.xml.cfm --->
		<cffile action="READ" file="#application.lanshock.environment.abspath#config/modules.xml.cfm" variable="ModuleWDDX">
		
		<!--- Try to convert the modules.xml.cfm to a Structure --->
		<cftry>
			<cfwddx action="WDDX2CFML" input="#ModuleWDDX#" output="stModule">
			<cfcatch><cfset stModule = ""></cfcatch>
		</cftry>
		
		<!--- Check if stModule is a valid Structure --->
		<cfif isStruct(stModule) AND NOT StructIsEmpty(stModule)>
			<cflock timeout="10" throwontimeout="No" type="EXCLUSIVE" scope="APPLICATION">
				<cfset Application.Module = stModule>
				<cfset application.lanshock.config.modulesinitialized = true>
			</cflock>
		<cfelse>
			<!--- if stModule is not a valid Structure delete the Source --->
			<cffile action="DELETE" file="#application.lanshock.environment.abspath#config/modules.xml.cfm">
			<cfset application.lanshock.config.modulesinitialized = false>
		</cfif>

	</cfif>
	
	<!--- Check for datasource.xml.cfm --->
	<cfif fileExists(application.lanshock.environment.abspath & "config/datasource.xml.cfm")>
	
		<!--- Read datasource.xml.cfm --->
		<cffile action="READ" file="#application.lanshock.environment.abspath#config/datasource.xml.cfm" variable="DatasourceWDDX">
		
		<!--- Try to convert the datasource.xml.cfm to a Structure --->
		<cftry>
			<cfwddx action="WDDX2CFML" input="#DatasourceWDDX#" output="stDatasource">
		
			<!--- Check if stModule is a valid Structure --->
			<cfif isStruct(stDatasource) AND NOT StructIsEmpty(stDatasource)>
				<cflock timeout="10" throwontimeout="No" type="EXCLUSIVE" scope="APPLICATION">
					<cfset application.datasource = stDatasource>
					<cfset application.lanshock.config.datasourceinitialized = true>
				</cflock>
			<cfelse>
				<!--- if stModule is not a valid Structure delete the Source --->
				<cffile action="DELETE" file="#application.lanshock.environment.abspath#config/datasource.xml.cfm">
				<cfset application.lanshock.config.datasourceinitialized = false>
			</cfif>

			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>

	</cfif>

	<cfif NOT application.lanshock.config.modulesinitialized OR NOT application.lanshock.config.modulesinitialized OR NOT fileExists(application.lanshock.environment.abspath & "fusebox.xml.cfm")>
		<cfinvoke component="#application.lanshock.environment.componentpath#core.admin.setup" method="initCoreModules"/>
	</cfif>
	
	<cfif NOT application.lanshock.config.complete>
		<cfif NOT cgi.query_string CONTAINS "=#application.lanshock.settings.modulePrefix.core#installer">
			<cflocation url="#self#?fuseaction=#application.lanshock.settings.modulePrefix.core#installer.main" addtoken="true">
		</cfif>
	</cfif>
	
</cfif>

</cfsilent><cfsetting enablecfoutputonly="No">