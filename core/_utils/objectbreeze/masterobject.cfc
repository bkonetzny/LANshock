<cfcomponent name="masterObject" hint="I handle data access for the object">
	
	<cfset variables.objectName = "" />
	<cfset variables.priKeyName = "" />
	<cfset variables.propertyNames = "" />
	<cfset variables.propertyNamesChanged = "" />
	<cfset variables.compositionNames = "" />
	<cfset variables.DBType = "" />
	<cfset variables.dsn = "" />
	<cfset variables.masterDAO = 0 />
	<cfset variables.masterGateway = 0 />
	
<!--- init() --->	
	<cffunction name="init" access="public" returntype="masterObject" output="false" hint="I create an instance of the object">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		<cfargument name="DBType" required="true" type="string" hint="Database type" />
		<cfargument name="dsn" required="true" type="string" hint="Datasource name" />
		
		<cfset setObjectName(ARGUMENTS.objectName) />
		<cfset setDBType(arguments.DBType) />
		<cfset setDSN(arguments.dsn) />
		<cfset variables.masterDAO = createObject("component", "masterDAO").init(getDBType(), getDSN()) />
		<cfset variables.masterGateway = createObject("component", "masterGateway").init(getDBType(), getDSN()) />
		
		<!--- create a new instance of the masterObject --->
		<cfset databaseObject = createObject("component", "#ARGUMENTS.DBType#").init(getDSN()) />
		<cfset lPropertyNames = "" />
		
		<!--- get the columns from the table --->
		<cfset priKeyName = databaseObject.getPriKeyName(ARGUMENTS.objectName) />
		<cfset qColumns = databaseObject.getColumnArray(ARGUMENTS.objectName) />
		
		<!--- create the object using these columns --->
		<cfset setIDName(priKeyName) />
		<cfloop query="qColumns">
			<cfset variables[qColumns.Column_Name] = "" />
			<cfset lPropertyNames = listAppend(lPropertyNames, qColumns.Column_Name) />
		</cfloop>
		
		<!--- set the propertyNames property --->
		<cfset setPropertyNames(lPropertyNames) />
		
		<cfreturn THIS />
	</cffunction>
	
<!--- accessor methods --->
<!--- getIDName() --->
	<cffunction name="getIDName" access="public" returntype="string" output="false" hint="I get an objects primary key name">
		
		<cfreturn variables.priKeyName />
	</cffunction>
<!--- setIDName() --->
	<cffunction name="setIDName" access="public" returntype="void" output="false" hint="I set an objects primary key name">
		<cfargument name="columnName" required="true" type="string" hint="Column name" />
		
		<cfset variables.priKeyName = ARGUMENTS.columnName />
	</cffunction>
<!--- getID() --->
	<cffunction name="getID" access="public" returntype="string" output="false" hint="I get an objects primary key">
		
		<cfreturn variables[getIDName()] />
	</cffunction>
<!--- setID() --->
	<cffunction name="setID" access="public" returntype="void" output="false" hint="I set an objects primary key">
		<cfargument name="priKeyValue" required="true" type="string" hint="Primary key value" />
		
		<cfset variables[getIDName()] = ARGUMENTS.priKeyValue />
	</cffunction>
<!--- getObjectName() --->
	<cffunction name="getObjectName" access="public" returntype="string" output="false" hint="I get an objects name">
		
		<cfreturn variables.objectName />
	</cffunction>
<!--- setObjectName() --->
	<cffunction name="setObjectName" access="public" returntype="string" output="false" hint="I set an objects name">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		
		<cfset variables.objectName =  ARGUMENTS.objectName/>
	</cffunction>
<!--- getPropertyNames() --->
	<cffunction name="getPropertyNames" access="public" returntype="string" output="false" hint="I get an objects property names">
		
		<cfreturn variables.propertyNames />
	</cffunction>
<!--- getPropertyNamesChanged() --->
	<cffunction name="getPropertyNamesChanged" access="public" returntype="string" output="false" hint="I get an objects property names which were changed by setProperty()">
		
		<cfreturn variables.propertyNamesChanged />
	</cffunction>
<!--- setCompositionNames() --->
	<cffunction name="setCompositionNames" access="public" returntype="void" output="false" hint="I set an objects composition property names">
		<cfargument name="compositionNames" required="true" type="string" hint="List of composition objects within the object" />
		
		<cfset variables.compositionNames = ARGUMENTS.compositionNames />
	</cffunction>
<!--- getCompositionNames() --->
	<cffunction name="getCompositionNames" access="public" returntype="string" output="false" hint="I get an objects composition property names">
		
		<cfreturn variables.compositionNames />
	</cffunction>
<!--- setPropertyNames() --->
	<cffunction name="setPropertyNames" access="public" returntype="void" output="false" hint="I set an objects property names">
		<cfargument name="propertyNames" required="true" type="string" hint="List of properties within the object (table columns)" />
		
		<cfset variables.propertyNames = ARGUMENTS.propertyNames />
	</cffunction>
<!--- getProperty() --->
	<cffunction name="getProperty" access="public" returntype="any" output="false" hint="I get an objects property">
		<cfargument name="columnName" required="true" type="string" />
		
		<cfreturn variables[ARGUMENTS.columnName] />
	</cffunction>
<!--- setProperty() --->
	<cffunction name="setProperty" access="public" returntype="void" output="false" hint="I set an objects property">
		<cfargument name="columnName" required="true" type="string" hint="Name of property within the object (table column)" />
		<cfargument name="propertyValue" required="true" type="any" hint="Value of property to set into the object" />
		<cfargument name="internal" required="false" type="boolean" default="false" hint="Internal Request" />
		
		<cfset variables[ARGUMENTS.columnName] = ARGUMENTS.propertyValue />
		<cfif NOT arguments.internal AND NOT listFind(variables.propertyNamesChanged,ARGUMENTS.columnName)>
			<cfset variables.propertyNamesChanged = ListAppend(variables.propertyNamesChanged,ARGUMENTS.columnName) />
		</cfif>
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
<!--- containsOne() --->
	<cffunction name="containsOne" access="public" returntype="void" output="false" hint="I create a new object within this object">
		<cfargument name="objectName" required="true" type="string" hint="Name of object (table)" />
		
		<cfset variables[ARGUMENTS.objectName] = createObject("component", "masterObject").init(ARGUMENTS.objectName, variables.DBType, variables.DSN) />
		<cfset setCompositionNames(listAppend(getCompositionNames(), objectName)) />
		
	</cffunction>
<!--- containsMany() --->
	<cffunction name="containsMany" access="public" returntype="void" output="false" hint="I create a new collection within this object">
		<cfargument name="collectionName" required="true" type="string" hint="Name of collection (table)" />
		
		<cfset variables[ARGUMENTS.collectionName] = createObject("component", "Collection") />
		<cfset setCompositionNames(listAppend(getCompositionNames(), collectionName)) />
		
	</cffunction>
<!--- hasOne() --->
	<cffunction name="hasOne" access="public" returntype="boolean" output="false" hint="I return if an property is an object">
		<cfargument name="columnName" required="true" type="string" hint="Name of property within the object" />
		
		<cfset var isAnObject = 0 />
		<cfif getMetaData(variables[ARGUMENTS.columnName]).name EQ "masterObject">
			<cfset isAnObject = 1 />
		</cfif>
		
		<cfreturn isAnObject />
	</cffunction>
<!--- hasMany() --->
	<cffunction name="hasMany" access="public" returntype="boolean" output="false" hint="I return if an property is a collection">
		<cfargument name="columnName" required="true" type="string" hint="Name of property within the object" />
		
		<cfset var isACollection = 0 />
		<cfif getMetaData(variables[ARGUMENTS.columnName]).name EQ "Collection">
			<cfset isACollection = 1 />
		</cfif>
		
		<cfreturn isACollection />
	</cffunction>
<!--- commit() --->
	
<!--- read() --->
	<cffunction name="read" access="public" returntype="void" output="false" hint="I read data into an object">
		<cfargument name="priKeyValue" required="true" type="string" hint="Value of record's primary key to read" />
		
		<!--- read into the object --->
		<cfset variables.masterDAO.read(this, arguments.priKeyValue) />
		
		<!--- now, loop over object and see if we have any objects or collections to fill --->
		<cfloop list="#getCompositionNames()#" index="propertyName">
			<cfif hasOne(propertyName)>
				<cfset variables.masterDAO.readSubProperty(getProperty(propertyName), getIDName(), arguments.priKeyValue) />
			<cfelseif hasMany(propertyName)>
				<cfset qCollection = variables.masterGateway.subCollectionRead(propertyName, getIDName(), arguments.priKeyValue) />
				<cfset tmpCollection = getProperty(propertyName) />
				<cfset tmpCollection = tmpCollection.collectionFillByQuery(propertyName, qCollection, getDBType(), getDSN()) />
			</cfif>
		</cfloop>
	</cffunction>
<!--- readByProperty() --->
	<cffunction name="readByProperty" access="public" returntype="void" hint="reads data into the object by property">
		
		<!--- read into the object --->
		<cfset variables.masterDAO.readbyProperty(this) />
		
		<!--- now, loop over object and see if we have any objects or collections to fill --->
		<cfloop list="#getCompositionNames()#" index="propertyName">
			<cfif hasOne(propertyName)>
				<cfset variables.masterDAO.readSubProperty(getProperty(propertyName), getIDName(), getID()) />
			<cfelseif hasMany(propertyName)>
				<cfset qCollection = variables.masterGateway.subCollectionRead(propertyName, getIDName(), getID()) />
				<cfset tmpCollection = getProperty(propertyName) />
				<cfset tmpCollection = tmpCollection.collectionFillByQuery(propertyName, qCollection, getDBType(), getDSN()) />
			</cfif>
		</cfloop>
		
	</cffunction>
<!--- commit() --->
	<cffunction name="commit" access="public" returntype="void" hint="commits an object to the database">
		
		<cfset var collection = "" />
		<cfset variables.masterDAO.commit(this) />
		
		<!--- now loop over the object to commit any objects or collections this object contains --->
		<cfloop list="#getCompositionNames()#" index="propertyName">
			<cfif hasOne(propertyName)>
				<!--- add the ID into the compounded object in case the primary object was just added with an identity --->
				<cfset getProperty(propertyName).setProperty("#getIDName()#", getID(), true) />
				<cfset variables.masterDAO.commit(this) />
			<cfelseif hasMany(propertyName)>
				<!--- add the ID into the compounded object in case the primary object was just added with an identity --->
				<cfset collection = getProperty(propertyName) />
				<cfloop from="1" to="#collection.count()#" index="i">
					<cfset collection.getAt(i).setProperty(propertyName, getID(), true) />
				</cfloop>
				<cfset collection.collectionCommit() />
			</cfif>
		</cfloop>
		
	</cffunction>
<!--- delete() --->
	<cffunction name="delete" access="public" returntype="void" hint="deletes an object from the database by primary key (in object)">
		
		<cfset variables.masterDAO.delete(this) />
		
	</cffunction>
</cfcomponent>