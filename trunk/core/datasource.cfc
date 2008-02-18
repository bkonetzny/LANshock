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
		<cfargument name="sTable" type="string" required="true">
		<cfargument name="aStructure" type="array" required="true">
		
		<cfset var stLocal = StructNew()>
		<cfset stLocal.stTableStructureOld = getTableStructureOld(arguments.sTable)>
		
		<cfif StructIsEmpty(stLocal.stTableStructureOld)>
			<cfset stLocal.mode = 'create'>
		<cfelse>
			<cfset stLocal.mode = 'alter'>
		</cfif>
		
		<cfset stLocal.stTableData = parseTableStructure(arguments.aStructure)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource.mysql')#" method="generateSQL" returnvariable="stLocal.aSqlCode">
			<cfinvokeargument name="tablename" value="#lCase(arguments.sTable)#">
			<cfinvokeargument name="stTableData" value="#stLocal.stTableData#">
			<cfinvokeargument name="stTableStructureOld" value="#stLocal.stTableStructureOld#">
			<cfinvokeargument name="mode" value="#stLocal.mode#">
		</cfinvoke>
		
		<cfloop from="1" to="#ArrayLen(stLocal.aSqlCode)#" index="stLocal.idx">
			<cfset stLocal.sSqlCode = stLocal.aSqlCode[stLocal.idx]>
			<cftry>
				<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #stLocal.mode#, #application.lanshock.environment.datasource#.#arguments.sTable# | SQL: #stLocal.sSqlCode#">
				<cfquery datasource="#application.lanshock.environment.datasource#">
					#PreserveSingleQuotes(stLocal.sSqlCode)#
				</cfquery>
				<cfcatch type="any">
					<cffile action="append" file="#application.lanshock.environment.abspath#storage/secure/logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #stLocal.mode#, #application.lanshock.environment.datasource#.#arguments.sTable#, #cfcatch.message#: #cfcatch.Detail#">
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
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core.datasource.mysql')#" method="getVersionInformation" returnvariable="stLocal.sDbVersion">
			
			<cfreturn stLocal.sDbVersion>
			<cfcatch>
				<cfreturn 'Unknown'>
			</cfcatch>
		</cftry>
				
	</cffunction>

</cfcomponent>