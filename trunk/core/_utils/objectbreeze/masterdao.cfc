<cfcomponent name="masterDAO" hint="I create an Object and accessor methods">

	<cfset VARIABLES.DBType = "">
	<cfset VARIABLES.dsn = "">
	
	<cffunction name="init" access="public" returntype="masterDAO" hint="I initialize masterDAO">
		<cfargument name="DBType" required="true" type="string" />
		<cfargument name="dsn" required="true" type="string" />
		
		<cfset VARIABLES.DBType = ARGUMENTS.DBType />
		<cfset VARIABLES.dsn = ARGUMENTS.dsn />
		
		<cfreturn THIS />
	</cffunction>
	
<!--- CRUD methods --->
<!--- create() --->
	<cffunction name="create" access="public" returntype="Void" output="false" hint="CRUD method">
		<cfargument name="object" type="masterObject" required="yes" />
		
		<cfset var totalPropertyCount = listLen(ARGUMENTS.object.getPropertyNamesChanged()) />
		<cfset var currentPropertyNum = 0 />
		<cfset var qResultQryCreate = '' />
		
		
		<cftransaction>
			<cftry>
			<cfquery name="qryCreate" datasource="#VARIABLES.dsn#" result="qResultQryCreate">
			INSERT INTO
				#ARGUMENTS.object.getObjectName()#
			(
				<!--- only insert primary key value if it is defined, otherwise, assume identity --->
				<cfif len(ARGUMENTS.object.getID())>
					#ARGUMENTS.object.getIDName()#,
				</cfif>
				<cfloop list="#ARGUMENTS.object.getPropertyNamesChanged()#" index="columnName">
					<cfset currentPropertyNum = incrementValue(currentPropertyNum) />
					<cfif columnName NEQ ARGUMENTS.object.getIDName()>
						#columnName#<cfif currentPropertyNum NEQ totalPropertyCount>,</cfif>
					</cfif>
				</cfloop>
			)
			VALUES
			(
				<cfset currentPropertyNum = 0 />
				<!--- only insert primary key value if it is defined, otherwise, assume identity --->
				<cfif len(ARGUMENTS.object.getID())>
					'#ARGUMENTS.object.getID()#',
				</cfif>
				<cfloop list="#ARGUMENTS.object.getPropertyNamesChanged()#" index="columnName">
					<cfif columnName NEQ ARGUMENTS.object.getIDName()>
						<cfset currentPropertyNum = incrementValue(currentPropertyNum) />
						<!--- <cfif NOT isDate(ARGUMENTS.object.getProperty(columnName)) AND NOT isNumeric(ARGUMENTS.object.getProperty(columnName))><cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.object.getProperty(columnName)#" /><!--- <cfelseif isDate(ARGUMENTS.object.getProperty(columnName))>#createODBCDateTime(ARGUMENTS.object.getProperty(columnName))# ---><cfelse>'#ARGUMENTS.object.getProperty(columnName)#'</cfif><cfif currentPropertyNum NEQ totalPropertyCount>,</cfif> --->
						<cfswitch expression="#application.datasource[ARGUMENTS.object.getObjectName()].field[columnname].type#">
							<cfcase value="datetime">
								<cfif currentPropertyNum NEQ 1>,</cfif>
								<cfif NOT len(ARGUMENTS.object.getProperty(columnName))>
									<cfif application.datasource[ARGUMENTS.object.getObjectName()].field[columnname].null>
										NULL
									<cfelse>
										''
									</cfif>
								<cfelse>
									#createODBCDateTime(ARGUMENTS.object.getProperty(columnName))#
								</cfif>
							</cfcase>
							<cfcase value="integer,boolean">
								<cfif currentPropertyNum NEQ 1>,</cfif>
								<cfif len(ARGUMENTS.object.getProperty(columnName))>
									<cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.object.getProperty(columnName)#">
								<cfelse>
									0
								</cfif>
							</cfcase>
							<cfdefaultcase>
								<cfif currentPropertyNum NEQ 1>,</cfif>
								<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.object.getProperty(columnName)#">
							</cfdefaultcase>
						</cfswitch>
					</cfif>
				</cfloop>
			);
			</cfquery>
			<cfcatch><cfoutput><cfdump var="#cfcatch#"> und weg!</cfoutput><cfabort></cfcatch>
		</cftry>
			<cfquery name="qGetID" datasource="#VARIABLES.dsn#">
			<cfif NOT len(ARGUMENTS.object.getID())>
				<cfif variables.DBType EQ 'MSSQL'>
					SELECT @@IDENTITY AS newID;
				<cfelseif variables.DBType EQ 'MySQL'>
					SELECT LAST_INSERT_ID() AS newID;
				</cfif>
			</cfif>
			</cfquery>
		</cftransaction>
		
		<cfif isDefined("qGetID.newID")>
			<cfset ARGUMENTS.object.setID(qGetID.newID) />
		</cfif>
		
	</cffunction>
<!--- read() --->
	<cffunction name="read" access="public" returntype="Void" output="false" hint="CRUD method">
		<cfargument name="object" type="masterObject" required="yes" />
		<cfargument name="priKeyValue" type="string" required="yes" hint="Value of a primary key to read into the object" />
		
		<cfset var qryRead = 0 />
		<cfset var totalPropertyCount = listLen(ARGUMENTS.object.getPropertyNames(object)) />
		<cfset var currentPropertyNum = 0 />

		<cfquery name="qryRead" datasource="#VARIABLES.dsn#">
		SELECT 
			<cfloop list="#ARGUMENTS.object.getPropertyNames(object)#" index="columnName">
				<cfset currentPropertyNum = incrementValue(currentPropertyNum) />
				#columnName#<cfif currentPropertyNum NEQ totalPropertyCount>,</cfif>
			</cfloop>
		FROM 
			#ARGUMENTS.object.getObjectName()#
		WHERE
			#ARGUMENTS.object.getIDName()# = '#ARGUMENTS.priKeyValue#'
		;
		</cfquery>
		<cfif qryRead.recordCount>
			<cfloop list="#ARGUMENTS.object.getPropertyNames()#" index="columnName">
				<cfset ARGUMENTS.object.setProperty(columnName, qryRead[columnName][1], true) />
			</cfloop>
		</cfif>
		
	</cffunction>
<!--- readByProperty() --->
	<cffunction name="readByProperty" access="public" returntype="Void" output="false" hint="CRUD method">
		<cfargument name="object" type="masterObject" required="yes" />
		
		<cfset var qryRead = 0 />
		<cfset var totalPropertyCount = listLen(ARGUMENTS.object.getPropertyNames(object)) />
		<cfset var firstProp = 1 />
		<cfset currentPropertyNum = 0 />
		
		<cftry>
			<cfquery name="qryRead" datasource="#VARIABLES.dsn#">
			SELECT 
				<cfloop list="#ARGUMENTS.object.getPropertyNames(object)#" index="columnName">
					<cfset currentPropertyNum = incrementValue(currentPropertyNum) />
					#columnName#<cfif currentPropertyNum NEQ totalPropertyCount>,</cfif>
				</cfloop>
			FROM 
				#ARGUMENTS.object.getObjectName()#
			WHERE
				<cfloop list="#ARGUMENTS.object.getPropertyNames()#" index="columnName">
					<cfif len(arguments.object.getProperty(columnName))>
						<cfif NOT firstProp>
							 AND 
						</cfif>
						#columnName# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.object.getProperty(columnName)#" />
						<cfset firstProp = 0 />
					</cfif>
				</cfloop>
			;
			</cfquery>
			<cfcatch>
				<cfthrow type="objectBreeze.objectReadByProperty.Property" message="Property does not exist" detail="A property in the object you provided does not exist in the database." />
			</cfcatch>
		</cftry>
		
		<cfif qryRead.recordCount GT 1>
			<cfthrow type="objectBreeze.objectReadByProperty.RecordCount" message="Multiple rows returned when only one is allowed" detail="objectReadByProperty only allows a single record to be returned into the object." />
		<cfelseif qryRead.recordCount EQ 1>
			<cfloop list="#ARGUMENTS.object.getPropertyNames()#" index="columnName">
				<cfset ARGUMENTS.object.setProperty(columnName, qryRead[columnName][1], true) />
			</cfloop>
		</cfif>
		
	</cffunction>
<!--- readSubProperty() --->
	<cffunction name="readSubProperty" access="public" returntype="Void" output="false" hint="CRUD method - fills a compounded object">
		<cfargument name="object" type="masterObject" required="yes" />
		<cfargument name="primaryObjectKeyName" type="string" required="yes" hint="Primary object's primary key name" />
		<cfargument name="priKeyValue" type="string" required="yes" hint="Value of the primary object's primary key" />
		
		<cfset var qryRead = 0 />
		<cfset var totalPropertyCount = listLen(ARGUMENTS.object.getPropertyNames(object)) />
		<cfset var currentPropertyNum = 0 />
		
		<cfquery name="qryRead" datasource="#VARIABLES.dsn#">
		SELECT 
			<cfloop list="#ARGUMENTS.object.getPropertyNames()#" index="columnName">
				<cfset currentPropertyNum = incrementValue(currentPropertyNum) />
				#columnName#<cfif currentPropertyNum NEQ totalPropertyCount>,</cfif>
			</cfloop>
		FROM 
			#ARGUMENTS.object.getObjectName()#
		WHERE
			#ARGUMENTS.primaryObjectKeyName# = '#ARGUMENTS.priKeyValue#'
		;
		</cfquery>
		<cfif qryRead.recordCount>
			<cfloop list="#ARGUMENTS.object.getPropertyNames(object)#" index="columnName">
				<cfset ARGUMENTS.object.setProperty(columnName, qryRead[columnName][1], true) />
			</cfloop>
		</cfif>
		
	</cffunction>
<!--- update() --->
	<cffunction name="update" access="public" returntype="Void" output="false" hint="CRUD method">
		<cfargument name="object" type="masterObject" required="yes" />
		
		<cfset var totalPropertyCount = listLen(ARGUMENTS.object.getPropertyNamesChanged(object)) />
		<cfset var currentPropertyNum = 0 />
		<cfset var currentInsertString = '' />
		
		<cfquery name="qryUpdate" datasource="#VARIABLES.dsn#">
		UPDATE
			 #ARGUMENTS.object.getObjectName()#
			SET
			<cfloop list="#ARGUMENTS.object.getPropertyNamesChanged()#" index="columnName">
				<!--- don't try to update primary key --->
				<cfif columnName NEQ ARGUMENTS.object.getIDName()>
					<cfset currentPropertyNum = incrementValue(currentPropertyNum) />
					<cfswitch expression="#application.datasource[ARGUMENTS.object.getObjectName()].field[columnname].type#">
						<cfcase value="datetime">
							<cfif currentPropertyNum NEQ 1>,</cfif>
							<cfif NOT len(ARGUMENTS.object.getProperty(columnName))>
								<cfif application.datasource[ARGUMENTS.object.getObjectName()].field[columnname].null>
									#columnName# = NULL
								<cfelse>
									#columnName# = ''
								</cfif>
							<cfelse>
								#columnName# = #createODBCDateTime(ARGUMENTS.object.getProperty(columnName))#
							</cfif>
						</cfcase>
						<cfcase value="integer,boolean">
							<cfif len(ARGUMENTS.object.getProperty(columnName))>
								<cfif currentPropertyNum NEQ 1>,</cfif>
								#columnName# = <cfqueryparam cfsqltype="cf_sql_integer" value="#ARGUMENTS.object.getProperty(columnName)#">
							</cfif>
						</cfcase>
						<cfdefaultcase>
							<cfif currentPropertyNum NEQ 1>,</cfif>
							#columnName# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.object.getProperty(columnName)#">
						</cfdefaultcase>
					</cfswitch>
				</cfif>
			</cfloop>
		WHERE
			#ARGUMENTS.object.getIDName()# = '#ARGUMENTS.object.getID()#'
		;
		</cfquery>
	</cffunction>
<!--- delete() --->
	<cffunction name="delete" access="public" returntype="Void" output="false" hint="CRUD method">
		<cfargument name="object" type="masterObject" required="yes" />
		
		<cfquery name="qryDelete" datasource="#VARIABLES.dsn#">
		DELETE FROM
			 #ARGUMENTS.object.getObjectName()#
		WHERE
			#ARGUMENTS.object.getIDName()# = '#ARGUMENTS.object.getID()#'
		;
		</cfquery>
		
	</cffunction>
<!--- commit() --->
	<cffunction name="commit" access="public" returntype="Void" output="false" hint="determines create or update for object commit">
		<cfargument name="object" type="masterObject" required="yes" />
		
		<cfset var exists = 0 />
		<!--- use cftry instead of checking if the id exists so we can define a primary key value for insert as well --->
		<cftry>
			<cfquery name="qryCommit" datasource="#VARIABLES.dsn#">
			SELECT
				#ARGUMENTS.object.getIDName()#
			FROM
				#ARGUMENTS.object.getObjectName()#
			WHERE
				#ARGUMENTS.object.getIDName()# = '#ARGUMENTS.object.getID()#'
			;
			</cfquery>
			<cfif qryCommit.recordCount>
				<cfset exists = 1 />
			</cfif>
			<cfcatch type="database">
				<cfset exists = 0 />
			</cfcatch>
		</cftry>
		<cfif exists EQ 1>
			<cfset update(ARGUMENTS.object) />
		<cfelse>
			<cfset create(ARGUMENTS.object) />
		</cfif>
		
	</cffunction>
</cfcomponent>