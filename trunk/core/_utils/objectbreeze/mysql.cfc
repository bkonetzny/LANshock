<cfcomponent name="MySQL" hint="I am for MySQL">
	
	<cfset VARIABLES.dsn = "">
	
	<cffunction name="init" access="public" returntype="MySQL" hint="I initialize MySQL">
		<cfargument name="dsn" required="true" type="string" hint="MySQL datasource name" />
		
		<cfset VARIABLES.dsn = ARGUMENTS.dsn />
		
		<cfreturn THIS />
	</cffunction>
	
	<cffunction name="getPriKeyName" access="public" returntype="string" hint="I return a table's primary key name">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		
		<cfquery name="qTableExplain" datasource="#VARIABLES.dsn#">
		EXPLAIN #ARGUMENTS.objectName#; 
		</cfquery>
		
		<cfquery name="qGetPK" dbtype="query">
		SELECT field
		FROM qTableExplain
		WHERE [key] = 'PRI';
		</cfquery>
		
		<cfreturn qGetPK.field />
	</cffunction>
	
	<cffunction name="getColumnArray" access="public" returntype="query" hint="I return a query of column names">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		
		<cfquery name="qTableExplain" datasource="#VARIABLES.dsn#">
		EXPLAIN #ARGUMENTS.objectName#;
		</cfquery>
		
		<cfquery name="qColumns" dbtype="query">
		SELECT
			field AS column_name
		FROM
			qTableExplain
		;
		</cfquery>
		
		<cfreturn qColumns />
	</cffunction>
	
</cfcomponent>