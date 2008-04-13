<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/datasource_mysql.cfc $
$LastChangedDate: 2006-11-04 00:16:55 +0100 (Sa, 04 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 78 $
--->

<cfcomponent>

	<cffunction name="getVersionInformation" output="false" returntype="string">

		<cfset var stLocal = StructNew()>
		
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="stLocal.qInfo">
			SHOW VARIABLES
		</cfquery>
		
		<cfquery dbtype="query" name="stLocal.qVersion">
			SELECT * FROM stLocal.qInfo WHERE variable_name = 'version'
		</cfquery>
		
		<cfreturn stLocal.qVersion.value>
				
	</cffunction>

	<cffunction name="generateSQL" output="false" returntype="array">
		<cfargument name="tablename" type="string" required="true">
		<cfargument name="stTableData" type="struct" required="true">
		<cfargument name="stTableStructureOld" type="struct" required="true">
		<cfargument name="mode" type="string" required="true">
		
		<cfset var aQueries = ArrayNew(1)>
		<cfset var sSql = ''>
		<cfset var idx = 0>
	
		<cfset variables.stData = StructNew()>
		<cfset variables.stData.aSqlPreprocess = ArrayNew(1)>
		<cfset variables.stData.aSqlPk = ArrayNew(1)>
		<cfset variables.stData.aSqlFk = ArrayNew(1)>
		<cfset variables.stData.aSqlIndex = ArrayNew(1)>
		<cfset variables.stData.aSqlFields = ArrayNew(1)>
		<cfset variables.tablename = arguments.tablename>
		<cfset variables.stTableData = arguments.stTableData>
		<cfset variables.stTableStructureOld = arguments.stTableStructureOld>
		<cfset variables.mode = arguments.mode>
		<cfset variables.engine = "MyISAM">
		
		<cfset detectEngine()>
		<cfset buildPkArray()>
		<cfset buildFkArray()>
		<cfset buildIndexArray()>
		<cfset buildFieldsArray()>
		
		<cfloop from="1" to="#ArrayLen(variables.stData.aSqlPreprocess)#" index="idx">
			<cfif variables.mode EQ 'create'>
				<cfset ArrayAppend(aQueries,"CREATE TABLE `#arguments.tablename#` " & variables.stData.aSqlPreprocess[idx])>
			<cfelseif variables.mode EQ 'alter'>
				<cfset ArrayAppend(aQueries,"ALTER TABLE `#arguments.tablename#` " & variables.stData.aSqlPreprocess[idx])>
			</cfif>
		</cfloop>
		
		<cfif variables.mode EQ 'create'>
			<cfset sSql = "CREATE TABLE `#arguments.tablename#` (">
		<cfelseif variables.mode EQ 'alter'>
			<cfset sSql = "ALTER TABLE `#arguments.tablename#` ">
		</cfif>
		
		<cfloop from="1" to="#ArrayLen(variables.stData.aSqlFields)#" index="idx">
			<cfset sSql = sSql & variables.stData.aSqlFields[idx] & ' ,'>
			<cfset sSql = trim(sSql)>
		</cfloop>
		
		<cfloop from="1" to="#ArrayLen(variables.stData.aSqlPk)#" index="idx">
			<cfset sSql = sSql & variables.stData.aSqlPk[idx] & ' ,'>
			<cfset sSql = trim(sSql)>
		</cfloop>
		
		<cfloop from="1" to="#ArrayLen(variables.stData.aSqlFk)#" index="idx">
			<cfset sSql = sSql & variables.stData.aSqlFk[idx] & ' ,'>
			<cfset sSql = trim(sSql)>
		</cfloop>
		
		<cfloop from="1" to="#ArrayLen(variables.stData.aSqlIndex)#" index="idx">
			<cfset sSql = sSql & variables.stData.aSqlIndex[idx] & ' ,'>
			<cfset sSql = trim(sSql)>
		</cfloop>
		
		<cfif right(sSql,1) EQ ','>
			<cfset sSql = left(sSql,len(sSql)-1)>
		</cfif>
		<cfif variables.mode EQ 'create'>
			<cfset sSql = sSql & ') ENGINE=#variables.engine# DEFAULT CHARSET=utf8'>
		</cfif>
		
		<cfset ArrayAppend(aQueries,sSql)>
		
		<cfif variables.mode EQ 'alter'>
			<cfset ArrayAppend(aQueries,'ALTER TABLE `#arguments.tablename#` ENGINE=#variables.engine#')>
		</cfif>
		
		<cfreturn aQueries>
				
	</cffunction>

	<cffunction name="detectEngine" output="false" returntype="void">
		
		<cfset var iEngines = ArrayLen(variables.stTableData.engine)>
		<cfset var idxEngine = 0>
		<cfset var sCurrentPkString = ''>
		
		<cfloop from="1" to="#iEngines#" index="idxEngine">
			
			<cfif variables.stTableData.engine[idxEngine].server EQ 'mysql'>
				<cfset variables.engine = variables.stTableData.engine[idxEngine].engine>
			</cfif>
				
		</cfloop>
				
	</cffunction>

	<cffunction name="buildFieldsArray" output="false" returntype="void">
		
		<cfset var iFields = ArrayLen(variables.stTableData.field)>
		<cfset var idxField = 0>
		<cfset var stFieldTypeMappings = StructNew()>
		<cfset var sCurrentFieldString = ''>
		<cfset var stCurrentField = StructNew()>
		
		<cfset stFieldTypeMappings.integer = 'int'>
		<cfset stFieldTypeMappings.text = 'text'>
		<cfset stFieldTypeMappings.boolean = 'boolean'>
		
		<cfloop from="1" to="#iFields#" index="idxField">
			<cfset sCurrentFieldString = ''>
			<cfset stCurrentField.name = variables.stTableData.field[idxField].name>
			<cfset stCurrentField.type = variables.stTableData.field[idxField].type>
			<cfset stCurrentField.len = ''>
			<cfset stCurrentField.null = 'NOT NULL'>
			<cfset stCurrentField.default = ''>
			<cfset stCurrentField.special = ''>
		
			<!--- check field TYPE --->
			<cfif StructKeyExists(stFieldTypeMappings,variables.stTableData.field[idxField].type)>
				<cfset stCurrentField.type = stFieldTypeMappings[variables.stTableData.field[idxField].type]>
			</cfif>

			<!--- check field LENGTH --->
			<cfif StructKeyExists(variables.stTableData.field[idxField],'len')>
				<cfset stCurrentField.len = '(#variables.stTableData.field[idxField].len#)'>
			</cfif>

			<!--- check field NULL --->
			<cfif StructKeyExists(variables.stTableData.field[idxField],'null') AND variables.stTableData.field[idxField].null>
				<cfset stCurrentField.null = 'NULL'>
			</cfif>

			<!--- check field DEFAULT --->
			<cfif StructKeyExists(variables.stTableData.field[idxField],'default')>
				<cfif stCurrentField.null EQ 'NULL' AND variables.stTableData.field[idxField].default EQ 'NULL'>
					<cfset stCurrentField.default = " default NULL">
				<cfelse>
					<cfset stCurrentField.default = " default '#variables.stTableData.field[idxField].default#'">
				</cfif>
			</cfif>

			<!--- check field SPECIAL --->
			<cfif StructKeyExists(variables.stTableData.field[idxField],'special')>
				<cfset stCurrentField.special = " #variables.stTableData.field[idxField].special#">
			</cfif>
			
			<!--- fix for "Value '0000-00-00' can not be represented as java.sql.Timestamp" --->
			<cfif stCurrentField.type EQ 'datetime' AND (stCurrentField.default EQ " default '0000-00-00 00:00:00'" OR stCurrentField.default EQ " default 'NULL'")>
				<cfset stCurrentField.null = 'NULL'>
				<cfset stCurrentField.default = " default NULL">
			</cfif>
			
			<!--- fix for "BLOB/TEXT column 'result' can't have a default value" --->
			<cfif stCurrentField.type EQ 'text' AND stCurrentField.default NEQ ''>
				<cfset stCurrentField.default = "">
			</cfif>
			
			<cfset sCurrentFieldString = "#stCurrentField.type##stCurrentField.len# #stCurrentField.null##stCurrentField.default##stCurrentField.special#">
			
			<cfif variables.mode EQ 'create'>
				<cfset sCurrentFieldString = "`#stCurrentField.name#` " & sCurrentFieldString>
			<cfelseif variables.mode EQ 'alter'>
				<cfif StructKeyExists(variables.stTableStructureOld,stCurrentField.name)>
					<cfset sCurrentFieldString = "CHANGE `#stCurrentField.name#` `#stCurrentField.name#` " & sCurrentFieldString>
				<cfelse>
					<cfset sCurrentFieldString = "ADD `#stCurrentField.name#` " & sCurrentFieldString>
				</cfif>
			</cfif>
			
			<cfset ArrayAppend(variables.stData.aSqlFields,sCurrentFieldString)>
		
		</cfloop>
				
	</cffunction>

	<cffunction name="buildPkArray" output="false" returntype="void">
		
		<cfset var iPks = ArrayLen(variables.stTableData.pk)>
		<cfset var idxPk = 0>
		<cfset var idxPkItem = 0>
		<cfset var sCurrentPkString = ''>
		
		<cfloop from="1" to="#iPks#" index="idxPk">
				
			<cfset sCurrentPkString = "PRIMARY KEY (" & ListQualify(variables.stTableData.pk[idxPk].fields,'`') & ")">
		
			<cfif variables.mode EQ 'create'>
				<cfset ArrayAppend(variables.stData.aSqlPk,sCurrentPkString)>
			<cfelseif variables.mode EQ 'alter'>
				<!--- <cfset ArrayAppend(variables.stData.aSqlPreprocess,"DROP PRIMARY KEY")>
				<cfset sCurrentPkString = 'ADD ' & sCurrentPkString>
				<cfset ArrayAppend(variables.stData.aSqlPk,sCurrentPkString)> --->
			</cfif>
				
		</cfloop>
				
	</cffunction>

	<cffunction name="buildFkArray" output="false" returntype="void">
		
		<cfset var iFks = ArrayLen(variables.stTableData.fk)>
		<cfset var idxFk = 0>
		<cfset var idxFkItem = 0>
		<cfset var sCurrentFkString = ''>
		
		<cfloop from="1" to="#iFks#" index="idxFk">
			
			<cfset sCurrentFkString = "INDEX `FK_#variables.stTableData.fk[idxFk].field#`(`#variables.stTableData.fk[idxFk].field#`)">
		
			<cfif variables.mode EQ 'alter'>
				<cfset ArrayAppend(variables.stData.aSqlPreprocess,"DROP INDEX `FK_#variables.stTableData.fk[idxFk].field#`")>
				<cfset sCurrentFkString = 'ADD ' & sCurrentFkString>
			</cfif>
			
			<cfset ArrayAppend(variables.stData.aSqlFk,sCurrentFkString)>
		
		</cfloop>
				
	</cffunction>

	<cffunction name="buildIndexArray" output="false" returntype="void">
		
		<cfset var iIndex = ArrayLen(variables.stTableData.index)>
		<cfset var idxIndex = 0>
		<cfset var idxIndexItem = 0>
		<cfset var sCurrentIndexString = ''>
		
		<cfloop from="1" to="#iIndex#" index="idxIndex">
			
			<cfset sCurrentIndexString = "INDEX `#variables.stTableData.index[idxIndex].name#`(#ListQualify(variables.stTableData.index[idxIndex].fields,'`')#)">
		
			<cfif variables.mode EQ 'alter'>
				<cfset ArrayAppend(variables.stData.aSqlPreprocess,"DROP INDEX `#variables.stTableData.index[idxIndex].name#`")>
				<cfset sCurrentIndexString = 'ADD ' & sCurrentIndexString>
			</cfif>
			
			<cfset ArrayAppend(variables.stData.aSqlIndex,sCurrentIndexString)>
		
		</cfloop>
				
	</cffunction>

</cfcomponent>