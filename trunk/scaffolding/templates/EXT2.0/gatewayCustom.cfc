<<!---
Copyright 2006-07 Objective Internet Ltd - http://www.objectiveinternet.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
--->>
<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Get an array of fields --->>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<!--- Create a list of the many to one joined objects --->>
<<cfset aJoinedObjects = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<!--- Get the primary key fields for the object --->>
<<cfset lPrimaryKeys = oMetaData.getPKListFromXML(objectName)>>
<<!--- Get the first primary key field for the object to use as name of count. --->>
<<cfset FieldName = ListFirst(oMetaData.getPKListFromXML(objectName))>>
<<cfoutput>>
	<<cfif fileExists("../templates/EXT2.0/custom/_gateway/$$objectName$$/gateway.settings.cfm")>>
		<<cfinclude template="../templates/EXT2.0/custom/_gateway/$$objectName$$/gateway.settings.cfm">>
	<</cfif>>
	
	<cffunction name="getAllWithJoin" output="false" returntype="query" hint="I get ALL the records, with an outer join to any parent tables.">
		<cfargument name="sortByFieldList" default="" type="string" required="No" Hint="I am a list of attributes by which to sort the result, In the format table|column|ASC/DESC,table|column|ASC/DESC...">
		<cfset var Query = createQuery() />
		<cfset var Order = Query.getOrder() />
		<cfset var thisOrder = "" />
	<<cfif ArrayLen(aJoinedObjects)>>
		<!--- Left join all the associated tables (uses a left join for safety). --->
		<!--- Syntax is: Query.leftJoin(joinFromObjectAlias,joinToObjectAlias,relationshipAlias) ---><</cfif>>
	<<cfloop from="1" to="$$ArrayLen(aJoinedObjects)$$" index="i">>
		<cfset Query.leftJoin("$$objectName$$", "$$aJoinedObjects[i].name$$", "$$aJoinedObjects[i].alias$$")/>
		<cfset Query.setFieldPrefix("$$aJoinedObjects[i].name$$","$$aJoinedObjects[i].alias$$_")/>
	<</cfloop>>
	
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
		<cfargument name="sortByFieldList" default="" type="string" required="No" Hint="I am a list of attributes by which to sort the result, In the format table|column|ASC/DESC,table|column|ASC/DESC..."/>
		<cfargument name="startrow" default="1" type="numeric" required="No" />
		<cfargument name="maxrows" default="0" type="numeric" required="No" />
		<cfset var QuerySkip = createQuery() />
		<cfset var OrderSkip = QuerySkip.getOrder() />
		<cfset var QueryRecordset = createQuery() />
		<cfset var OrderRecordset = QueryRecordset.getOrder() />
		<cfset var where = QueryRecordset.getWhere() />
		<cfset var qSkip = ""/>
		<cfset var thisOrder = "" />
		
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
			<cfset QuerySkip.returnObjectFields("$$objectName$$","$$lPrimaryKeys$$") />
			<cfset QuerySkip.setMaxrows(arguments.startrow) />
			<cfset qSkip = getByQuery(QuerySkip) />
			<cfset where.isNotIn("$$objectName$$","$$lPrimaryKeys$$",valuelist(qSkip.$$lPrimaryKeys$$)) />
		</cfif>
	  <<cfif ArrayLen(aJoinedObjects)>>
		<!--- Left join all the associated tables (uses a left join for safety). --->
		<!--- Syntax is: Query.leftJoin(joinFromObjectAlias,joinToObjectAlias,relationshipAlias) ---><</cfif>>
	  <<cfloop from="1" to="$$ArrayLen(aJoinedObjects)$$" index="i">>
		<cfset QueryRecordset.leftJoin("$$objectName$$", "$$aJoinedObjects[i].name$$", "$$aJoinedObjects[i].alias$$")/>
		<cfset QueryRecordset.setFieldPrefix("$$aJoinedObjects[i].name$$","$$aJoinedObjects[i].alias$$_")/>
	  <</cfloop>>
		
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
		
		<<cfsilent>>
		<<cfset lColumnsOnList = ''>>
		<<cfloop from="1" to="$$ArrayLen(aFields)$$" index="idx">>
			<<cfif aFields[idx].showOnList>>
				<<cfset lColumnsOnList = ListAppend(lColumnsOnList,"$$aFields[idx].alias$$")>>
			<</cfif>>
		<</cfloop>>
		<</cfsilent>>
		<!--- return only fields on list --->
		<cfset QueryRecordset.returnObjectFields("$$objectName$$","$$lColumnsOnList$$")>
		
		<!--- Return the query --->
		<cfreturn getByQuery(QueryRecordset) />
	</cffunction>

	<cffunction name="getRecordsForGrid" access="remote" output="false" returntype="string" hint="I return the N records in json-format.">
		<cfargument name="sortByFieldList" default="" type="string" required="No" hint="I am a list of attributes by which to sort the result, In the format table|column|ASC/DESC,table|column|ASC/DESC..."/>
		<cfargument name="startrow" default="1" type="numeric" required="No" />
		<cfargument name="maxrows" default="0" type="numeric" required="No" />
		
		<cfset var qResult = getNWithJoin(arguments.sortByFieldList,arguments.startrow,arguments.maxrows)>
		<cfset var oJSON = application.lanshock.oFactory.load('lanshock.core._utils.json.json')>
		<cfset var sResult = oJSON.encode(data=qResult,queryFormat='array')>
		
		<cfset sResult = replace(sResult,'{','{"totalRecords":#getRecordCount()#,','ONE')>
		
		<cfreturn sResult />
	</cffunction>

	<cffunction name="getOptions" access="remote" output="false" returntype="query" hint="I get the option values for this table.">
		
		<cfset var QueryRecordset = createQuery()>
		
		<!--- only select option fields --->
		<cfset QueryRecordset.setFieldExpression("$$objectName$$",variables.sOptionNameField,variables.sOptionNameCode)>
		<cfset QueryRecordset.setFieldAlias("$$objectName$$","$$lPrimaryKeys$$","optionvalue")>
		<cfset QueryRecordset.setFieldAlias("$$objectName$$",variables.sOptionNameField,"optionname")>
		<cfset QueryRecordset.returnObjectFields("$$objectName$$","optionvalue,optionname")>
		
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
		
		<cfset var oJSON = CreateObject('component','#application.lanshock.environment.componentpath#core._utils.json.json')>
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
		<cfset QueryCount.returnObjectFields("$$objectName$$","$$FieldName$$") />
		<cfset QueryCount.setFieldExpression("$$objectName$$","$$FieldName$$","COUNT(*)","CF_SQL_INTEGER") />
		<cfset qCount = getByQuery(QueryCount) />
		
		<!--- Return the recordcount --->
		<cfreturn qCount.$$FieldName$$ />
	</cffunction>
<</cfoutput>>