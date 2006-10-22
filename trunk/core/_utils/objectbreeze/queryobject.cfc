<cfcomponent name="queryObject" hint="Query Class">
	<cfset variables.queryHolder = 0 />
	<cfset variables.tableName = "" />
	<cfset variables.DBType = "" />
	<cfset variables.dsn = "" />
	<cfset variables.numRecords = 0 />
	<cfset variables.recordPointer = 0 />
	
	<cffunction name="init" access="public" output="false" returntype="queryObject" hint="Constructor method.">
		<cfargument name="queryStruct" type="query" required="true" hint="Query to store" />
		<cfargument name="tableName" type="string" required="true" hint="Table name query came from" />
		<cfargument name="DBType" type="string" required="true" hint="Type of database" />
		<cfargument name="dsn" type="string" required="true" hint="DSN name" />
		
		<cfscript>
			setQuery(arguments.queryStruct);
			setTableName(arguments.tableName);
			setDBType(arguments.DBType);
			setDSN(arguments.dsn);
			setRecordCount(getQuery().recordCount);
		</cfscript>
		
		<cfreturn this />
	</cffunction>
	
<!--- getters/setters --->
<!--- getQuery() --->
	<cffunction name="getQuery" access="public" returntype="query" hint="I get the queryHolder property.">
		
		<cfreturn variables.queryHolder />
	</cffunction>
<!--- setQuery() --->
	<cffunction name="setQuery" access="public" returntype="void" hint="I set the queryHolder property.">
		<cfargument name="queryHolder" type="query" required="true" hint="queryHolder property" />
		
		<cfset variables.queryHolder = arguments.queryHolder />
	</cffunction>
<!--- getTableName() --->
	<cffunction name="getTableName" access="public" returntype="string" hint="I get the tableName property.">
		
		<cfreturn variables.tableName />
	</cffunction>
<!--- setTableName() --->
	<cffunction name="setTableName" access="private" returntype="void" hint="I set the tableName property.">
		<cfargument name="tableName" type="string" required="true" hint="tableName property" />
		
		<cfset variables.tableName = arguments.tableName />
	</cffunction>
<!--- getDBType() --->
	<cffunction name="getDBType" access="public" returntype="string" hint="I get the DBType property.">
		
		<cfreturn variables.DBType />
	</cffunction>
<!--- setDBType() --->
	<cffunction name="setDBType" access="public" returntype="string" hint="I set the DBType property.">
		<cfargument name="DBType" type="string" required="true" hint="DBType property" />
		
		<cfset variables.DBType = arguments.DBType />
	</cffunction>
<!--- getDSN() --->
	<cffunction name="getDSN" access="public" returntype="string" hint="I get the DSN property.">
		
		<cfreturn variables.dsn />
	</cffunction>
<!--- setDSN() --->
	<cffunction name="setDSN" access="public" returntype="string" hint="I set the dsn property.">
		<cfargument name="dsn" type="string" required="true" hint="dsn property" />
		
		<cfset variables.dsn = arguments.dsn />
	</cffunction>

<!--- getRecordCount() --->
	<cffunction name="getRecordCount" access="public" returntype="numeric" hint="I get the numRecords property.">
		
		<cfreturn variables.numRecords />
	</cffunction>
<!--- setTableName() --->
	<cffunction name="setRecordCount" access="private" returntype="void" hint="I set the numRecords property.">
		<cfargument name="numRecords" type="numeric" required="true" hint="numRecords property" />
		
		<cfset variables.numRecords = arguments.numRecords />
	</cffunction>
<!--- getRecordPointer() --->
	<cffunction name="getRecordPointer" access="public" returntype="numeric" hint="I get the recordPointer property.">
		
		<cfreturn variables.recordPointer />
	</cffunction>
<!--- setRecordPointer() --->
	<cffunction name="setRecordPointer" access="private" returntype="void" hint="I set the recordPointer property.">
		<cfargument name="recordPointer" type="numeric" required="true" hint="recordPointer property" />
		
		<cfif arguments.recordPointer GT getRecordCount() OR arguments.recordPointer LTE 0>
			<cfthrow type="objectBreeze.queryObject.RecordPointer" message="Record pointer outside of range" detail="The record pointer provided to the queryObject is greater than the total number of records in the query." />
		<cfelse>
			<cfset variables.recordPointer = arguments.recordPointer />
		</cfif>
	</cffunction>
	
<!--- decrementRecordPointer() --->
	<cffunction name="decrementRecordPointer" access="private" returntype="void" hint="I set the recordPointer property to the previous value.">
		
		<cfset variables.recordPointer = decrementValue(variables.recordPointer) />
	</cffunction>
<!--- incrementRecordPointer() --->
	<cffunction name="incrementRecordPointer" access="private" returntype="void" hint="I set the recordPointer property to the next value.">
		
		<cfset variables.recordPointer = incrementValue(variables.recordPointer) />
	</cffunction>
<!--- hasPrevious() --->
	<cffunction name="hasPrevious" access="public" returntype="boolean" hint="Checks of there is a previous record to move to.">
		
		<cfscript>
			var bool = false;
			if ( getRecordPointer() GT 1 ) { bool = true; }
			return bool;
		</cfscript>
	</cffunction>
<!--- hasNext() --->
	<cffunction name="hasNext" access="public" returntype="boolean" hint="Checks if there is a next record to move to.">
		
		<cfscript>
			var bool = false;
			if ( getRecordPointer() LT getRecordCount() ) { bool = true; }
			return bool;
		</cfscript>
	</cffunction>
	<cffunction name="getPrevious" access="public" returntype="MasterObject" hint="Returns the previous record as an object.">
		
		<cfset var object = "" />
		<!--- is there a previous record --->
		<cfif hasPrevious()>
			<cfset object = createObject("component", "masterObject").init(getTableName(), getDBType(), getDSN()) />
			<cfset decrementRecordPointer() />
			<cfloop list="#getQuery().columnList#" index="i">
				<cfset object.setProperty(i, variables.QueryHolder[i][getRecordPointer()], true) />
			</cfloop>
		<!--- otherwise --->
		<cfelse>
			<cfthrow type="objectBreeze.queryObject.RecordPointer" message="Record pointer outside of range" detail="There is no previous record to return." />
		</cfif>
		
		<cfreturn object />
	</cffunction>
	<cffunction name="getNext" access="public" returntype="MasterObject" hint="Returns the next record as an object.">
		
		<cfset var object = "" />
		<!--- is there a previous record --->
		<cfif hasNext()>
			<cfset object = createObject("component", "masterObject").init(getTableName(), getDBType(), getDSN()) />
			<cfset incrementRecordPointer() />
			<cfloop list="#getQuery().columnList#" index="i">
				<cfset object.setProperty(i, variables.QueryHolder[i][getRecordPointer()], true) />
			</cfloop>
		<!--- otherwise --->
		<cfelse>
			<cfthrow type="objectBreeze.queryObject.RecordPointer" message="Record pointer outside of range" detail="There is no previous record to return." />
		</cfif>
		
		<cfreturn object />
	</cffunction>
</cfcomponent>