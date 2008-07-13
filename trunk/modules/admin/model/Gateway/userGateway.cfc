<cfcomponent displayname="userGateway.cfc" extends="reactor.project.lanshock.Gateway.userGateway">
<!--- Start of gatewayCustom code generated by fusebox scaffolder, it will be replaced if fusebox scaffolder is rerun. --->
<cfset variables.sOptionNameField = "name">
	<cfset variables.sOptionNameCode = "">
	
	
		
	<cfset variables.sOptionNameField = "firstname">
	<cfset variables.sOptionNameCode = "concat(firstname,"" "",lastname)">
	
	<cffunction name="getRecords" access="public" hint="I return all matching rows from the table." output="false" returntype="query">
		<cfargument name="stFilter" type="struct" required="false" default="#StructNew()#">
		
		<cfset var Query = createQuery()>
		<cfset var Where = Query.getWhere()>
		<cfset var idx = 0>
		<cfset var sCurrentField = ''>
		<cfset var sCurrentTable = ''>
		<cfset var sSortTable = ''>
		<cfset var sSortField = ''>
		<cfset var sSortDirection = 'ASC'>
	
		<cfif NOT StructIsEmpty(arguments.stFilter)>
	
			<cfif StructKeyExists(arguments.stFilter,'stJoins')>
				<cfset Query.returnObjectFields("user","id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,logincount,language,geo_latlong,country,city,street,zip,reset_password_key,openid_url,data_access")>
				
				<cfloop collection="#arguments.stFilter.stJoins#" item="idx">
					<cfset idx = lCase(idx)>
					<cfset Query.leftJoin("user",idx,idx)>
					<cfset Query.setFieldPrefix(idx,"#idx#_")>
					<cfset Query.returnObjectFields(idx,arguments.stFilter.stJoins[idx])>
				</cfloop>
			</cfif>
		
			<cfif StructKeyExists(arguments.stFilter,'stFields')>
				<cfloop collection="#arguments.stFilter.stFields#" item="idx">
					<cfset idx = lCase(idx)>
					<cfif ListLen(idx,'|') EQ 2>
						<cfset sCurrentTable = ListFirst(idx,'|')>
						<cfset sCurrentField = ListLast(idx,'|')>
					<cfelse>
						<cfset sCurrentTable = "user">
						<cfset sCurrentField = idx>
					</cfif>
					<cfswitch expression="#arguments.stFilter.stFields[idx].mode#">
						<cfcase value="isEqual">
							<cfset Where.isEqual(sCurrentTable,sCurrentField,arguments.stFilter.stFields[idx].value)>
						</cfcase>
						<cfcase value="isLike">
							<cfset Where.isLike(sCurrentTable,sCurrentField,arguments.stFilter.stFields[idx].value)>
						</cfcase>
					</cfswitch>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(arguments.stFilter,'lSortFields')>
				<cfloop list="#arguments.stFilter.lSortFields#" index="idx">
					<cfset idx = lCase(idx)>
					<cfset sSortDirection = 'ASC'>
					<cfset sSortField = idx>
					<cfif ListLen(idx,'|') EQ 2>
						<cfset idx = ListPrepend(idx,"user",'|')>
					</cfif>
					<cfif ListLen(idx,'|') EQ 3 AND ListFindNoCase('ASC,DESC',ListLast(idx,'|'))>
						<cfset sSortDirection = UCase(ListLast(idx,'|'))>
						<cfset sSortTable = ListFirst(idx,'|')>
						<cfset sSortField = ListGetAt(idx,2,'|')>
					</cfif>
					<cfif sSortDirection EQ 'DESC'>
						<cfset Query.getOrder().setDesc(sSortTable,sSortField)>
					<cfelse>
						<cfset Query.getOrder().setAsc(sSortTable,sSortField)>
					</cfif>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(arguments.stFilter,'iRecords')>
				<cfset Query.setMaxrows(arguments.stFilter.iRecords)>
			</cfif>
		</cfif>
		
		<cfreturn getByQuery(Query,true)>
	</cffunction>
	
	<cffunction name="getAllWithJoin" output="false" returntype="query" hint="I get ALL the records, with an outer join to any parent tables.">
		<cfargument name="sortByFieldList" default="" type="string" required="No" Hint="I am a list of attributes by which to sort the result, In the format table|column|ASC/DESC,table|column|ASC/DESC...">
		<cfset var Query = createQuery() />
		<cfset var Order = Query.getOrder() />
		<cfset var thisOrder = "" />
	
	
	
		<cfloop list="#arguments.sortByFieldList#" index="thisOrder">
			<cfif ListGetAt(thisOrder,3,"|") IS "ASC">
				<cfset Order.setAsc(ListGetAt(thisOrder,1,"|"),ListGetAt(thisOrder,2,"|")) />
			<cfelse>
				<cfset Order.setDesc(ListGetAt(thisOrder,1,"|"),ListGetAt(thisOrder,2,"|")) />
			</cfif>
		</cfloop>
		
		<!--- Return the query --->
		<cfreturn getByQuery(Query) />
	</cffunction>
	<cffunction name="getNWithJoin" output="false" returntype="query" hint="I get the selected N records, with an outer join to any parent tables.">
		<cfargument name="sortByFieldList" type="string" required="false" default="" hint="I am a list of attributes by which to sort the result, In the format table|column|ASC/DESC,table|column|ASC/DESC..."/>
		<cfargument name="startrow" type="numeric" required="false" default="1" />
		<cfargument name="maxrows" type="numeric" required="false" default="0" />
		<cfargument name="filter" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var QuerySkip = createQuery() />
		<cfset var OrderSkip = QuerySkip.getOrder() />
		<cfset var QueryRecordset = createQuery() />
		<cfset var OrderRecordset = QueryRecordset.getOrder() />
		<cfset var where = QueryRecordset.getWhere() />
		<cfset var qSkip = ""/>
		<cfset var thisOrder = "" />
		<cfset var idxFilter = "" />
		<cfset var bFilterColumn = false>
		
		<cfif arguments.startrow GT 1>
			<!--- Set up the sort order for the skipped records --->
			<cfloop list="#arguments.sortByFieldList#" index="thisOrder">
				<cfif ListGetAt(thisOrder,3,"|") IS "ASC">
					<cfset OrderSkip.setAsc(ListGetAt(thisOrder,1,"|"),ListGetAt(thisOrder,2,"|")) />
				<cfelse>
					<cfset OrderSkip.setDesc(ListGetAt(thisOrder,1,"|"),ListGetAt(thisOrder,2,"|")) />
				</cfif>
			</cfloop>
			<!--- Get the Primary Keys of the records we want to skip --->
			<cfset QuerySkip.returnObjectFields("user","id") />
			<cfset QuerySkip.setMaxrows(arguments.startrow) />
			<cfset qSkip = getByQuery(QuerySkip) />
			<cfset where.isNotIn("user","id",valuelist(qSkip.id)) />
		</cfif>
	  
	  
		<cfif isStruct(arguments.filter)>
			<cfset QueryRecordset.getWhere().setMode("OR")>
			
				<cfif StructKeyExists(arguments.filter,'id')>
					
							<cfset bFilterColumn = false>
							<cfif isNumeric(arguments.filter['id'])>
								<cfset bFilterColumn = true>
							</cfif>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'id',arguments.filter['id'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'name')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'name',arguments.filter['name'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'email')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'email',arguments.filter['email'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'pwd')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'pwd',arguments.filter['pwd'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'firstname')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'firstname',arguments.filter['firstname'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'lastname')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'lastname',arguments.filter['lastname'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'gender')>
					
							<cfset bFilterColumn = false>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'gender',arguments.filter['gender'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'status')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'status',arguments.filter['status'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'signature')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'signature',arguments.filter['signature'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'homepage')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'homepage',arguments.filter['homepage'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'internal_note')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'internal_note',arguments.filter['internal_note'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'dt_birthdate')>
					
							<cfset bFilterColumn = false>
							<cfif LsIsDate(arguments.filter['dt_birthdate'])>
								<cfset bFilterColumn = true>
							</cfif>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'dt_birthdate',arguments.filter['dt_birthdate'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'dt_lastlogin')>
					
							<cfset bFilterColumn = false>
							<cfif LsIsDate(arguments.filter['dt_lastlogin'])>
								<cfset bFilterColumn = true>
							</cfif>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'dt_lastlogin',arguments.filter['dt_lastlogin'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'dt_registered')>
					
							<cfset bFilterColumn = false>
							<cfif LsIsDate(arguments.filter['dt_registered'])>
								<cfset bFilterColumn = true>
							</cfif>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'dt_registered',arguments.filter['dt_registered'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'logincount')>
					
							<cfset bFilterColumn = false>
							<cfif isNumeric(arguments.filter['logincount'])>
								<cfset bFilterColumn = true>
							</cfif>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'logincount',arguments.filter['logincount'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'language')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'language',arguments.filter['language'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'geo_latlong')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'geo_latlong',arguments.filter['geo_latlong'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'country')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'country',arguments.filter['country'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'city')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'city',arguments.filter['city'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'street')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'street',arguments.filter['street'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'zip')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'zip',arguments.filter['zip'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'reset_password_key')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'reset_password_key',arguments.filter['reset_password_key'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'openid_url')>
					
							<cfset bFilterColumn = true>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'openid_url',arguments.filter['openid_url'])>
					</cfif>
				</cfif>
			
				<cfif StructKeyExists(arguments.filter,'data_access')>
					
							<cfset bFilterColumn = false>
						
					<cfif bFilterColumn>
						<cfset QueryRecordset.getWhere().isLike("user",'data_access',arguments.filter['data_access'])>
					</cfif>
				</cfif>
			
		</cfif>
		
		<!--- Set up the sort order for the required records --->
		<cfloop list="#arguments.sortByFieldList#" index="thisOrder">
			<cfif ListGetAt(thisOrder,3,"|") IS "ASC">
				<cfset OrderRecordset.setAsc(ListGetAt(thisOrder,1,"|"),ListGetAt(thisOrder,2,"|")) />
			<cfelse>
				<cfset OrderRecordset.setDesc(ListGetAt(thisOrder,1,"|"),ListGetAt(thisOrder,2,"|")) />
			</cfif>
		</cfloop>
		<cfif arguments.maxrows GT 0>
			<cfset QueryRecordset.setMaxrows(arguments.maxrows) />
		</cfif>
		
		
		<!--- return only fields on list --->
		<cfset QueryRecordset.returnObjectFields("user","id,name,email,firstname,lastname")>
		
		<!--- Return the query --->
		<cfreturn getByQuery(QueryRecordset) />
	</cffunction>
	<cffunction name="getRecordsForGrid" access="remote" output="false" returntype="string" hint="I return the N records in json-format.">
		<cfargument name="sortByFieldList" type="string" required="false" default="" hint="I am a list of attributes by which to sort the result, In the format table|column|ASC/DESC,table|column|ASC/DESC..."/>
		<cfargument name="startrow" type="numeric" required="false" default="1" />
		<cfargument name="maxrows" type="numeric" required="false" default="0" />
		<cfargument name="filter" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var qResult = getNWithJoin(arguments.sortByFieldList,arguments.startrow,arguments.maxrows,arguments.filter)>
		<cfset var oJSON = application.lanshock.oFactory.load('lanshock.core._utils.json.json')>
		<cfset var sResult = oJSON.encode(data=qResult,queryFormat='array')>
		
		<cfset sResult = replace(sResult,'{','{"totalRecords":#getRecordCount()#,','ONE')>
		
		<cfreturn sResult />
	</cffunction>
	<cffunction name="getOptions" access="remote" output="false" returntype="query" hint="I get the option values for this table.">
		
		<cfset var QueryRecordset = createQuery()>
		
		<!--- only select option fields --->
		<cfif len(variables.sOptionNameCode)>
			<cfset QueryRecordset.setFieldExpression("user",variables.sOptionNameField,variables.sOptionNameCode)>
		</cfif>
		<cfset QueryRecordset.setFieldAlias("user","id","optionvalue")>
		<cfset QueryRecordset.setFieldAlias("user",variables.sOptionNameField,"optionname")>
		<cfset QueryRecordset.returnObjectFields("user","optionvalue,optionname")>
		
		<!--- Return the query --->
		<cfreturn getByQuery(QueryRecordset) />
	</cffunction>
	<cffunction name="getRelOptions" access="remote" output="false" returntype="query" hint="I get the option values for this table.">
		<cfargument name="sRelTable" type="string" required="true">
		
		<cfset var qData = application.lanshock.oFactory.load(arguments.sRelTable,'reactorGateway').getOptions()>
		<cfreturn qData />
	</cffunction>
	
	<cffunction name="deleteByIDlist" access="remote" output="false" returntype="void" hint="I delete the selected N records">
		<cfargument name="jsonData" default="" type="string" required="No" Hint="I am the json data to delete"/>
		
		<cfset var oJSON = application.lanshock.oFactory.load('lanshock.core._utils.json.json')>
		<cfset var aResult = oJSON.decode(data=arguments.jsonData)>
		<cfset var idx = ''>
		<cfloop from="1" to="#ArrayLen(aResult)#" index="idx">
			<cfset deleteByFields(argumentcollection=aResult[idx])>
		</cfloop>
	</cffunction>
	<cffunction name="getRecordCount" output="false" returntype="numeric" hint="I get the number of records in the table.">
		<cfset var QueryCount = createQuery() />
		<cfset var qCount = ""/>
		
		<!--- Get the recordcount for the table --->
		<!--- There is a bug in Reactor which requires that the count field must be named the same as a real field in the table. --->
		<cfset QueryCount.returnObjectFields("user","id") />
		<cfset QueryCount.setFieldExpression("user","id","COUNT(*)","CF_SQL_INTEGER") />
		<cfset qCount = getByQuery(QueryCount) />
		
		<!--- Return the recordcount --->
		<cfreturn qCount.id />
	</cffunction>
<!--- End of gatewayCustom code generated by fusebox scaffolder. --->
</cfcomponent>
