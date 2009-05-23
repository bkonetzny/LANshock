<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="deployTable" output="false" returntype="struct">
		<cfargument name="sTable" type="string" required="true">
		<cfargument name="aStructure" type="array" required="true">
		
		<cfset var sTableName = lCase(arguments.sTable)>
		<cfset var stLocal = StructNew()>
		<cfset stLocal.stTableStructureOld = getTableStructureOld(sTableName)>
		
		<cfif StructIsEmpty(stLocal.stTableStructureOld)>
			<cfset stLocal.mode = 'create'>
		<cfelse>
			<cfset stLocal.mode = 'alter'>
		</cfif>
		
		<cfset stLocal.stTableData = parseTableStructure(arguments.aStructure)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource.mysql')#" method="generateSQL" returnvariable="stLocal.aSqlCode">
			<cfinvokeargument name="tablename" value="#sTableName#">
			<cfinvokeargument name="stTableData" value="#stLocal.stTableData#">
			<cfinvokeargument name="stTableStructureOld" value="#stLocal.stTableStructureOld#">
			<cfinvokeargument name="mode" value="#stLocal.mode#">
		</cfinvoke>
		
		<cfloop from="1" to="#ArrayLen(stLocal.aSqlCode)#" index="stLocal.idx">
			<cfset stLocal.sSqlCode = stLocal.aSqlCode[stLocal.idx]>
			<cftry>
				<cfset application.lanshock.oLogger.writeLog('core.datasource','Deploying table "#application.lanshock.oRuntime.getEnvironment().sDatasource#.#sTableName#" | Mode: "#stLocal.mode#" | SQL: #stLocal.sSqlCode#')>
				<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#">
					#PreserveSingleQuotes(stLocal.sSqlCode)#
				</cfquery>
				<cfcatch>
					<cfset application.lanshock.oLogger.writeLog('core.datasource','SQL Error for table "#application.lanshock.oRuntime.getEnvironment().sDatasource#.#sTableName#" | Message: "#cfcatch.message#" | Detail: "#cfcatch.detail#" | SQL: "#stLocal.sSqlCode#"','error')>
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
			<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="stLocal.qTableCheck" maxrows="0">
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
			stLocal.stTableData.field = ArrayNew(1);
			stLocal.stTableData.pk = ArrayNew(1);
			stLocal.stTableData.fk = ArrayNew(1);
			stLocal.stTableData.index = ArrayNew(1);
			stLocal.stTableData.engine = ArrayNew(1);
		</cfscript>

		<cfloop from="1" to="#ArrayLen(arguments.aTableStructure)#" index="stLocal.idx">

			<cfswitch expression="#arguments.aTableStructure[stLocal.idx].xmlname#">
				<cfcase value="field">
					<cfset ArrayAppend(stLocal.stTableData.field,arguments.aTableStructure[stLocal.idx].xmlattributes)>
				</cfcase>
				<cfcase value="pk">
					<cfset ArrayAppend(stLocal.stTableData.pk,arguments.aTableStructure[stLocal.idx].xmlattributes)>
				</cfcase>
				<cfcase value="fk">
					<cfset ArrayAppend(stLocal.stTableData.fk,arguments.aTableStructure[stLocal.idx].xmlattributes)>
				</cfcase>
				<cfcase value="index">
					<cfset ArrayAppend(stLocal.stTableData.index,arguments.aTableStructure[stLocal.idx].xmlattributes)>
				</cfcase>
				<cfcase value="engine">
					<cfset ArrayAppend(stLocal.stTableData.engine,arguments.aTableStructure[stLocal.idx].xmlattributes)>
				</cfcase>
			</cfswitch>
		
		</cfloop>
		
		<cfreturn stLocal.stTableData>
				
	</cffunction>

	<cffunction name="getVersionInformation" output="false" returntype="string">

		<cfset var stLocal = StructNew()>
		
		<cftry>
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource.mysql')#" method="getVersionInformation" returnvariable="stLocal.sDbVersion">
			
			<cfreturn stLocal.sDbVersion>
			<cfcatch>
				<cfreturn 'Unknown'>
			</cfcatch>
		</cftry>
				
	</cffunction>

</cfcomponent>