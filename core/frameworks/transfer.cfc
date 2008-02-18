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

		<cfset var sTransferXml = ''>
		<cfset var sTransferDbXml = ''>
		<cfset var sPackages = ''>
		<cfset var item = ''>
		<cfset var idxPk = ''>
		<cfset var idxField = ''>
		<cfset var sFieldType = ''>
		<cfset var iIDCount = 0>
		<cfset var stDatasource = StructNew()>
		<cfset var stRuntimeConfig = application.lanshock.oRuntime.getRuntimeConfig()>
		
		<cfinvoke component="#application.lanshock.oModules#" method="getDatasourceStructure" returnvariable="stDatasource"/>
		
		<cfloop list="#ListSort(StructKeyList(stDatasource),'textnocase')#" index="item">
		
			<cfset item = lCase(item)>
			<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & '<package name="#item#">'>
			<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & chr(9) & '<object name="#item#" table="#item#">'>
			<cfset iIDCount = 0>
			<cfif StructKeyExists(stDatasource[item],'pk')>
				<cfloop list="#StructKeyList(stDatasource[item].pk)#" index="idxPk">
					<cfset idxPk = lCase(idxPk)>
					<cfswitch expression="#stDatasource[item].field[idxPk].type#">
						<cfcase value="integer,float,boolean,double">
							<cfset sFieldType = 'numeric'>
						</cfcase>
						<cfcase value="text,varchar">
							<cfset sFieldType = 'string'>
						</cfcase>
						<cfcase value="datetime">
							<cfset sFieldType = 'date'>
						</cfcase>
						<cfdefaultcase>
							<cfthrow message="Error: Couldn't map '#stDatasource[item].field[idxPk].type#' to a transfer datatype.">
						</cfdefaultcase>
					</cfswitch>
					<cfset iIDCount = iIDCount + 1>
					<cfif iIDCount EQ 1>
						<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & chr(9) & chr(9) & '<id name="#idxPk#" type="#sFieldType#" />'>
					<cfelse>
						<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & chr(9) & chr(9) & '<!-- <id name="#idxPk#" type="#sFieldType#" /> -->'>
					</cfif>
				</cfloop>
			</cfif>
			<cfloop list="#StructKeyList(stDatasource[item].field)#" index="idxField">
				<cfset idxField = lCase(idxField)>
				<cfswitch expression="#stDatasource[item].field[idxField].type#">
					<cfcase value="integer,float,boolean,double">
						<cfset sFieldType = 'numeric'>
					</cfcase>
					<cfcase value="text,varchar">
						<cfset sFieldType = 'string'>
					</cfcase>
					<cfcase value="datetime">
						<cfset sFieldType = 'date'>
					</cfcase>
					<cfdefaultcase>
						<cfthrow message="Error: Couldn't map '#stDatasource[item].field[idxField].type#' to a transfer datatype.">
					</cfdefaultcase>
				</cfswitch>
				<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & chr(9) & chr(9) & '<property name="#idxField#" column="#idxField#" type="#sFieldType#" />'>
			</cfloop>
			<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & chr(9) & '</object>'>
			<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & '</package>'>
		
		</cfloop>
		
		<cfsavecontent variable="sTransferXml">
			<cfoutput>
<?xml version="1.0" encoding="UTF-8"?>
<!-- generated by LANshock at #now()# -->
<transfer xsi:noNamespaceSchemaLocation="/transfer/resources/xsd/transfer.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<objectCache>
		<scopes>
			<application key="transfer"/>
			<request key="transfer"/>
		</scopes>
		<defaultcache>
			<maxminutespersisted value="60"/>
			<scope type="instance"/>
		</defaultcache>
		<cache class="Basic">
			<maxobjects value="5000"/>
			<scope type="application"/>
		</cache>
		<cache class="AutoGenerate">
			<maxobjects value="5"/>
			<!-- <maxminutespersisted value="1"/> -->
			<scope type="request"/>
		</cache>
		<cache class="trans.Transaction">
			<scope type="transaction"/>
		</cache>
		<cache class="none.Basic">
			<scope type="none"/>
		</cache>
		<cache class="none.Child">
			<scope type="none"/>
		</cache>
	</objectCache>
	<nullValues>
		<numeric value="0" />
		<date value="1-1-1900"/>
		<boolean value="-1" />
		<UUID value="10000000-0000-0000-0000000000000000" />
		<GUID value="10000000-0000-0000-0000-000000000000" />
	</nullValues>
	<objectDefinitions>#sPackages#
	</objectDefinitions>
</transfer>
			</cfoutput>
		</cfsavecontent>
		
		<cffile action="write" file="#application.lanshock.sStoragePath#secure/config/transfer/transfer.xml.cfm" output="#trim(sTransferXml)#" mode="777">

		<cfsavecontent variable="sTransferDbXml">
			<cfoutput>
<?xml version="1.0" encoding="UTF-8"?>
<!-- generated by LANshock at #now()# -->
<datasource xsi:noNamespaceSchemaLocation="../transfer/resources/xsd/datasource.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<name>#stRuntimeConfig.lanshock.datasource#</name>
	<username/>
	<password/>
</datasource>
			</cfoutput>
		</cfsavecontent>
		
		<cffile action="write" file="#application.lanshock.sStoragePath#secure/config/transfer/datasource.xml.cfm" output="#trim(sTransferDbXml)#" mode="777">
		
	</cffunction>
	
	<cffunction name="reload" output="false" returntype="void">
		
		
	
	</cffunction>

</cfcomponent>