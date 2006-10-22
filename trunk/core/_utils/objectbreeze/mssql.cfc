<cfcomponent name="MSSQL" hint="I am for MSSQL">
	
	<cfset VARIABLES.dsn = "">
	
	<cffunction name="init" access="public" returntype="MSSQL" hint="I initialize MSSQL">
		<cfargument name="dsn" required="true" type="string" hint="MSSQL datasource name" />
		
		<cfset VARIABLES.dsn = ARGUMENTS.dsn />
		
		<cfreturn THIS />
	</cffunction>
	
	<cffunction name="getPriKeyName" access="public" returntype="string" hint="I return a table's primary key name">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		
		<cfstoredproc procedure="sp_help" datasource="#VARIABLES.dsn#">
			<cfprocresult name="primaryKey" resultSet="6" />
			<cfprocparam type="IN" value="#objectName#" cfsqltype="cf_sql_varchar" />
		</cfstoredproc>
		
		<cfquery name="qGetPK" dbtype="query">
		SELECT
			index_keys
		FROM
			primaryKey
		WHERE
			index_name LIKE 'PK_%'
		;
		</cfquery>
		
		<cfreturn qGetPK.index_Keys />
	</cffunction>
	
	<cffunction name="getColumnArray" access="public" returntype="query" hint="I return a query of column names">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		
		<cfstoredproc procedure="sp_help" datasource="#VARIABLES.dsn#">
			<cfprocresult name="qColumns" resultSet="2" />
			<cfprocparam type="IN" value="#objectName#" cfsqltype="cf_sql_varchar" />
		</cfstoredproc>
		
		<cfreturn qColumns />
	</cffunction>
	
</cfcomponent>