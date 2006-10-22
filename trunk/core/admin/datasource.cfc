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
		<cfargument name="stTableStructure" type="struct" required="true">
		
		<cfscript>
			var stLocal = StructNew();
			
			stLocal.tablename = listFirst(StructKeyList(arguments.stTableStructure));
			stLocal.stTableStructureOld = getTableStructureOld(stLocal.tablename);
			
			if(StructIsEmpty(stLocal.stTableStructureOld)) stLocal.mode = 'create';
			else stLocal.mode = 'alter';
			
			stLocal.stTableData = parseTableStructure(arguments.stTableStructure[stLocal.tablename]);
		</cfscript>
		
		<cfinvoke component="datasource_mysql" method="generateSQL" returnvariable="stLocal.sSqlCode">
			<cfinvokeargument name="tablename" value="#stLocal.tablename#">
			<cfinvokeargument name="stTableData" value="#stLocal.stTableData#">
			<cfinvokeargument name="stTableStructureOld" value="#stLocal.stTableStructureOld#">
			<cfinvokeargument name="mode" value="#stLocal.mode#">
		</cfinvoke>
		
		<cftry>
			<cfif listFirst(server.coldfusion.productversion) GTE 7>
				<cfinclude template="act_datasource_cfc_query_log.cfm">
			<cfelse>
				<cfinclude template="act_datasource_cfc_query_nolog.cfm">
			</cfif>
			
			<cfcatch type="any">
				<cffile action="append" file="#application.lanshock.environment.abspath#logs/core_setup_datasource.log" output="#cgi.remote_addr# - [#DateFormat(now(),"yyyy-mm-dd")# #TimeFormat(now(),"hh:mm:ss")#] #stLocal.mode#, #application.lanshock.environment.datasource#.#stLocal.tablename#, #cfcatch.message#: #cfcatch.Detail#">
			</cfcatch>
		</cftry>
		
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
			stLocal.stTableData.index = StructNew();
		</cfscript>

		<cfloop from="1" to="#ArrayLen(arguments.aTableStructure)#" index="stLocal.idx">
		
			<cfscript>
				if(arguments.aTableStructure[stLocal.idx].xmlname EQ "field")
					// stLocal.stTableData.field[stLocal.idx] = arguments.aTableStructure[stLocal.idx].xmlattributes;
					stLocal.stTableData.field[arguments.aTableStructure[stLocal.idx].xmlattributes.name] = arguments.aTableStructure[stLocal.idx].xmlattributes;

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

</cfcomponent>