<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>

	<cffunction name="getVersionInformation" output="false" returntype="string">

		<cfset var stLocal = StructNew()>
		
		<cfquery datasource="#application.lanshock.environment.datasource#" name="stLocal.qInfo">
			SHOW VARIABLES
		</cfquery>
		
		<cfquery dbtype="query" name="stLocal.qVersion">
			SELECT * FROM stLocal.qInfo WHERE variable_name = 'version'
		</cfquery>
		
		<cfreturn stLocal.qVersion.value>
				
	</cffunction>

	<cffunction name="generateSQL" output="false" returntype="string">
		<cfargument name="tablename" type="string" required="true">
		<cfargument name="stTableData" type="struct" required="true">
		<cfargument name="stTableStructureOld" type="struct" required="true">
		<cfargument name="mode" type="string" required="true">
		
		<cfscript>
			var stLocal = StructNew();
			
			stLocal.sSqlCode = "";
			stLocal.idx = '';
	
			switch(arguments.mode) {
				case "create":
					stLocal.sSqlCode = "CREATE TABLE `#arguments.tablename#` (";
				break;
				case "alter":
					stLocal.sSqlCode = "ALTER TABLE `#arguments.tablename#` ";
				break;
			}
		</cfscript>
		
		<cfloop list="#listSort(StructKeyList(arguments.stTableData.field),'textnocase')#" index="stLocal.idx">
			
			<cfset stLocal.stTableDataTmp = StructNew()>
			
			<cfloop collection="#arguments.stTableData.field[stLocal.idx]#" item="stLocal.idx2">
				<cfset stLocal.stTableDataTmp[stLocal.idx2] = arguments.stTableData.field[stLocal.idx][stLocal.idx2]>
			</cfloop>
			<cfset stLocal.stTableDataTmp.mode = arguments.mode>
			<cfset stLocal.stTableDataTmp.stTableStructureOld = arguments.stTableStructureOld>
			
			<cfinvoke method="buildFieldString" returnvariable="stLocal.sFieldString" argumentcollection="#stLocal.stTableDataTmp#">

			<cfset stLocal.sSqlCode = stLocal.sSqlCode & stLocal.sFieldString>
		
		</cfloop>
		
		<cfif arguments.mode EQ 'create'>
			<cfloop list="#listSort(StructKeyList(arguments.stTableData.index,';'),'textnocase','ASC',';')#" index="stLocal.idx" delimiters=";">
				
				<cfinvoke method="buildIndexString" returnvariable="stLocal.sIndexString" argumentcollection="#arguments.stTableData.index[stLocal.idx]#">
	
				<cfscript>
					stLocal.sSqlCode = stLocal.sSqlCode & stLocal.sIndexString & ',';
				</cfscript>
			
			</cfloop>
		</cfif>
		
		<cfscript>
			stLocal.sSqlCode = left(stLocal.sSqlCode,len(stLocal.sSqlCode)-1);
			
			if(arguments.mode EQ 'create') stLocal.sSqlCode = stLocal.sSqlCode & ")";
		</cfscript>
		
		<cfreturn stLocal.sSqlCode>
				
	</cffunction>

	<cffunction name="buildFieldString" output="false" returntype="string">
		<cfargument name="name" type="string" required="true">
		<cfargument name="type" type="string" required="true">
		<cfargument name="len" type="numeric" required="false" default="0">
		<cfargument name="default" type="string" required="false">
		<cfargument name="null" type="boolean" required="false" default="false">
		<cfargument name="special" type="string" required="false" default="">
		<cfargument name="mode" type="string" required="true">
		<cfargument name="stTableStructureOld" type="struct" required="true">
		
		<!--- <cfif NOT StructKeyExists(arguments,'default')>
			<cfdump var="#arguments#"><cfabort>
		</cfif> --->
		
		<cfscript>
			var stLocal = StructNew();

			stLocal.fieldtypepmappings = StructNew();
			stLocal.fieldtypepmappings.integer = 'int';
			stLocal.fieldtypepmappings.text = 'text';
			stLocal.fieldtypepmappings.boolean = 'tinyint(1)';
			
			if(StructKeyExists(stLocal.fieldtypepmappings,arguments.type)) stLocal.sFieldTypeString = stLocal.fieldtypepmappings[arguments.type];
			else stLocal.sFieldTypeString = arguments.type;
			
			if(len(arguments.len) AND arguments.len NEQ 0) stLocal.sLenString = '(#arguments.len#)';
			else stLocal.sLenString = '';
			
			if(arguments.null) stLocal.sNullString = 'NULL';
			else stLocal.sNullString = 'NOT NULL';
			
			if(NOT StructKeyExists(arguments,'default')) stLocal.sDefaultString = "";
			else {
				if(stLocal.sNullString EQ 'NULL' AND arguments.default EQ 'NULL') stLocal.sDefaultString = " default NULL";
				else stLocal.sDefaultString = " default '#arguments.default#'";
			}
			
			if(len(arguments.special)) stLocal.sSpecialString = " #arguments.special#";
			else stLocal.sSpecialString = '';
			
			// fix for the "Value '0000-00-00' can not be represented as java.sql.Timestamp" Bug 
			if(stLocal.sFieldTypeString EQ 'datetime' AND arguments.default EQ '0000-00-00 00:00:00'){
				stLocal.sNullString = 'NULL';
				stLocal.sDefaultString = " default NULL";
			}
			
			switch(arguments.mode) {
				case "create":
					stLocal.sFieldString = "`#arguments.name#` #stLocal.sFieldTypeString##stLocal.sLenString# #stLocal.sNullString##stLocal.sDefaultString##stLocal.sSpecialString#,";
				break;
				case "alter":
					if(StructKeyExists(arguments.stTableStructureOld,arguments.name))
						stLocal.sFieldString = "CHANGE `#arguments.name#` `#arguments.name#` #stLocal.sFieldTypeString##stLocal.sLenString# #stLocal.sNullString##stLocal.sDefaultString##stLocal.sSpecialString#,";
					else stLocal.sFieldString = "ADD `#arguments.name#` #stLocal.sFieldTypeString##stLocal.sLenString# #stLocal.sNullString##stLocal.sDefaultString##stLocal.sSpecialString#,";
				break;
			}
		</cfscript>
		
		<cfreturn stLocal.sFieldString>
				
	</cffunction>

	<cffunction name="buildIndexString" output="false" returntype="string">
		<cfargument name="name" type="string" required="true">
		<cfargument name="value" type="string" required="false" default="">
		
		<cfscript>
			var stLocal = StructNew();
			
			stLocal.sIndexString = "PRIMARY KEY (";
		</cfscript>
		
		<cfloop from="1" to="#ListLen(arguments.name)#" index="stLocal.idx">
			<cfscript>
				stLocal.sIndexString = stLocal.sIndexString & "`#ListGetAt(arguments.name,stLocal.idx)#`";
				
				if(stLocal.idx EQ listLen(arguments.name)) stLocal.sIndexString = stLocal.sIndexString & ')';
				else stLocal.sIndexString = stLocal.sIndexString & ',';
			</cfscript>
		</cfloop>
		
		<cfreturn stLocal.sIndexString>
				
	</cffunction>

</cfcomponent>