<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/datasource.cfc $
$LastChangedDate: 2006-10-23 00:59:26 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 56 $
--->

<cfcomponent>

	<cffunction name="deployTable" output="false" returntype="struct">
		<cfargument name="stTableStructure" type="struct" required="true">
		
		<cfscript>
			var stLocal = StructNew();
			
			stLocal.tablename = listFirst(StructKeyList(arguments.stTableStructure));
			stLocal.stTableStructureOld = getTableStructureOld(stLocal.tablename);
			
			if(StructIsEmpty(stLocal.stTableStructureOld)) stLocal.mode = 'create';
			else stLocal.mode = 'alter';
			
			stLocal.stTableData = parseTableStructure(arguments.stTableStructure[stLocal.tablename]);
		</cfscript>
		
		<cfinvoke component="datasource_mysql" method="generateSQL" returnvariable="stLocal.aSqlCode">
			<cfinvokeargument name="tablename" value="#lCase(stLocal.tablename)#">
			<cfinvokeargument name="stTableData" value="#stLocal.stTableData#">
			<cfinvokeargument name="stTableStructureOld" value="#stLocal.stTableStructureOld#">
			<cfinvokeargument name="mode" value="#stLocal.mode#">
		</cfinvoke>
		
		<cfloop from="1" to="#ArrayLen(stLocal.aSqlCode)#" index="stLocal.idx">
			<cfset stLocal.sSqlCode = stLocal.aSqlCode[stLocal.idx]>
			<cftry>
				<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #stLocal.mode#, #application.lanshock.environment.datasource#.#stLocal.tablename# | SQL: #stLocal.sSqlCode#">
				<cfquery datasource="#application.lanshock.environment.datasource#">
					#PreserveSingleQuotes(stLocal.sSqlCode)#
				</cfquery>
				<cfcatch type="any">
					<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #stLocal.mode#, #application.lanshock.environment.datasource#.#stLocal.tablename#, #cfcatch.message#: #cfcatch.Detail#">
				</cfcatch>
			</cftry>
		</cfloop>
		
		<cfreturn stLocal.stTableData>
				
	</cffunction>

	<cffunction name="getTableStructureOld" output="false" returntype="struct">
		<cfargument name="tablename" type="string" required="true">
		
		<cfscript>
			var stLocal = StructNew();
			
			stLocal.idx = '';
			stLocal.aMetaData = '';
			stLocal.stTableStructureOld = StructNew();
		</cfscript>
		
		<cftry>
			<cfquery datasource="#application.lanshock.environment.datasource#" name="stLocal.qTableCheck" maxrows="0">
				SELECT * FROM #arguments.tablename#
			</cfquery>
			<cfset stLocal.aMetaData = GetMetaData(stLocal.qTableCheck)>
			
			<cfloop from="1" to="#ArrayLen(stLocal.aMetaData)#" index="stLocal.idx">
				<cfset stLocal.stTableStructureOld[stLocal.aMetaData[stLocal.idx].name] = stLocal.aMetaData[stLocal.idx].typename>
			</cfloop>

			<cfcatch>
				<cfset stLocal.stTableStructureOld = StructNew()>
			</cfcatch>
		</cftry>
		
		<cfreturn stLocal.stTableStructureOld>
				
	</cffunction>

	<cffunction name="parseTableStructure" output="false" returntype="struct">
		<cfargument name="aTableStructure" type="array" required="true">
		
		<cfscript>
			var stLocal = StructNew();
			
			stLocal.idx = '';
			stLocal.stTableData = StructNew();
			stLocal.stTableData.field = StructNew();
			stLocal.stTableData.pk = StructNew();
			stLocal.stTableData.fk = StructNew();
			stLocal.stTableData.index = StructNew();
		</cfscript>

		<cfloop from="1" to="#ArrayLen(arguments.aTableStructure)#" index="stLocal.idx">
		
			<cfscript>
				if(arguments.aTableStructure[stLocal.idx].xmlname EQ "field")
					stLocal.stTableData.field[arguments.aTableStructure[stLocal.idx].xmlattributes.name] = arguments.aTableStructure[stLocal.idx].xmlattributes;

				if(arguments.aTableStructure[stLocal.idx].xmlname EQ "pk")
					stLocal.stTableData.pk[arguments.aTableStructure[stLocal.idx].xmlattributes.fields] = arguments.aTableStructure[stLocal.idx].xmlattributes;

				if(arguments.aTableStructure[stLocal.idx].xmlname EQ "fk")
					stLocal.stTableData.fk[arguments.aTableStructure[stLocal.idx].xmlattributes.field] = arguments.aTableStructure[stLocal.idx].xmlattributes;

				if(arguments.aTableStructure[stLocal.idx].xmlname EQ "index")
					stLocal.stTableData.index[arguments.aTableStructure[stLocal.idx].xmlattributes.name] = arguments.aTableStructure[stLocal.idx].xmlattributes;
			</cfscript>
		
		</cfloop>
		
		<cfreturn stLocal.stTableData>
				
	</cffunction>

	<cffunction name="getVersionInformation" output="false" returntype="string">

		<cfset var stLocal = StructNew()>
		
		<cftry>
			<cfinvoke component="datasource_mysql" method="getVersionInformation" returnvariable="stLocal.sDbVersion">
			
			<cfreturn stLocal.sDbVersion>
			<cfcatch>
				<cfreturn 'Unknown'>
			</cfcatch>
		</cftry>
				
	</cffunction>
	
	<cffunction name="createTransferConfig" output="false" returntype="boolean">
		<cfargument name="stDatasourceSchema" type="struct" required="true">

		<cfset var sTransferXml = ''>
		<cfset var sPackages = ''>
		<cfset var item = ''>
		<cfset var idxPk = ''>
		<cfset var idxField = ''>
		<cfset var sFieldType = ''>
		<cfset var iIDCount = 0>
		
		<cfloop list="#ListSort(StructKeyList(arguments.stDatasourceSchema),'textnocase')#" index="item">
		
			<cfset item = lCase(item)>
			<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & '<package name="#item#">'>
			<cfset sPackages = sPackages & chr(13) & chr(9) & chr(9) & chr(9) & '<object name="#item#" table="#item#">'>
			<cfset iIDCount = 0>
			<cfif StructKeyExists(arguments.stDatasourceSchema[item],'pk')>
				<cfloop list="#StructKeyList(arguments.stDatasourceSchema[item].pk)#" index="idxPk">
					<cfset idxPk = lCase(idxPk)>
					<cfswitch expression="#arguments.stDatasourceSchema[item].field[idxPk].type#">
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
							<cfthrow message="Error: Couldn't map '#arguments.stDatasourceSchema[item].field[idxPk].type#' to a transfer datatype.">
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
			<cfloop list="#StructKeyList(arguments.stDatasourceSchema[item].field)#" index="idxField">
				<cfset idxField = lCase(idxField)>
				<cfswitch expression="#arguments.stDatasourceSchema[item].field[idxField].type#">
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
						<cfthrow message="Error: Couldn't map '#arguments.stDatasourceSchema[item].field[idxField].type#' to a transfer datatype.">
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
<transfer xsi:noNamespaceSchemaLocation="/transfer/resources/xsd/transfer.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<!--
	generated by LANshock at #now()#
-->
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
		
		<cffile action="write" file="#application.lanshock.environment.abspath#config/transfer/transfer.xml.cfm" output="#trim(sTransferXml)#" mode="777" addnewline="false">
		
		<cfreturn true>
				
	</cffunction>

</cfcomponent>