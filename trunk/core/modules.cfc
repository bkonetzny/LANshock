<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/setup.cfc $
$LastChangedDate: 2007-09-30 14:43:42 +0200 (So, 30 Sep 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 103 $
--->

<cfcomponent>
	
	<cffunction name="init" output="false" returntype="void">
	
		<cfset variables.qNavigation = QueryNew("module,action,level,label,permissions")>
		<cfset variables.stDatasource = StructNew()>
		<cfset variables.lCoreModules = 'admin,comments,cron,general,installer,mail,team,user'>
		
		<cfset resetModules()>
		<cfset loadInstalledModules()>
		<cfset loadConfig()>
		<cfset buildNavigation()>
	
	</cffunction>
	
	<cffunction name="loadInstalledModules" output="false" returntype="void">
	
		<cfset var qModules = 0>
		<cfset var stModuleInstall = StructNew()>
		<cfset var lInstallModules = ''>
		<cfset var idxModule = ''>
	
		<cftry>
			<cfquery name="qModules" datasource="#application.lanshock.environment.datasource#">
				SELECT folder
				FROM core_modules
			</cfquery>
			<cfset lInstallModules = ValueList(qModules.folder)>
			<cfcatch>
				<cfset lInstallModules = getCoreModules()>
			</cfcatch>
		</cftry>
		
		<cfloop list="#lInstallModules#" index="idxModule">
			<cfset stModuleInstall = installModule(idxModule)>
		</cfloop>
		
	</cffunction>
	
	<cffunction name="resetModules" output="false" returntype="void">
	
		<cfset variables.stModules = StructNew()>
	
	</cffunction>
	
	<cffunction name="loadConfig" output="false" returntype="void">
		
		<cfset var wddxDatasource = ''>
		<cfset var stDatasource = ''>
		<cfset var lInstalledModules = LCase(StructKeyList(getModules('installed')))>
		<cfset var idxCoreModule = ''>
		<cfset var bModulesInstalled = false>
		
		<cfloop list="#variables.lCoreModules#" index="idxCoreModule">
			<cfif NOT ListFind(lInstalledModules,idxCoreModule)>
				<cfset installModule(idxCoreModule)>
				<cfset bModulesInstalled = true>
			</cfif>
		</cfloop>
		
		<cfif bModulesInstalled>
			<cfinvoke component="#application.lanshock.oApplication#" method="reloadApplication"/>
		</cfif>
	
	</cffunction>

	<cffunction name="installModule" output="false" returntype="struct">
		<cfargument name="folder" type="string" required="true">
		
		<cfset var stReturn = StructNew()>
		<cfset var stModuleConfig = loadModuleInfoXml(arguments.folder)>
		<cfset var idx = ''>
		<cfset var stTableStructure = StructNew()>
		<cfset var idxNavigation = ''>
		<cfset var idxPermissions = ''>
		<cfset var idxPermission = ''>
		<cfset var idxRoles = ''>
		<cfset var iNavCounter = 0>
		<cfset var qRoleLookup = 0>
		<cfset var qPermissionLookup = 0>
		
		<cfif stModuleConfig.status>
			
			<cfif NOT StructIsEmpty(stModuleConfig.data.database) AND NOT StructIsEmpty(stModuleConfig.data.database.tables)>
				
				<cfloop collection="#stModuleConfig.data.database.tables#" item="idx">
					
					<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource')#" method="deployTable" returnvariable="stTableStructure">
						<cfinvokeargument name="sTable" value="#idx#">
						<cfinvokeargument name="aStructure" value="#stModuleConfig.data.database.tables[idx]#">
					</cfinvoke>
					
					<cfset variables.stDatasource[idx] = stTableStructure>
					<cfset variables.stDatasource[idx].module = arguments.folder>
					
				</cfloop>
				
			</cfif>
		
			<cfset variables.stModules[arguments.folder] = stModuleConfig.data>

			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.reactor')#" method="createConfig"/>
	
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.transfer')#" method="createConfig"/>
	
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.fusebox')#" method="createConfig"/>
			
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM core_modules
				WHERE folder = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
			</cfquery>
			
			<cfquery datasource="#application.lanshock.environment.datasource#">
				INSERT INTO core_modules (name, folder, version, date)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.version#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#stModuleConfig.data.info.date#">)
			</cfquery>
			
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM core_navigation
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
			</cfquery>
			
			<cfif stModuleConfig.data.general.createCircuit>
			
				<cfquery datasource="#application.lanshock.environment.datasource#">
					INSERT INTO core_navigation (module, action, level, sortorder, permissions)
					VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="main">,
							1,
							1,
							'')
				</cfquery>
				
				<cfloop collection="#stModuleConfig.data.navigation#" item="idxNavigation">
					<cfset iNavCounter = iNavCounter + 1>
					<cfquery datasource="#application.lanshock.environment.datasource#">
						INSERT INTO core_navigation (module, action, level, sortorder, permissions)
						VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#LCase(idxNavigation)#">,
								2,
								<cfqueryparam cfsqltype="cf_sql_integer" value="#iNavCounter#">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.navigation[idxNavigation]#">)
					</cfquery>
				</cfloop>
			
			</cfif>
			
			<cfloop list="#stModuleConfig.data.security_permissions#" index="idxPermissions">
				<cfquery datasource="#application.lanshock.environment.datasource#" name="qPermissionLookup">
					SELECT id
					FROM core_security_permissions
					WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
					AND name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#idxPermissions#">
				</cfquery>
				<cfif NOT qPermissionLookup.recordcount>
					<cfquery datasource="#application.lanshock.environment.datasource#">
						INSERT INTO core_security_permissions (name, module)
						VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#idxPermissions#">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">)
					</cfquery>
				</cfif>
			</cfloop>

			<!--- 
			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM core_security_roles_permissions_rel
				WHERE permission_id IN (
					SELECT id FROM core_security_permissions
					WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
				)
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM core_security_permissions
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
			</cfquery>
			
			<cfloop list="#stModuleConfig.data.security_permissions#" index="idxPermissions">
				<cfquery datasource="#application.lanshock.environment.datasource#">
					INSERT INTO core_security_permissions (name, module)
					VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#idxPermissions#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">)
				</cfquery>
			</cfloop>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM core_security_users_roles_rel
				WHERE role_id IN (
					SELECT id FROM core_security_roles
					WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
				)
			</cfquery>

			<cfquery datasource="#application.lanshock.environment.datasource#">
				DELETE FROM core_security_roles
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
			</cfquery>
			
			<cfloop from="1" to="#ArrayLen(stModuleConfig.data.security_roles)#" index="idxRoles">
				<cfquery datasource="#application.lanshock.environment.datasource#">
					INSERT INTO core_security_roles (name, module)
					VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.security_roles[idxRoles].name#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">)
				</cfquery>
				
				<cfquery name="qRoleLookup" datasource="#application.lanshock.environment.datasource#">
					SELECT id
					FROM core_security_roles
					WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.security_roles[idxRoles].name#">
					AND module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
				</cfquery>
				
				<cfif qRoleLookup.recordcount>
				
					<cfquery name="qPermissionsLookup" datasource="#application.lanshock.environment.datasource#">
						SELECT id
						FROM core_security_permissions
						WHERE name IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.security_roles[idxRoles].permissions#" list="true">)
						AND module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
					</cfquery>
					
					<cfif qPermissionsLookup.recordcount>
					
						<cfloop list="#ValueList(qPermissionsLookup.id)#" index="idxPermission">
							<cfquery datasource="#application.lanshock.environment.datasource#">
								INSERT INTO core_security_roles_permissions_rel (permission_id, role_id)
								VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#idxPermission#">,
										<cfqueryparam cfsqltype="cf_sql_varchar" value="#qRoleLookup.id#">)
							</cfquery>
						</cfloop>
				
					</cfif>
				</cfif>
			</cfloop>
			--->
				
		<cfelse>
		
			<cffile action="append" file="#application.lanshock.sStoragePath#secure/logs/core_modules.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] invalid info.xml.cfm found: #arguments.folder#">
		
		</cfif>
		
		<cfreturn stModuleConfig>
		
	</cffunction>

	<cffunction name="uninstallModule" output="false" returntype="void">
		<cfargument name="folder" type="string" required="true">

		<cfset StructDelete(variables.stModules,arguments.folder)>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.reactor')#" method="createConfig"/>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.transfer')#" method="createConfig"/>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.fusebox')#" method="createConfig"/>
	
		<cfquery datasource="#application.lanshock.environment.datasource#">
			DELETE FROM core_modules
			WHERE folder = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.folder#">
		</cfquery>
		
		<cfquery datasource="#application.lanshock.environment.datasource#">
			DELETE FROM core_navigation
			WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.folder#">
		</cfquery>
		
	</cffunction>
	
	<cffunction name="loadModuleInfoXml" output="false" returntype="struct">
		<cfargument name="folder" type="string" required="true">

		<cfset var stReturn = StructNew()>
		<cfset var sInfoXml = ''>
		<cfset var sModuleInfoXmlFilePath = expandPath('modules/#arguments.folder#/info.xml.cfm')>
		<cfset var stXML = ''>
		<cfset var stData = StructNew()>
		<cfset var idx = ''>
		<cfset var aXmlSearch = ArrayNew(1)>
		
		<cfset stReturn.status = true>
		<cfset stReturn.folder = arguments.folder>
		<cfset stReturn.data = ''>
		
		<cftry>
			<cffile action="read" file="#sModuleInfoXmlFilePath#" variable="sInfoXml">
			
			<cfset stXML = XMLParse(sInfoXml)>
			
			<cfparam name="stXML.module.XmlAttributes.name" default="">
			<cfparam name="stXML.module.XmlAttributes.version" default="">
			<cfparam name="stXML.module.XmlAttributes.date" default="">
			<cfparam name="stXML.module.XmlAttributes.author" default="">
			<cfparam name="stXML.module.XmlAttributes.url" default="">
			<cfparam name="stXML.module.XmlAttributes.hint" default="">
			
			<cfset stData.info = StructNew()>
			<cfset stData.info.name = stXML.module.XmlAttributes.name>
			<cfset stData.info.version = stXML.module.XmlAttributes.version>
			<cfset stData.info.date = ParseDateTime(stXML.module.XmlAttributes.date)>
			<cfset stData.info.folder = arguments.folder>
			<cfset stData.info.author = stXML.module.XmlAttributes.author>
			<cfset stData.info.url = stXML.module.XmlAttributes.url>
			<cfset stData.info.hint = stXML.module.XmlAttributes.hint>
			
			<cfparam name="stXML.module.general.XmlAttributes.requiresLogin" default="false">
			<cfparam name="stXML.module.general.XmlAttributes.loadLanguageFile" default="true">
			<cfparam name="stXML.module.general.XmlAttributes.createCircuit" default="true">
			<cfparam name="stXML.module.general.XmlAttributes.type" default="application">
			
			<cfset stData.general = StructNew()>
			<cfset stData.general.reqLogin = stXML.module.general.XmlAttributes.requiresLogin>
			<cfset stData.general.loadLanguageFile = stXML.module.general.XmlAttributes.loadLanguageFile>
			<cfset stData.general.createCircuit = stXML.module.general.XmlAttributes.createCircuit>
			<cfset stData.general.type = stXML.module.general.XmlAttributes.type>
			
			<cfset stData.navigation = StructNew()>
			<cfset aXmlSearch = XmlSearch(stXML,'/module/navigation/item/')>
			<cfloop from="1" to="#ArrayLen(aXmlSearch)#" index="idx">
				<cfif StructKeyExists(aXmlSearch[idx].XmlAttributes,'action')>
					<cfif StructKeyExists(aXmlSearch[idx].XmlAttributes,'permissions')>
						<cfset stData.navigation[aXmlSearch[idx].XmlAttributes.action] = aXmlSearch[idx].XmlAttributes.permissions>
					<cfelse>
						<cfset stData.navigation[aXmlSearch[idx].XmlAttributes.action] = ''>
					</cfif>
				</cfif>
			</cfloop>
			
			<cfset stData.permissions = ''>
			<cfset aXmlSearch = XmlSearch(stXML,'/module/security/area/')>
			<cfloop from="1" to="#ArrayLen(aXmlSearch)#" index="idx">
				<cfset stData.permissions = ListAppend(stData.permissions,aXmlSearch[idx].XmlAttributes.name)>
			</cfloop>
			
			<cfset stData.security_permissions = ''>
			<cfset aXmlSearch = XmlSearch(stXML,'/module/security/permissions/')>
			<cfif ArrayLen(aXmlSearch)>
				<cfset stData.security_permissions = aXmlSearch[1].XmlAttributes.list>
			</cfif>
			
			<cfset stData.security_roles = ArrayNew(1)>
			<cfset aXmlSearch = XmlSearch(stXML,'/module/security/role/')>
			<cfloop from="1" to="#ArrayLen(aXmlSearch)#" index="idx">
				<cfset ArrayAppend(stData.security_roles,aXmlSearch[idx].XmlAttributes)>
			</cfloop>
			
			<cfset stData.database = StructNew()>
			<cfset stData.database.tables = StructNew()>
			<cfset aXmlSearch = XmlSearch(stXML,'/module/database/table/')>
			<cfloop from="1" to="#ArrayLen(aXmlSearch)#" index="idx">
				<cfset stData.database.tables[aXmlSearch[idx].XmlAttributes.name] = aXmlSearch[idx].XmlChildren>
			</cfloop>
			
			<cfset stData.special = StructNew()>
			<cfif isDefined("stXML.module.special")>
				<cfset stData.special = stXML.module.special>
			</cfif>
			
			<cfset stReturn.data = stData>

			<cfcatch><cfrethrow>
				<cfset stReturn.status = false>
				<cfset stReturn.data = cfcatch>
			</cfcatch>
		</cftry>
		
		<cfreturn stReturn>

	</cffunction>
	
	<cffunction name="getDatasourceStructure" output="false" returntype="struct">

		<cfreturn variables.stDatasource>
		
	</cffunction>
	
	<cffunction name="getModules" output="false" returntype="struct">
		<cfargument name="type" type="string" required="false" default="loaded">
		
		<cfset var stReturn = StructNew()>
		<cfset var qModules = 0>
		<cfset var lSkipModules = ''>

		<cfswitch expression="#arguments.type#">
			<cfcase value="loaded">
				<cfset stReturn = variables.stModules>
			</cfcase>
			<cfcase value="installed">
				<cfset stReturn = variables.stModules>
			</cfcase>
			<cfcase value="notinstalled">
				<cfset lSkipModules = StructKeyList(getModules('loaded'))>
				<cfset lSkipModules = ListAppend(lSkipModules,StructKeyList(getModules('installed')))>
				
				<cfdirectory action="list" directory="#expandPath('modules/')#" name="qModules">
				
				<cfloop query="qModules">
					<cfif qModules.type EQ 'dir'
						AND NOT ListFindNoCase(lSkipModules,qModules.name)
						AND FileExists(expandPath('modules/#qModules.name#/info.xml.cfm'))>
						<cfset stReturn[qModules.name] = loadModuleInfoXml(qModules.name)>
					</cfif>
				</cfloop>
			</cfcase>
		</cfswitch>
		
		<cfreturn stReturn>
		
	</cffunction>
	
	<cffunction name="isLoaded" output="false" returntype="boolean">
		<cfargument name="folder" type="string" required="true">
		
		<cfreturn StructKeyExists(variables.stModules,arguments.folder)>
		
	</cffunction>
	
	<cffunction name="getModuleConfig" output="false" returntype="struct">
		<cfargument name="folder" type="string" required="true">
		
		<cfreturn variables.stModules[arguments.folder]>
		
	</cffunction>

	<cffunction name="getCoreModules" output="false" returntype="string">
		
		<cfreturn variables.lCoreModules>
		
	</cffunction>

	<!---<cffunction name="initModules" output="false" returntype="boolean">
		<cfargument name="stModules" type="struct" required="true">
		
		<cfset var stLocal = StructNew()>
		
		<cfif FileExists(expandPath('config/lanshock/modules.xml.cfm'))>
			<cffile action="delete" file="#expandPath('config/lanshock/modules.xml.cfm')#">
		</cfif>

		<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] *** START DB UPDATE">

		<cfloop collection="#stModules#" item="idx">
		
			<cfparam name="stModules['#idx#'].db" default="">
			
			<!--- Create Datasource Tables --->
			<cfif isStruct(stModules[idx].db) AND NOT StructIsEmpty(stModules[idx].db)>
				<cfloop collection="#stModules[idx].db#" item="idx2">
					<cfset stLocal.stTableStructure = StructNew()>
					<cfset stLocal.stTableStructure[idx2] = stModules[idx].db[idx2]>
					<cfif NOT isArray(stLocal.stTableStructure[idx2])>
						<cfdump var="#stLocal.stTableStructure[idx2]#"><cfabort>
					</cfif>
					<cfinvoke component="datasource" method="deployTable" returnvariable="stTableData">
						<cfinvokeargument name="stTableStructure" value="#stLocal.stTableStructure#">
					</cfinvoke>
					<cfset variables.stDatasource[idx2] = stTableData>
				</cfloop>
			</cfif>

			<cfset StructDelete(stModules[idx], 'db')>
			
		</cfloop>
		
		<!---
		<cfloop collection="#stModules#" item="idx">
		
			<cfparam name="stModules['#idx#'].cron" default="">
			
				<!--- Create Datasource Tables --->
				<cfif isStruct(stModules[idx].cron) AND NOT StructIsEmpty(stModules[idx].cron)>
					<cfloop collection="#stModules[idx].cron#" item="idx2">
						<cfscript>
							qCron = application.objectBreeze.getByWhere('core_cron','module = "#idx#" AND action = "#idx2#"').getQuery();
							if(qCron.recordcount) iCronID = qCron.id;
							else iCronID = 0; 
							
							oObCron = application.objectBreeze.objectCreate("core_cron");
							oObCron.read(iCronID);
							oObCron.setProperty('run',stModules[idx].cron[idx2]);
							oObCron.setProperty('module',idx);
							oObCron.setProperty('action',idx2);
							oObCron.commit();
						</cfscript>
					</cfloop>
	
					<cfset qCrons4Module = application.objectBreeze.getByWhere('core_cron','module = "#idx#"').getQuery()>
					<cfloop query="qCrons4Module">
						<cfscript>
							if(NOT listFindNoCase(StructKeyList(stModules[idx].cron),action)){
								oObCron = application.objectBreeze.objectCreate("core_cron");
								oObCron.read(id);
								oObCron.delete();
							}
						</cfscript>
					</cfloop>
				</cfif>
			
		</cfloop>
		--->
		
		<cfwddx action="CFML2WDDX" input="#variables.stDatasource#" output="DatasourceWDDX" usetimezoneinfo="false">
		
		<cfif NOT directoryExists(expandPath('config/'))>
			<cfdirectory action="create" directory="#expandPath('config/')#" mode="777">		
		</cfif>
		
		<cffile action="WRITE" file="#expandPath('config/lanshock/datasource.xml.cfm')#" output="#DatasourceWDDX#" mode="777">
		
		<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] *** END DB UPDATE">
		
		<cfset variables.stModules = stModules>
		
		<cfwddx action="CFML2WDDX" input="#stModules#" output="ModuleWDDX" usetimezoneinfo="false">
		
		<cffile action="WRITE" file="#expandPath('config/lanshock/modules.xml.cfm')#" output="#ModuleWDDX#" mode="777">
		
		<cfset sCircuits = ''>
		<cfloop list="#listSort(StructKeyList(stModules),'textnocase')#" index="item">
			<cfif stModules[item].general.createCircuit>
				<cfset item = lCase(item)>
				<cfset sModulePrefix = application.lanshock.settings.modulePrefix[stModules[item].type]>
				<cfset sCircuits = sCircuits & chr(13) & chr(9) & chr(9) & '<circuit alias="#sModulePrefix##replaceNoCase(item,sModulePrefix,"","ONE")#" path="modules/#replaceNoCase(item,sModulePrefix,"","ONE")#/"/>'>
			</cfif>
		</cfloop>
		<cfset sCircuits = trim(sCircuits)>
		
		<cfif NOT StructKeyExists(application,'fusebox') OR NOT StructKeyExists(application.fusebox,'password') OR NOT len(application.fusebox.password)>
			<cfset sOldFuseboxPassword = ''>
			<cfset sNewFuseboxPassword = CreateUUID()>
		<cfelse>	
			<cfset sOldFuseboxPassword = application.fusebox.password>
			<cfset sNewFuseboxPassword = sOldFuseboxPassword>	
		</cfif>
		
		<cfsavecontent variable="sFuseboxXml">
			<cfoutput>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE fusebox>
<!--
	generated by LANshock at #now()#
-->
<fusebox>
	<circuits>
		<circuit alias="core_runtime" path="core/runtime/"/>
		<circuit alias="udfs" path="core/_utils/udf/" parent="" />
		#sCircuits#
	</circuits>

	<parameters>		
		<parameter name="fuseactionVariable" value="fuseaction"/>
		<parameter name="defaultFuseaction" value="#application.lanshock.settings.modulePrefix.core#general.welcome"/>
		<parameter name="mode" value="production"/>
		<parameter name="strictMode" value="true"/>
		<parameter name="password" value="#sNewFuseboxPassword#"/>
		<parameter name="characterEncoding" value="utf-8"/>
		<parameter name="debug" value="false"/>
		<parameter name="allowImplicitCircuits" value="true"/>
		<parameter name="queryStringStart" value="/" />
		<parameter name="queryStringSeparator" value="/" />
		<parameter name="queryStringEqual" value="/" />
	</parameters>

	<globalfuseactions>
		<appinit>
			<fuseaction action="core_runtime.initFrameworks"/>
		</appinit>
		<preprocess/>
		<postprocess/>
	</globalfuseactions>
	
	<plugins>
		<phase name="preProcess">
			<plugin name="AttributesFilter" template="AttributesFilter.cfm"/>
			<plugin name="Security" template="Security.cfm"/>
			<plugin name="LanguageLoader" template="LanguageLoader.cfm"/>
			<plugin name="NestedSettings" template="NestedSettings.cfm"/>
			<plugin name="LayoutHeader" template="LayoutHeader.cfm"/>
		</phase>
		<phase name="preFuseaction"/>
		<phase name="postFuseaction"/>
		<phase name="fuseactionException"/>
		<phase name="postProcess">
			<plugin name="LayoutFooter" template="LayoutFooter.cfm"/>
		</phase>
		<phase name="processError"/>
	</plugins>

</fusebox>
			</cfoutput>
		</cfsavecontent>
		
		<cffile action="write" file="#application.lanshock.environment.abspath#fusebox.xml.cfm" output="#trim(sFuseboxXml)#" mode="777" addnewline="false">

		<cfset application.lanshock.oApplication.reloadApplication()>
		
		<cfreturn true>
				
	</cffunction>

	<cffunction name="initCoreModules" output="false" returntype="void">
		
		<cfset var stCore = getModulesByType(type='core')>
		<cfset stCore = getModuleSettings(stModules=stCore)>
		<cfset initModules(stModules=stCore)>
		
	</cffunction>

	<cffunction name="getModulesByType" output="false" returntype="struct">
		<cfargument name="type" type="string" default="module" required="false">

		<cfset var stModules = StructNew()>
		<cfset var sName = ''>
		<cfset var lCoreModules = 'admin,comments,cron,general,installer,mail,team,user'>
		
		<cfif arguments.type EQ "core">
		
			<!--- read configurations from core directory --->
			<cfdirectory action="LIST" directory="#application.lanshock.environment.abspath#modules/" name="dirCore" sort="name ASC">
			<cfloop query="dirCore">
				<cfscript>
					if(dirCore.type EQ "dir"
						AND ListFind(lCoreModules,dirCore.name)
						AND fileExists(application.lanshock.environment.abspath & "modules/" & dirCore.name & "/info.xml.cfm")){
						sName = lCase(name);
						stModules[application.lanshock.settings.modulePrefix.core & sName] = StructNew();
						stModules[application.lanshock.settings.modulePrefix.core & sName].dir = sName;
						stModules[application.lanshock.settings.modulePrefix.core & sName].module_path_abs = application.lanshock.environment.abspath & "modules/" & sName & "/";
						stModules[application.lanshock.settings.modulePrefix.core & sName].module_path_rel = "modules/" & sName & "/";
						stModules[application.lanshock.settings.modulePrefix.core & sName].module_path_web = application.lanshock.environment.webpath & "modules/" & sName & "/";
						stModules[application.lanshock.settings.modulePrefix.core & sName].type = "core";
					}
				</cfscript>
			</cfloop>
			
		<cfelse>
		
			<!--- read configurations from module directory --->
			<cfdirectory action="LIST" directory="#application.lanshock.environment.abspath#modules/" name="dirModules" sort="name ASC">
			<cfloop query="dirModules">
				<cfscript>
					if(dirModules.type EQ "dir"
						AND NOT ListFind(lCoreModules,dirModules.name)
						AND fileExists(application.lanshock.environment.abspath & "modules/" & name & "/info.xml.cfm")){
						sName = lCase(name);
						stModules[application.lanshock.settings.modulePrefix.module & sName] = StructNew();
						stModules[application.lanshock.settings.modulePrefix.module & sName].dir = sName;
						stModules[application.lanshock.settings.modulePrefix.module & sName].module_path_abs = application.lanshock.environment.abspath & "modules/" & sName & "/";
						stModules[application.lanshock.settings.modulePrefix.module & sName].module_path_rel = "modules/" & sName & "/";
						stModules[application.lanshock.settings.modulePrefix.module & sName].module_path_web = application.lanshock.environment.webpath & "modules/" & sName & "/";
						stModules[application.lanshock.settings.modulePrefix.module & sName].type = "module";
					}
				</cfscript>
			</cfloop>
			
		</cfif>
		
		<cfreturn stModules>

	</cffunction>

	<cffunction name="getModuleSettings" output="false" returntype="struct">
		<cfargument name="stModules" type="struct" required="true">

		<cfloop collection="#stModules#" item="idx">

			<cftry>
			
				<cffile action="read" file="#stModules[idx].module_path_abs#info.xml.cfm" variable="infoXML">
				
				<cftry>
					<cfset infoXML = XMLParse(infoXML)>
					<cfcatch>
						<cfthrow message="#cfcatch.message#" detail="Error whileparsing XML-File: #stModules[idx].module_path_abs#info.xml.cfm">
					</cfcatch>
				</cftry>
		
				<cfparam name="infoXML.Module.XmlAttributes.Name" default="">
				<cfparam name="infoXML.Module.XmlAttributes.Author" default="">
				<cfparam name="infoXML.Module.XmlAttributes.Url" default="">
				<cfparam name="infoXML.Module.XmlAttributes.Date" default="">
				<cfparam name="infoXML.Module.XmlAttributes.Version" default="">
				<cfparam name="infoXML.Module.XmlAttributes.Hint" default="">
				<cfparam name="infoXML.Module.General.XmlAttributes.requiresLogin" default="false">
				<cfparam name="infoXML.Module.General.XmlAttributes.loadLanguageFile" default="true">
				<cfparam name="infoXML.Module.General.XmlAttributes.createCircuit" default="true">
				<cfparam name="infoXML.Module.General.XmlAttributes.type" default="application">
		
				<cfscript>
					stModules[idx].name = infoXML.Module.XmlAttributes.Name;
					stModules[idx].author = infoXML.Module.XmlAttributes.Author;
					stModules[idx].url = infoXML.Module.XmlAttributes.Url;
					stModules[idx].date = infoXML.Module.XmlAttributes.Date;
					stModules[idx].version = infoXML.Module.XmlAttributes.Version;
					stModules[idx].hint = infoXML.Module.XmlAttributes.Hint;
					stModules[idx].general.reqLogin = infoXML.Module.General.XmlAttributes.requiresLogin;
					stModules[idx].general.loadLanguageFile = infoXML.Module.General.XmlAttributes.loadLanguageFile;
					stModules[idx].general.createCircuit = infoXML.Module.General.XmlAttributes.createCircuit;
					stModules[idx].general.type = infoXML.Module.General.XmlAttributes.type;
					stModules[idx].securityareas = StructNew();
					stModules[idx].db = StructNew();
					stModules[idx].navigation = StructNew();
				</cfscript>
				
				<cfif isDefined("infoXML.Module.Panels")>
					<cfloop from="1" to="#ArrayLen(infoXML.Module.Panels.XmlChildren)#" index="item">
						<cfparam name="infoXML.Module.Panels.XmlChildren[item].xmlattributes.bUser" default="true">
						<cfparam name="infoXML.Module.Panels.XmlChildren[item].xmlattributes.bAdmin" default="false">
						<cfscript>
							uuidPanel = stModules[idx].type & '_' & idx & '_' & infoXML.Module.Panels.XmlChildren[item].xmlattributes.name;
							stModules[idx].Panels[uuidPanel] = StructNew();
							stModules[idx].Panels[uuidPanel].name = infoXML.Module.Panels.XmlChildren[item].xmlattributes.name;
							stModules[idx].Panels[uuidPanel].action = infoXML.Module.Panels.XmlChildren[item].xmlattributes.action;
							stModules[idx].Panels[uuidPanel].height = infoXML.Module.Panels.XmlChildren[item].xmlattributes.height;
							stModules[idx].Panels[uuidPanel].bUser = infoXML.Module.Panels.XmlChildren[item].xmlattributes.bUser;
							stModules[idx].Panels[uuidPanel].bAdmin = infoXML.Module.Panels.XmlChildren[item].xmlattributes.bAdmin;
						</cfscript>
					</cfloop>
				</cfif>
				
				<cfif isDefined("infoXML.Module.Navigation")>
					<cfset iNavCount = 0>
					<cfloop from="1" to="#ArrayLen(infoXML.Module.Navigation.XmlChildren)#" index="item">
						<cfparam name="infoXML.Module.Navigation.XmlChildren[item].xmlname" default="">
						<cfparam name="infoXML.Module.Navigation.XmlChildren[item].xmlattributes.action" default="">
						<cfparam name="infoXML.Module.Navigation.XmlChildren[item].xmlattributes.reqstatus" default=""> <!--- '' | 'loggedin' | 'notloggedin' | 'admin' --->
						<cfscript>
							if(len(infoXML.Module.Navigation.XmlChildren[item].xmlname) AND len(infoXML.Module.Navigation.XmlChildren[item].xmlattributes.action)){
								iNavCount = iNavCount + 1;
								stModules[idx].Navigation[iNavCount] = StructNew();
								stModules[idx].Navigation[iNavCount].action = infoXML.Module.Navigation.XmlChildren[item].xmlattributes.action;
								stModules[idx].Navigation[iNavCount].reqstatus = infoXML.Module.Navigation.XmlChildren[item].xmlattributes.reqstatus;
							}
						</cfscript>

					</cfloop>
				</cfif>
				
				<cfset stModules[idx].license = ArrayNew(1)>
				<cfif isDefined("infoXML.Module.License")>
					<cfloop from="1" to="#ArrayLen(infoXML.Module.License.XmlChildren)#" index="item">
						<cfset stModules[idx].license[item] = StructNew()>
						<cfset stModules[idx].license[item].type = infoXML.Module.License.XmlChildren[item].xmlattributes.type>
						<cfparam name="infoXML.Module.License.XmlChildren[#item#].xmlattributes.file" default="">
						<cfset stModules[idx].license[item].file = infoXML.Module.License.XmlChildren[item].xmlattributes.file>
						<cfparam name="infoXML.Module.License.XmlChildren[#item#].xmlattributes.name" default="">
						<cfset stModules[idx].license[item].name = infoXML.Module.License.XmlChildren[item].xmlattributes.name>
						<cfparam name="infoXML.Module.License.XmlChildren[#item#].xmlattributes.url" default="">
						<cfset stModules[idx].license[item].url = infoXML.Module.License.XmlChildren[item].xmlattributes.url>
					</cfloop>
				</cfif>
				
				<cfset stModules[idx].dependencies = StructNew()>
				<cfif isDefined("infoXML.Module.dependencies")>
					<cfloop from="1" to="#ArrayLen(infoXML.Module.dependencies.XmlChildren)#" index="item">
						<cfswitch expression="#infoXML.Module.dependencies.XmlChildren[item].xmlname#">
							<cfcase value="filesystem">
								<cfset stModules[idx].dependencies.filesystem[item] = StructNew()>
								<cfparam name="infoXML.Module.dependencies.XmlChildren[#item#].xmlattributes.file" default="">
								<cfset stModules[idx].dependencies.filesystem[item].file = infoXML.Module.dependencies.XmlChildren[item].xmlattributes.file>
								<cfparam name="infoXML.Module.dependencies.XmlChildren[#item#].xmlattributes.folder" default="">
								<cfset stModules[idx].dependencies.filesystem[item].folder = infoXML.Module.dependencies.XmlChildren[item].xmlattributes.folder>
							</cfcase>
						</cfswitch>
					</cfloop>
				</cfif>
				
				<cfif isDefined("infoXML.Module.Security")>
					<cfloop from="1" to="#ArrayLen(infoXML.Module.Security.XmlChildren)#" index="item">
						<cfset stModules[idx].securityareas[infoXML.Module.Security.XmlChildren[item].xmlattributes.name] = infoXML.Module.Security.XmlChildren[item].xmlattributes.name>
					</cfloop>
				</cfif>
				
				<cfif isDefined("infoXML.Module.Cron")>
					<cfloop from="1" to="#ArrayLen(infoXML.Module.Cron.XmlChildren)#" index="item">
						<cfset stModules[idx].cron[infoXML.Module.Cron.XmlChildren[item].xmlattributes.action] = infoXML.Module.Cron.XmlChildren[item].xmlattributes.run>
					</cfloop>
				</cfif>
				
				<cfif isDefined("infoXML.Module.Database")>
					<cfloop from="1" to="#ArrayLen(infoXML.Module.Database.XmlChildren)#" index="item">
						<cfif infoXML.Module.Database.XmlChildren[item].xmlname EQ "table">
							<cfset stModules[idx].db[infoXML.Module.Database.XmlChildren[item].xmlattributes.name] = infoXML.Module.Database.XmlChildren[item].XmlChildren>
						</cfif>
					</cfloop>
				</cfif>
			
				<cfscript>
					if(NOT (len(stModules[idx].name)
						AND len(stModules[idx].author)
						AND len(stModules[idx].url)
						AND len(stModules[idx].date)
						AND len(stModules[idx].version)
						AND len(stModules[idx].general.reqLogin))) StructDelete(stModules, idx);
				</cfscript>
			
				<cfcatch><cfrethrow><cfset StructDelete(stModules,idx)></cfcatch>
		
			</cftry>
			
		</cfloop>
		
		<cfreturn stModules>

	</cffunction>

	<cffunction name="activateModules" output="false" returntype="boolean">
		<cfargument name="lActiveModules" type="string" required="true">

		<cfset var stModules = getModulesByType('module')>
		<cfset var stCoreModules = getModulesByType('core')>
		<cfset var idx = 0>
		
		<cfset StructAppend(stModules, stCoreModules, "true")>
		
		<!--- Delete Unselected Modules --->
		<cfloop collection="#stModules#" item="idx">
			<cfscript>
				if(NOT ListFindNoCase(arguments.lActiveModules,idx)) StructDelete(stModules,idx);
			</cfscript>
		</cfloop>
		
		<cfset stModules = getModuleSettings(stModules)>
		<cfset initModules(stModules)>
		
		<cfreturn true>

	</cffunction>
	--->
	
	<cffunction name="getNavigation" output="false" returntype="query">
		<cfargument name="lang" type="string" required="true">
		
		<cfset var stProperties = StructNew()>
		<cfset var qNavigation = QueryNew('no_column')>
		
		<cfif NOT application.lanshock.oCache.exists("navigation:#arguments.lang#")>
			<cfset qNavigation = variables.qNavigation>
		
			<cfloop query="qNavigation">
				<cfif getModuleConfig(qNavigation.module).general.loadlanguagefile>
					<cftry>
						<cfinvoke component="#application.lanshock.oLanguage#" method="loadProperties" returnvariable="stProperties">
							<cfinvokeargument name="lang" value="#arguments.lang#">
							<cfinvokeargument name="file" value="modules/#qNavigation.module#/i18n/lang.properties">
						</cfinvoke>
						
						<cfif StructKeyExists(stProperties,'__globalmodule__navigation__'&qNavigation.action)>
							<cfset QuerySetCell(qNavigation,'label',stProperties['__globalmodule__navigation__'&qNavigation.action],qNavigation.currentrow)>
						</cfif>
						<cfcatch></cfcatch>
					</cftry>
				</cfif>
			</cfloop>
			
			<cfset application.lanshock.oCache.set("navigation:#arguments.lang#",qNavigation)>
			
		<cfelse>
		
			<cfset qNavigation = application.lanshock.oCache.get("navigation:#arguments.lang#")>
			
		</cfif>
		
		<cfreturn qNavigation>
	</cffunction>
	
	<cffunction name="buildNavigation" output="false" returntype="void">
		<cfset var qNavigation = QueryNew("module,action,level,label,permissions")>
			
		<cfquery name="qNavigation" datasource="#application.lanshock.environment.datasource#">
			SELECT *, action AS label
			FROM core_navigation
			ORDER BY module ASC, level ASC, sortorder ASC
		</cfquery>
		
		<cfset variables.qNavigation = qNavigation>
		
	</cffunction>

</cfcomponent>