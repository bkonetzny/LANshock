<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset aFields = oMetaData.getFieldsFromXML(objectName)>>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<cfset aJoinedObjects = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfset lPrimaryKeys = oMetaData.getPKListFromXML(objectName)>>
<<cfset FieldName = ListFirst(oMetaData.getPKListFromXML(objectName))>>
<<cfoutput>>
	<<cfif fileExists("../templates/EXT2.0/custom/_gateway/$$objectName$$/gateway.settings.cfm")>>
		<<cfinclude template="../templates/EXT2.0/custom/_gateway/$$objectName$$/gateway.settings.cfm">>
	<</cfif>>
	<cffunction name="getRecords" access="public" hint="I return all matching rows from the table." output="false" returntype="query">
		<cfargument name="stFilter" type="struct" required="false" default="#StructNew()#">
		
		<cfset var Query = createQuery()>
		<cfset var Where = Query.getWhere()>
		<cfset var idx = 0 />
		<cfset var sCurrentField = ''>
		<cfset var sSortField = ''>
		<cfset var sSortDirection = 'ASC'>
	
		<cfif NOT StructIsEmpty(arguments.stFilter)>
	
			<cfif StructKeyExists(arguments.stFilter,'stJoins')>
				<cfset Query.returnObjectFields("news_entry","$$lFields$$")>
				
				<cfloop collection="#arguments.stFilter.stJoins#" item="idx">
					<cfset Query.leftJoin("news_entry",idx,idx)/>
					<cfset Query.setFieldPrefix(idx,"#idx#_")/>
					<cfset Query.returnObjectFields(idx,arguments.stFilter.stJoins[idx])>
				</cfloop>
			</cfif>
		
			<cfif StructKeyExists(arguments.stFilter,'stFields')>
				<cfloop collection="#arguments.stFilter.stFields#" item="idx">
					<cfset sCurrentField = idx>
					<cfswitch expression="#arguments.stFilter.stFields[sCurrentField].mode#">
						<cfcase value="isEqual">
							<cfset Where.isEqual(_getAlias(),sCurrentField,arguments.stFilter.stFields[sCurrentField].value)>
						</cfcase>
						<cfcase value="isLike">
							<cfset Where.isLike(_getAlias(),sCurrentField,arguments.stFilter.stFields[sCurrentField].value)>
						</cfcase>
					</cfswitch>
				</cfloop>
			</cfif>
			
			<cfif StructKeyExists(arguments.stFilter,'lSortFields')>
				<cfloop list="#arguments.stFilter.lSortFields#" index="idx">
					<cfset sSortDirection = 'ASC'>
					<cfset sSortField = idx>
					<cfif ListLen(idx,'|') EQ 2 AND ListFindNoCase('ASC,DESC',ListLast(idx,'|'))>
						<cfset sSortDirection = UCase(ListLast(idx,'|'))>
						<cfset sSortField = ListFirst(idx,'|')>
					</cfif>
					<cfif sSortDirection EQ 'DESC'>
						<cfset Query.getOrder().setDesc("$$objectName$$",sSortField)>
					<cfelse>
						<cfset Query.getOrder().setAsc("$$objectName$$",sSortField)>
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
	  
		<cfloop collection="#arguments.filter#" item="idxFilter">
			<cfif ListLast(idxFilter,'.') EQ 'field'>
				<cfset QueryRecordset.getWhere().isLike("$$objectName$$", arguments.filter[idxFilter], arguments.filter['filter.'&ListGetAt(idxFilter,2,'.')&'.data.value'])>
			</cfif>
		</cfloop>
		
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
		<cfif StructKeyExists(variables,'sOptionNameCode')>
			<cfset QueryRecordset.setFieldExpression("$$objectName$$",variables.sOptionNameField,variables.sOptionNameCode)>
		</cfif>
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
		
		<cfset var oJSON = CreateObject('component','#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.json.json')>
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