<cfcomponent name="masterGateway" hint="Gateway for objectBreeze">

	<cfset variables.DBType = "">
	<cfset variables.dsn = "">
	<cfset variables.masterDAO = "" />
	
		<cffunction name="init" access="public" returntype="masterGateway" hint="I initialize masterGateway">
		<cfargument name="DBType" required="true" type="string" />
		<cfargument name="dsn" required="true" type="string" />
		
		<cfset variables.DBType = arguments.DBType />
		<cfset VARIABLES.dsn = arguments.dsn />
		
		<cfset VARIABLES.masterDAO = createObject("component", "masterDAO").init(variables.DBType, variables.dsn) />
		
		<cfreturn THIS />
	</cffunction>
	
<!--- subCollectionRead() --->
	<cffunction name="subCollectionRead" access="public" returntype="query" output="false" hint="I get all records to fill a sub collection">
		<cfargument name="tableName" type="string" required="yes" hint="Name of collection (table)" />
		<cfargument name="primaryObjectKeyName" type="string" required="yes" hint="Primary object's primary key name" />
		<cfargument name="priKeyValue" type="string" required="yes" hint="Value of a primary key to read into the object" />
		
		<cfquery name="qRead" datasource="#VARIABLES.dsn#">
		SELECT
			*
		FROM
			#ARGUMENTS.tableName#
		WHERE
			#ARGUMENTS.primaryObjectKeyName# = '#ARGUMENTS.priKeyValue#'
		;
		</cfquery>
		
		<cfreturn qRead />
	</cffunction>
<!--- getAll() --->
	<cffunction name="getAll" access="public" returntype="query" output="false" hint="CRUD method">
		<cfargument name="tableName" type="string" required="yes" hint="Name of table we are querying" />
		<cfargument name="propertyList" type="string" required="yes" hint="List of property names" />
		<cfargument name="orderBy" type="string" required="no" default="" hint="Comma separated list of properties to order query by" />
		
		<cftry>
			<cfquery name="qAll" datasource="#variables.dsn#">
			SELECT
				#arguments.propertyList#
			FROM
				#arguments.tableName#
			<cfif len(arguments.orderBy)>
				ORDER BY
					#arguments.orderBy#
			</cfif>
			;
			</cfquery>
			<cfcatch type="any"><cfrethrow>
				<cfthrow type="objectBreeze.getAll.Property" message="Invalid ORDER BY clause" detail="getAll() requires that you pass a valid order by clause into the method.  ORDER BY: #arguments.orderBy#." />
			</cfcatch>
		</cftry>
		
		<cfreturn qAll />
	</cffunction>
<!--- queryByProperty() --->
	<cffunction name="queryByProperty" access="public" returntype="query" output="false" hint="CRUD method">
		<cfargument name="tableName" type="string" required="yes" hint="Name of table we are querying" />
		<cfargument name="propertyList" type="string" required="yes" hint="List of property names" />
		<cfargument name="propertyName" type="string" required="yes" hint="Property name for WHERE clause" />
		<cfargument name="propertyValue" type="string" required="yes" hint="Property value for WHERE clause" />
		<cfargument name="orderBy" type="string" required="yes" hint="Comma separated list of properties to order query by" />
		
		<cftry>
			<cfquery name="qByProperty" datasource="#VARIABLES.dsn#">
			SELECT
				#arguments.propertyList#
			FROM
				#arguments.tableName#
			WHERE
				#arguments.propertyName# = '#arguments.propertyValue#'
			<cfif len(arguments.orderBy)>
				ORDER BY
					#arguments.orderBy#
			</cfif>
			;
			</cfquery>
			<cfcatch type="any">
				<cfthrow type="objectBreeze.getByProperty.Property" message="Invalid ORDER BY clause" detail="getByProperty() requires that you pass a valid order by clause into the method.  ORDER BY: #arguments.orderBy#." />
			</cfcatch>
		</cftry>
		
		<cfreturn qByProperty />
	</cffunction>
<!--- queryByWhere() --->
	<cffunction name="queryByWhere" access="public" returntype="query" output="false" hint="CRUD method">
		<cfargument name="tableName" type="string" required="yes" hint="Name of table we are querying" />
		<cfargument name="propertyList" type="string" required="yes" hint="List of property names" />
		<cfargument name="whereClause" type="string" required="yes" hint="WHERE clause" />
		<cfargument name="orderBy" type="string" required="yes" hint="Comma separated list of properties to order query by" />
		
		<!--- <cftry> --->
			<cfquery name="qByWhere" datasource="#VARIABLES.dsn#">
			SELECT
				#arguments.propertyList#
			FROM
				#arguments.tableName#
			WHERE
				#preserveSingleQuotes(arguments.whereClause)#
			<cfif len(arguments.orderBy)>
				ORDER BY
					#arguments.orderBy#
			</cfif>
			;
			</cfquery>
			<!--- <cfcatch type="any">
				<cfdump var="#cfcatch#"><cfabort>
				<!--- <cfthrow type="objectBreeze.getByWhere.Property" message="Invalid WHERE or ORDER BY clause" detail="getByWhere() requires that you pass a valid where clause and valid order by clause into the method.  WHERE: #arguments.whereClause# ORDER BY: #arguments.orderBy#." /> --->
			</cfcatch>
		</cftry> --->
		
		<cfreturn qByWhere />
	</cffunction>
</cfcomponent>