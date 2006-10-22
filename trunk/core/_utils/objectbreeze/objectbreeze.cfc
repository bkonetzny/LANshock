<cfcomponent name="objectBreeze" hint="I am a controller for objectBreeze">
	
	<cfset VARIABLES.masterDAO = "" />
	<cfset variables.masterGateway = "" />
	<cfset VARIABLES.DBType = "" />
	<cfset VARIABLES.dsn = 0 />

	
	<cffunction name="init" access="public" returntype="objectBreeze" hint="I initialize the controller">
		<cfargument name="DBType" type="string" required="true" hint="Type of database" />
		<cfargument name="dsn" type="string" required="true" hint="Name of datasource" />
		
		<cfset setDBType(ARGUMENTS.DBType) />
		<cfset setDSN(ARGUMENTS.dsn) />
		
		<cfset VARIABLES.masterDAO = createObject("component", "masterDAO").init(getDBType(), getDSN()) />
		<cfset VARIABLES.masterGateway = createObject("component", "masterGateway").init(getDBType(), getDSN()) />
		
		<cfreturn THIS />
	</cffunction>
	
<!--- getters/setters --->
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
<!--- public methods --->
<!--- objectCreate() --->
	<cffunction name="objectCreate" access="public" returntype="masterObject" hint="I create a new object">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		
		<cfset object = createObject("component", "masterObject").init(ARGUMENTS.objectName, VARIABLES.DBType, VARIABLES.DSN) />
		
		<cfreturn object />
	</cffunction>
	<!---
<!--- objectRead() --->
	<cffunction name="objectRead" access="public" returntype="masterObject" hint="reads data into the object">
		<cfargument name="object" required="true" type="masterObject" />
		<cfargument name="priKeyValue" required="true" type="string" hint="Value of record's primary key to read" />
		
		<!--- read into the object --->
		<cfset VARIABLES.masterDAO.read(ARGUMENTS.object, ARGUMENTS.priKeyValue) />
		
		<!--- now, loop over object and see if we have any objects or collections to fill --->
		<cfloop list="#ARGUMENTS.object.getCompositionNames()#" index="propertyName">
			<cfif object.hasOne(propertyName)>
				<cfset VARIABLES.masterDAO.readSubProperty(ARGUMENTS.object.getProperty(propertyName), ARGUMENTS.object.getIDName(), ARGUMENTS.priKeyValue) />
			<cfelseif object.hasMany(propertyName)>
				<cfset qCollection = VARIABLES.masterGateway.subCollectionRead(propertyName, ARGUMENTS.object.getIDName(), ARGUMENTS.priKeyValue) />
				<cfset tmpCollection = ARGUMENTS.object.getProperty(propertyName) />
				<cfset tmpCollection = collectionFillByQuery(tmpCollection, propertyName, qCollection) />
			</cfif>
		</cfloop>
		
		<cfreturn ARGUMENTS.object />
	</cffunction>
<!--- objectReadByProperty() --->
	<cffunction name="objectReadByProperty" access="public" returntype="masterObject" hint="reads data into the object by property">
		<cfargument name="object" required="true" type="masterObject" />
		
		<!--- read into the object --->
		<cfset VARIABLES.masterDAO.readbyProperty(ARGUMENTS.object) />
		
		<!--- now, loop over object and see if we have any objects or collections to fill --->
		<cfloop list="#ARGUMENTS.object.getCompositionNames()#" index="propertyName">
			<cfif object.hasOne(propertyName)>
				<cfset VARIABLES.masterDAO.readSubProperty(ARGUMENTS.object.getProperty(propertyName), ARGUMENTS.object.getIDName(), ARGUMENTS.object.getID()) />
			<cfelseif object.hasMany(propertyName)>
				<cfset qCollection = VARIABLES.masterGateway.subCollectionRead(propertyName, ARGUMENTS.object.getIDName(), ARGUMENTS.object.getID()) />
				<cfset tmpCollection = ARGUMENTS.object.getProperty(propertyName) />
				<cfset tmpCollection = collectionFillByQuery(tmpCollection, propertyName, qCollection) />
			</cfif>
		</cfloop>
		
		<cfreturn ARGUMENTS.object />
	</cffunction>
<!--- objectCommit() --->
	<cffunction name="objectCommit" access="public" returntype="void" hint="commits an object to the database">
		<cfargument name="object" required="true" type="masterObject" />
		
		<cfset var collection = "" />
		<cfset variables.masterDAO.commit(ARGUMENTS.object, VARIABLES.DBType) />
		
		<!--- now loop over the object to commit any objects or collections this object contains --->
		<cfloop list="#ARGUMENTS.object.getCompositionNames()#" index="propertyName">
			<cfif object.hasOne(propertyName)>
				<!--- add the ID into the compounded object in case the primary object was just added with an identity --->
				<cfset ARGUMENTS.object.getProperty(propertyName).setProperty("#arguments.object.getIDName()#", ARGUMENTS.object.getID()) />
				<cfset variables.masterDAO.commit(ARGUMENTS.object.getProperty(propertyName), variables.DBType) />
			<cfelseif object.hasMany(propertyName)>
				<!--- add the ID into the compounded object in case the primary object was just added with an identity --->
				<cfset collection = ARGUMENTS.object.getProperty(propertyName) />
				<cfloop from="1" to="#collection.count()#" index="i">
					<cfset collection.getAt(i).setProperty(propertyName, arguments.object.getID()) />
				</cfloop>
				<cfset collectionCommit(collection) />
			</cfif>
		</cfloop>
		
	</cffunction>
<!--- objectDelete() --->
	<cffunction name="objectDelete" access="public" returntype="void" hint="deletes an object from the database by primary key (in object)">
		<cfargument name="object" required="true" type="masterObject" />
		
		<cfset VARIABLES.masterDAO.delete(ARGUMENTS.object) />
		
	</cffunction>
	--->
<!--- collectionCreate() --->
	<cffunction name="collectionCreate" access="public" returntype="objectBreeze.assets.cfc.collection.Collection" hint="creates a new collection">
		
		<cfset var myCollection = createObject("component", "Collection") />
		
		<cfreturn myCollection />
	</cffunction>
<!---
<!--- collectionFillByQuery() --->
	<cffunction name="collectionFillByQuery" access="public" returntype="objectBreeze.assets.cfc.collection.Collection" hint="fills a collection from a query">
		<cfargument name="collection" required="true" type="objectBreeze.assets.cfc.collection.Collection" />
		<cfargument name="tableName" required="true" type="string" hint="Name of object (table)" />
		<cfargument name="myQuery" required="true" type="query" hint="Query to load into object collection" />
		
		<cfset var myCollection = ARGUMENTS.collection />
		<cfset var object = 0 />
		
		<cfloop from="1" to="#myQuery.recordCount#" index="i">
			<!--- create a new object --->
			<cfset object = createObject("component", "masterObject").init(ARGUMENTS.tableName, VARIABLES.DBType, VARIABLES.DSN) />
			<!--- write the values to the object --->
			<cfloop list="#object.getPropertyNames(object)#" index="columnName">
				<cfset object.setProperty(columnName, myQuery[columnName][i]) />
			</cfloop>
			<!--- add the object to the collection --->
			<cfset myCollection.add(object) />
		</cfloop>
		
		<cfreturn myCollection />
	</cffunction>

<!--- collectionCommit() --->
	<cffunction name="collectionCommit" access="public" returntype="void" hint="commits a collection">
		<cfargument name="collection" required="true" type="objectBreeze.assets.cfc.collection.Collection" />
		
		<cfloop from="1" to="#collection.count()#" index="i">
			<cfset objectCommit(ARGUMENTS.collection.getAt(i)) />	
		</cfloop>
	</cffunction>
	--->
<!--- list() --->
	<cffunction name="list" access="public" returntype="QueryObject" hint="Returns a query object of all records in the table.">
		<cfargument name="tableName" required="true" type="string" />
		<cfargument name="orderBy" required="true" type="string" default="" />
		
		<cfset var qRecords = 0 />
		<cfset var orderByList = "" />
		<cfset var databaseObject = createObject("component", "#getDBType()#").init(GetDSN()) />
		<cfset var lPropertyNames = "" />
		
		<cfif len(arguments.orderBy)>
			<cfset orderByList = arguments.orderBy />
		</cfif>
		
		<!--- get the columns from the table --->
		<cfset priKeyName = databaseObject.getPriKeyName(ARGUMENTS.tableName) />
		<cfset qColumns = databaseObject.getColumnArray(ARGUMENTS.tableName) />
		<cfloop query="qColumns">
			<cfset variables[qColumns.Column_Name] = "" />
			<cfset lPropertyNames = listAppend(lPropertyNames, qColumns.Column_Name) />
		</cfloop>
		
		<!--- ensure the order by properties are actual properties in the table --->
		<!--- <cfloop list="#arguments.orderBy#" index="i">
			<cfif NOT listFind(lPropertyNames, i)>
				<cfthrow type="objectBreeze.list.Property" message="Property does not exist in the table" detail="List requires that the order by list you send only contains properties that exist in the table.  #i# does not exist in #arguments.tableName#." />
			</cfif>
		</cfloop> --->
		
		<!--- read all records into a query --->
		<cfset qRecords = variables.masterGateway.getAll(arguments.tableName, lPropertyNames, arguments.orderBy) />
		
		<cfset queryObject = createObject("component", "QueryObject").init(qRecords, arguments.tableName, getDBType(), getDSN()) />
		
		<cfreturn queryObject />
	</cffunction>
<!--- getByProperty() --->
	<cffunction name="getByProperty" access="public" returntype="QueryObject" hint="Returns a query object of records that match the supplied property.">
		<cfargument name="tableName" required="true" type="string" hint="Name of table to query" />
		<cfargument name="propertyName" required="true" type="string" hint="Name of property for WHERE clause" />
		<cfargument name="propertyValue" required="true" type="string" hint="Value of property for WHERE clause." />
		<cfargument name="orderBy" required="true" type="string" default="" hint="Comma separated ORDER BY clause." />
		
		<cfset var qRecords = 0 />
		<cfset var orderByList = "" />
		<cfset var databaseObject = createObject("component", "#getDBType()#").init(GetDSN()) />
		<cfset var lPropertyNames = "" />
		
		<cfif len(arguments.orderBy)>
			<cfset orderByList = arguments.orderBy />
		</cfif>
		
		<!--- get the columns from the table --->
		<cfset priKeyName = databaseObject.getPriKeyName(ARGUMENTS.tableName) />
		<cfset qColumns = databaseObject.getColumnArray(ARGUMENTS.tableName) />
		<cfloop query="qColumns">
			<cfset variables[qColumns.Column_Name] = "" />
			<cfset lPropertyNames = listAppend(lPropertyNames, qColumns.Column_Name) />
		</cfloop>
		
		<!--- make sure the property we are using exists in the table --->
		<cfif NOT listFindNoCase(lPropertyNames, arguments.propertyName)>
			<cfthrow type="objectBreeze.getByProperty.Property" message="Property does not exist in the table" detail="getByProperty() requires that the property you send exists in the table.  #arguments.propertyName# does not exist in #arguments.tableName#." />
		</cfif>
		
		<!--- ensure the order by properties are actual properties in the table --->
		<!--- <cfloop list="#arguments.orderBy#" index="i">
			<cfif NOT listFind(lPropertyNames, i)>
				<cfthrow type="objectBreeze.getByProperty.Property" message="Property does not exist in the table" detail="List() requires that the order by list you send only contains properties that exist in the table.  #i# does not exist in #arguments.tableName#." />
			</cfif>
		</cfloop> --->
		
		<!--- read records into a query --->
		<cfset qRecords = variables.masterGateway.queryByProperty(arguments.tableName, lPropertyNames, arguments.propertyName, arguments.propertyValue, arguments.orderBy) />
		
		<cfset queryObject = createObject("component", "QueryObject").init(qRecords, arguments.tableName, getDBType(), getDSN()) />
		
		<cfreturn queryObject />
	</cffunction>
<!--- getByWhere() --->
	<cffunction name="getByWhere" access="public" returntype="QueryObject" hint="Returns a query object of records that match the supplied WHERE clause.">
		<cfargument name="tableName" required="true" type="string" hint="Name of table to query" />
		<cfargument name="whereClause" required="true" type="string" hint="WHERE clause" />
		<cfargument name="orderBy" required="true" type="string" default="" hint="Comma separated ORDER BY clause." />
		
		<cfset var qRecords = 0 />
		<cfset var orderByList = "" />
		<cfset var databaseObject = createObject("component", "#getDBType()#").init(GetDSN()) />
		<cfset var lPropertyNames = "" />
		
		<cfif len(arguments.orderBy)>
			<cfset orderByList = arguments.orderBy />
		</cfif>
		
		<!--- get the columns from the table --->
		<cfset priKeyName = databaseObject.getPriKeyName(ARGUMENTS.tableName) />
		<cfset qColumns = databaseObject.getColumnArray(ARGUMENTS.tableName) />
		<cfloop query="qColumns">
			<cfset variables[qColumns.Column_Name] = "" />
			<cfset lPropertyNames = listAppend(lPropertyNames, qColumns.Column_Name) />
		</cfloop>
		
		<!--- ensure the order by properties are actual properties in the table --->
		<!--- <cfloop list="#arguments.orderBy#" index="i">
			<cfif NOT listFind(lPropertyNames, i)>
				<cfthrow type="objectBreeze.getByProperty.Property" message="Property does not exist in the table" detail="List() requires that the order by list you send only contains properties that exist in the table.  #i# does not exist in #arguments.tableName#." />
			</cfif>
		</cfloop> --->
		
		<!--- read records into a query --->
		<cfset qRecords = variables.masterGateway.queryByWhere(arguments.tableName, lPropertyNames, arguments.whereClause, arguments.orderBy) />
		
		<cfset queryObject = createObject("component", "QueryObject").init(qRecords, arguments.tableName, getDBType(), getDSN()) />
		
		<cfreturn queryObject />
	</cffunction>
</cfcomponent>