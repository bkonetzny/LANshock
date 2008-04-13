<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/setup.cfc $
$LastChangedDate: 2007-09-30 14:43:42 +0200 (So, 30 Sep 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 103 $
--->

<cfcomponent>
	
	<cffunction name="createConfig" output="false" returntype="void">

		<cfset var sConfig = ''>
		<cfset var sObjectsXML = ''>
		<cfset var idxTables = ''>
		<cfset var idxFields = ''>
		<cfset var stDatasource = StructNew()>
		<cfset var stModuleConfig = StructNew()>
		<cfset var stReactorCustom = StructNew()>
		<cfset var sReactorCustom = ''>
		<cfset var idxReactorTables = ''>
		<cfset var stRuntimeConfig = application.lanshock.oRuntime.getRuntimeConfig()>
		<cfset var bLoadFields = true>
		<cfset var qProjectFiles = 0>
		
		<cfinvoke component="#application.lanshock.oModules#" method="getDatasourceStructure" returnvariable="stDatasource"/>

		<cfloop collection="#stDatasource#" item="idxTables">
			<cfset idxTables = LCase(idxTables)>
			<cfset sReactorCustom = ''>
			<cfset bLoadFields = true>
			
			<cfif StructKeyExists(stDatasource[idxTables],'module')>
				<cfinvoke component="#application.lanshock.oModules#" method="loadModuleInfoXml" returnvariable="stModuleConfig">
					<cfinvokeargument name="folder" value="#stDatasource[idxTables].module#">
				</cfinvoke>
				
				<cfif stModuleConfig.status
					AND NOT StructIsEmpty(stModuleConfig.data.special)
					AND StructKeyExists(stModuleConfig.data.special,'reactor')>
						
					<cfset stReactorCustom = stModuleConfig.data.special.reactor>
					
					<cfloop from="1" to="#ArrayLen(stReactorCustom.XmlChildren)#" index="idxReactorTables">
						<cfif stReactorCustom.XmlChildren[idxReactorTables].XmlAttributes.name EQ idxTables>
							<cfset sReactorCustom = stReactorCustom.XmlChildren[idxReactorTables].XmlText>
							<cfif StructKeyExists(stReactorCustom.XmlChildren[idxReactorTables].XmlAttributes,'loadFields')
									AND isBoolean(stReactorCustom.XmlChildren[idxReactorTables].XmlAttributes.loadFields)>
								<cfset bLoadFields = stReactorCustom.XmlChildren[idxReactorTables].XmlAttributes.loadFields>
							</cfif>
						</cfif>
					</cfloop>
				</cfif>
			</cfif>
			
			<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & '<object name="#idxTables#" alias="#idxTables#">'>
			<cfif bLoadFields>
				<cfloop from="1" to="#ArrayLen(stDatasource[idxTables].field)#" index="idxFields">
					<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & chr(9) & '<field alias="#stDatasource[idxTables].field[idxFields].name#" name="#stDatasource[idxTables].field[idxFields].name#"/>'>
				</cfloop>
			</cfif>
			<cfif len(sReactorCustom)>
				<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & chr(9) & trim(sReactorCustom)>
			</cfif>
			<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & '</object>'>
		</cfloop>

		<cfsavecontent variable="sConfig">
			<cfoutput>
<?xml version="1.0" encoding="UTF-8"?>
<!-- generated by LANshock at #now()# -->
<!DOCTYPE reactor SYSTEM "Reactor.dtd">
<reactor>
	<config>
		<project value="lanshock"/>
		<dsn value="#stRuntimeConfig.lanshock.datasource#"/>
		<type value="#stRuntimeConfig.lanshock.datasource_type#"/>
		<mapping value="/lanshock/model"/>
		<mode value="production"/>
		<username value=""/>
		<password value=""/>
	</config>
	<objects>
		#trim(sObjectsXML)#
	</objects>
</reactor>
			</cfoutput>
		</cfsavecontent>
		
		<cffile action="write" file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/config/reactor/reactor.xml" output="#trim(sConfig)#" mode="777">
		
		<cfdirectory action="list" name="qProjectFiles" directory="#expandPath('framework/reactor/project/lanshock/')#" recurse="true" filter="*.cfm">
		
		<cfloop query="qProjectFiles">
			<cffile action="delete" file="#qProjectFiles.directory#/#qProjectFiles.name#">
		</cfloop>
		
		<cfdirectory action="list" name="qProjectFiles" directory="#expandPath('framework/reactor/project/lanshock/')#" recurse="true" filter="*.cfc">
		
		<cfloop query="qProjectFiles">
			<cffile action="delete" file="#qProjectFiles.directory#/#qProjectFiles.name#">
		</cfloop>
		
	</cffunction>

</cfcomponent>