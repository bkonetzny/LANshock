<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/setup.cfc $
$LastChangedDate: 2007-09-30 14:43:42 +0200 (So, 30 Sep 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 103 $
--->

<cfcomponent>

	<cffunction name="initModules" output="false" returntype="boolean">
		<cfargument name="stModules" type="struct" required="true">
		
		<cfset var stLocal = StructNew()>
		
		<cfif FileExists(application.lanshock.environment.abspath & "config/modules.xml.cfm")>
			<cffile action="DELETE" file="#application.lanshock.environment.abspath#config/modules.xml.cfm">
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
					<cfset application.datasource[idx2] = stTableData>
				</cfloop>
			</cfif>

			<cfset StructDelete(stModules[idx], 'db')>
			
		</cfloop>
		
		<cfloop collection="#stModules#" item="idx">
		
			<cfparam name="stModules['#idx#'].cron" default="">
			
			<cfif application.lanshock.config.complete>
				<!--- Create Datasource Tables --->
				<!--- <cfif isStruct(stModules[idx].cron) AND NOT StructIsEmpty(stModules[idx].cron)>
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
			</cfif>
			
		</cfloop>
		
		<cfparam name="application.datasource" default="#StructNew()#">

		<cfinvoke component="datasource" method="createTransferConfig">
			<cfinvokeargument name="stDatasourceSchema" value="#application.datasource#">
		</cfinvoke>
		
		<cfwddx action="CFML2WDDX" input="#application.datasource#" output="DatasourceWDDX" usetimezoneinfo="false">
		
		<cfif NOT directoryExists('#application.lanshock.environment.abspath#config/')>
			<cfdirectory action="create" directory="#application.lanshock.environment.abspath#config/" mode="777">		
		</cfif>
		
		<cffile action="WRITE" file="#application.lanshock.environment.abspath#config/datasource.xml.cfm" output="#DatasourceWDDX#" mode="777" nameconflict="OVERWRITE">
		
		<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] *** END DB UPDATE">
		
		<cfset application.module = stModules>
		
		<cfwddx action="CFML2WDDX" input="#stModules#" output="ModuleWDDX" usetimezoneinfo="false">
		
		<cffile action="WRITE" file="#application.lanshock.environment.abspath#config/modules.xml.cfm" output="#ModuleWDDX#" mode="777" nameconflict="OVERWRITE">
		
		<cfif request.lanshock.settings.cache.circuitfiles>
			<cfset fuseboxmode = "production">
		<cfelse>
			<cfset fuseboxmode = "development">
		</cfif>
		
		<cfset sCircuits = ''>
		<cfloop list="#listSort(StructKeyList(stModules),'textnocase')#" index="item">
			<cfif stModules[item].general.createCircuit>
				<cfscript>
					item = lCase(item);
					sDir = stModules[item].dir;
					sModuleDir = "modules";
				</cfscript>
				<cfif directoryExists('#application.lanshock.environment.abspath#modules/#sDir#/controller/')>
					<cfset sCircuits = sCircuits & chr(13) & chr(9) & chr(9) & '<circuit alias="m_#sDir#" path="#sModuleDir#/#sDir#/model"/>'>
					<cfset sCircuits = sCircuits & chr(13) & chr(9) & chr(9) & '<circuit alias="v_#sDir#" path="#sModuleDir#/#sDir#/view"/>'>
					<cfset sCircuits = sCircuits & chr(13) & chr(9) & chr(9) & '<circuit alias="c_#sDir#" path="#sModuleDir#/#sDir#/controller"/>'>
				<cfelse>
					<cfset sCircuits = sCircuits & chr(13) & chr(9) & chr(9) & '<circuit alias="#item#" path="#sModuleDir#/#sDir#/"/>'>
				</cfif>
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
		<parameter name="defaultFuseaction" value="c_general.welcome"/>
		<parameter name="mode" value="#fuseboxmode#"/>
		<parameter name="strictMode" value="true"/>
		<parameter name="password" value="#sNewFuseboxPassword#"/>
		<parameter name="characterEncoding" value="utf-8"/>
		<parameter name="debug" value="false"/>
		<parameter name="allowImplicitCircuits" value="true"/>
	</parameters>

	<globalfuseactions>
		<appinit>
			<fuseaction action="core_runtime.transferSetup"/>
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
		
		<!--- force LanguageCache to refresh --->
		<cfset application.lanshock.cache.language = StructNew()>

		<cffile action="write" file="#application.lanshock.environment.abspath#fusebox.xml.cfm" output="#trim(sFuseboxXml)#" mode="777" addnewline="false">

		<cfset reloadFusebox()>
		
		<cfreturn true>
				
	</cffunction>

	<cffunction name="initCoreModules" output="false">
		
		<cfset var stCore = getModulesByType(type='core')>
		<cfset stCore = getModuleSettings(stModules=stCore)>
		<cfset initModules(stModules=stCore)>
		
	</cffunction>

	<cffunction name="getModulesByType" output="false" returntype="struct">
		<cfargument name="type" type="string" required="false" default="module">

		<cfset var stModules = StructNew()>
		<cfset var qModules = 0>
		<cfset var sName = ''>
		<cfset var lCoreModules = 'admin,comments,cron,general,installer,mail,team,user'>
		
		<cfdirectory action="LIST" directory="#application.lanshock.environment.abspath#modules/" name="qModules" sort="name ASC">
		
		<cfloop query="qModules">
			<cfscript>
				if(qModules.type EQ "dir"
					AND (
						arguments.type EQ "core" AND ListFind(lCoreModules,qModules.name)
						OR arguments.type EQ "module" AND NOT ListFind(lCoreModules,qModules.name)
					)
					AND fileExists(application.lanshock.environment.abspath & "modules/" & qModules.name & "/info.xml.cfm")){
					sName = lCase(qModules.name);
					stModules['c_'&sName] = StructNew();
					stModules['c_'&sName].name = sName;
					stModules['c_'&sName].dir = sName;
					stModules['c_'&sName].module_path_abs = application.lanshock.environment.abspath & "modules/" & sName & "/";
					stModules['c_'&sName].module_path_rel = "modules/" & sName & "/";
					stModules['c_'&sName].module_path_web = application.lanshock.environment.webpath & "modules/" & sName & "/";
					stModules['c_'&sName].type = arguments.type;
				}
			</cfscript>
		</cfloop>
		
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

		<cfscript>
			// get Modules
			var stModules = getModulesByType('module');
			
			// get Core Modules
			var stCoreModules = getModulesByType('core');
			
			// merge both Structs
			StructAppend(stModules, stCoreModules, "true");
		</cfscript>
		
		<!--- Delete Unselected Modules --->
		<cfloop collection="#stModules#" item="idx">
			<cfscript>
				if(NOT ListFindNoCase(lActiveModules,idx)) StructDelete(stModules, idx);
			</cfscript>
		</cfloop>
		
		<cfscript>
			// Get Selected Modules
			stModules = getModuleSettings(stModules);
			
			// Initialize selected Modules
			initModules(stModules);
			
			return true;
		</cfscript>

	</cffunction>

	<cffunction name="reloadFusebox" output="false" returntype="void">

		<cfset StructDelete(application,'lanshock')>
		<cfset StructDelete(application,'fusebox')>

	</cffunction>

</cfcomponent>