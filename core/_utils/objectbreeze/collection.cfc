<cfcomponent name="Collection" hint="Collection of objects">
	<cfset variables.container = arrayNew(1) />
	<cfset variables.currentIndex = 0 />
	
	<!--- constructor method --->
	<cffunction name="init" access="public" returntype="Collection" output="false" hint="initiates instance of Collection">
		<!--- initiate values --->
		<cfset variables.container = arrayNew(1) />
		<cfset variables.currentIndex = 0 />
		
		<cfreturn this />
	</cffunction>
	
	<!--- public methods --->
	<cffunction name="add" access="public" returntype="Void" output="false" hint="adds new object to collection">
		<cfargument name="object" type="Struct" required="yes" />
			
			<cfset arrayAppend(variables.container, arguments.object) />
			<cfset variables.currentIndex = this.count() />
	</cffunction>
	
	<cffunction name="getAt" access="public" returntype="Struct" output="false" hint="returns item at given index">
		<cfargument name="index" type="Numeric" required="yes" hint="Collection (array) index that contains an object" />
		
		<cfreturn variables.container[arguments.index] />
	</cffunction>
	
	<cffunction name="getByID" access="public" returntype="Any" output="false" hint="return object in collection by an object primary key value">
		<cfargument name="priKeyValue" required="true" type="string" hint="Value of primary key to search for in the collection" />
		
		<cfset var myIndex = 0 />
		<cfset var myObject = 0 />
		
		<cfloop from="1" to="#this.count()#" index="i">
			<cfif this.getAt(i).getID(this.getAt(i)) EQ ARGUMENTS.priKeyValue>
				<cfset myIndex = i />
				<cfset myObject =  this.getAt(myIndex) />
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfreturn myObject />
	</cffunction>
	
	<cffunction name="getByProperty" access="public" returntype="Any" output="false" hint="return object in collection by an object property value">
		<cfargument name="propertyName" required="true" type="string" hint="Name of a property in the collection's object" />
		<cfargument name="propertyValue" required="true" type="string" hint="Value of a property to search for" />
		
		<cfset var myIndex = 0 />
		<cfset var myObject = 0 />
		
		<cfloop from="1" to="#this.count()#" index="i">
			<cfif this.getAt(i).getProperty(ARGUMENTS.propertyName) EQ ARGUMENTS.propertyValue>
				<cfset myIndex = i />
				<cfset myObject =  this.getAt(myIndex) />
				<cfbreak />
			</cfif>
		</cfloop>
		
		<cfreturn myObject />
	</cffunction>
	
	<cffunction name="existsAt" access="public" returntype="Boolean" output="false" hint="I check if item exists at a given position">
		<cfargument name="index" type="Numeric" required="yes" hint="Collection (array) index that might contain an object" />
		<cfset var retVal = "" />
		<cfset var temp = "" />
		<cftry>
			<cfset temp = variables.container[arguments.index] />
			<cfset retVal = true />
			<cfcatch type="any">
				<cfset retVal = false />
			</cfcatch>
		</cftry>
		<cfreturn retVal />
	</cffunction>		
	
	<cffunction name="removeAt" access="public" returntype="Boolean" output="false" hint="removes object at given index from collection">
		<cfargument name="index" type="Numeric" required="yes" hint="Collection (array) index that might contain an object" />
		<cfif arguments.index LTE this.count()>
			<cfset arrayDeleteAt(variables.container,arguments.index) />
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>
	
	<cffunction name="count" access="public" returntype="numeric" output="false" hint="returns number of objects in collection">
		
		<cfreturn arrayLen(VARIABLES.container) />
	</cffunction>
	
	<cffunction name="clearCollection" access="public" returntype="Void" output="false" hint="I reset the collection">
		<cfset variables.container = arrayNew(1) />
		<cfset variables.currentIndex = this.count() />
	</cffunction>
<!--- collectionFillByQuery() --->
	<cffunction name="collectionFillByQuery" access="public" returntype="void" hint="fills a collection from a query">
		<cfargument name="tableName" required="true" type="string" hint="Name of object (table)" />
		<cfargument name="myQuery" required="true" type="query" hint="Query to load into object collection" />
		<cfargument name="DBType" required="true" type="string" hint="Database type" />
		<cfargument name="DSN" required="true" type="string" hint="Name of DSN" />
		
		<cfset var object = 0 />
		
		<cfloop from="1" to="#myQuery.recordCount#" index="i">
			<!--- create a new object --->
			<cfset object = createObject("component", "masterObject").init(arguments.tableName, arguments.DBType, arguments.DSN) />
			<!--- write the values to the object --->
			<cfloop list="#object.getPropertyNames(object)#" index="columnName">
				<cfset object.setProperty(columnName, myQuery[columnName][i], true) />
			</cfloop>
			<!--- add the object to the collection --->
			<cfset add(object) />
		</cfloop>
		
	</cffunction>
	<!--- collectionCommit() --->
	<cffunction name="collectionCommit" access="public" returntype="void" hint="commits a collection">
		
		<cfloop from="1" to="#count()#" index="i">
			<cfset this.getAt(i).commit() />	
		</cfloop>
	</cffunction>
</cfcomponent>