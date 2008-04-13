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
	
		<cfset variables.qNavigation = QueryNew("module,action,level,label,permissions,sortorder")>
		<cfset variables.stDatasource = StructNew()>
		<cfset variables.lCoreModules = 'admin,comments,cron,general,installer,mail,user'>
		
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
			<cfquery name="qModules" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
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
		<cfset var qPermissionsLookup = 0>
		<cfset var sModelDirectory = ''>
		<cfset var sModelTarget = ''>
		<cfset var qModelFiles = 0>
		
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
			
			<cfset sModelDirectory = expandPath('modules/#stModuleConfig.data.info.folder#/model/')>
			
			<cfif directoryExists(sModelDirectory)>
				<cfdirectory action="list" directory="#sModelDirectory#" recurse="true" name="qModelFiles">
				
				<cfloop query="qModelFiles">
					<cfif qModelFiles.type EQ 'file' AND len(qModelFiles.directory)-len(sModelDirectory) GT 0>
						<cfset sModelTarget = expandPath('model/#right(qModelFiles.directory,len(qModelFiles.directory)-len(sModelDirectory))#/#qModelFiles.name#')>
					
						<cfif NOT directoryExists(getDirectoryFromPath(sModelTarget))>
							<cfdirectory action="create" directory="#getDirectoryFromPath(sModelTarget)#" mode="777">
						</cfif>
						<cffile action="copy" source="#qModelFiles.directory#/#qModelFiles.name#" destination="#sModelTarget#" mode="777">
					</cfif>
				</cfloop>
			</cfif>
		
			<cfset variables.stModules[arguments.folder] = stModuleConfig.data>

			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.reactor')#" method="createConfig"/>
	
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.fusebox')#" method="createConfig"/>
			
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE FROM core_modules
				WHERE folder = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
			</cfquery>
			
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				INSERT INTO core_modules (name, folder, version, date)
				VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.name#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.version#">,
						<cfqueryparam cfsqltype="cf_sql_timestamp" value="#stModuleConfig.data.info.date#">)
			</cfquery>
			
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
				DELETE FROM core_navigation
				WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
			</cfquery>
			
			<cfif stModuleConfig.data.general.createCircuit>
			
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					INSERT INTO core_navigation (module, action, level, sortorder, permissions)
					VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">,
							<cfqueryparam cfsqltype="cf_sql_varchar" value="main">,
							1,
							1,
							'')
				</cfquery>
				
				<cfloop collection="#stModuleConfig.data.navigation#" item="idxNavigation">
					<cfset iNavCounter = iNavCounter + 1>
					<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
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
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qPermissionLookup">
					SELECT id
					FROM core_security_permissions
					WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
					AND name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#idxPermissions#">
				</cfquery>
				<cfif NOT qPermissionLookup.recordcount>
					<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
						INSERT INTO core_security_permissions (name, module)
						VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#idxPermissions#">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">)
					</cfquery>
				</cfif>
			</cfloop>
			
			<cfloop collection="#stModuleConfig.data.security_roles#" item="idxRoles">
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qRoleLookup">
					SELECT id
					FROM core_security_roles
					WHERE module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
					AND name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.security_roles[idxRoles].name#">
				</cfquery>
				<cfif NOT qRoleLookup.recordcount>
					<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
						INSERT INTO core_security_roles (name, module)
						VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.security_roles[idxRoles].name#">,
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">)
					</cfquery>
				
					<cfquery name="qRoleLookup" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
						SELECT id
						FROM core_security_roles
						WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.security_roles[idxRoles].name#">
						AND module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
					</cfquery>
					
					<cfif qRoleLookup.recordcount>
					
						<cfquery name="qPermissionsLookup" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
							SELECT id
							FROM core_security_permissions
							WHERE name IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.security_roles[idxRoles].permissions#" list="true">)
							AND module = <cfqueryparam cfsqltype="cf_sql_varchar" value="#stModuleConfig.data.info.folder#">
						</cfquery>
						
						<cfif qPermissionsLookup.recordcount>
						
							<cfloop list="#ValueList(qPermissionsLookup.id)#" index="idxPermission">
								<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
									INSERT INTO core_security_roles_permissions_rel (permission_id, role_id)
									VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#idxPermission#">,
											<cfqueryparam cfsqltype="cf_sql_varchar" value="#qRoleLookup.id#">)
								</cfquery>
							</cfloop>
					
						</cfif>
					</cfif>
				</cfif>
			</cfloop>
			
			<!--- 
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
				</cfif> --->
				
		<cfelse>
		
			<cfset application.lanshock.oLogger.writeLog('core.modules','Invalid info.xml.cfm: #arguments.folder#','error')>
			<cfset uninstallModule(arguments.folder)>
		
		</cfif>
		
		<cfreturn stModuleConfig>
		
	</cffunction>

	<cffunction name="uninstallModule" output="false" returntype="void">
		<cfargument name="folder" type="string" required="true">

		<cfset StructDelete(variables.stModules,arguments.folder)>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.reactor')#" method="createConfig"/>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.frameworks.fusebox')#" method="createConfig"/>
	
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			DELETE FROM core_modules
			WHERE folder = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.folder#">
		</cfquery>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
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

			<cfcatch>
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

	<cffunction name="getNavigation" output="false" returntype="query">
		<cfargument name="lang" type="string" required="true">
		
		<cfset var stProperties = StructNew()>
		<cfset var qNavigation = QueryNew('no_column')>
		
		<cfif NOT application.lanshock.oCache.exists("navigation:#arguments.lang#")>
			<cfset qNavigation = duplicate(variables.qNavigation)>
		
			<cfloop query="qNavigation">
				<cfset stProperties = StructNew()>
				<cfif isLoaded(qNavigation.module) AND getModuleConfig(qNavigation.module).general.loadlanguagefile>
					<cftry>
						<cfinvoke component="#application.lanshock.oLanguage#" method="loadProperties" returnvariable="stProperties">
							<cfinvokeargument name="lang" value="#arguments.lang#">
							<cfinvokeargument name="file" value="modules/#qNavigation.module#/i18n/lang.properties">
						</cfinvoke>
						
						<cfif StructKeyExists(stProperties,'__globalmodule__navigation__'&qNavigation.action)>
							<cfset QuerySetCell(qNavigation,'label',stProperties['__globalmodule__navigation__'&qNavigation.action],qNavigation.currentrow)>
						<cfelseif qNavigation.action EQ 'main' AND qNavigation.level EQ 1>
							<cfset QuerySetCell(qNavigation,'label',stProperties['__globalmodule__name'],qNavigation.currentrow)>
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
			
		<cfquery name="qNavigation" datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
			SELECT *, action AS label
			FROM core_navigation
			ORDER BY module ASC, level ASC, sortorder ASC
		</cfquery>
		
		<cfset variables.qNavigation = qNavigation>
		
	</cffunction>

</cfcomponent>