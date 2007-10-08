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
<<!--- Set the name of the datasource, This is used to create the names of directories and circuits --->>
<<cfset datasourceName = oMetaData.getDatasource()>>
<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<!--- Generate a list of the table fields --->>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<!--- Generate a list of the joined fields --->>
<<cfset lJoinedFields = oMetaData.getJoinedFieldListFromXML(objectName)>>
<<cfset lAllFields = ListAppend(lFields,lJoinedFields)>>
<<!--- Generate a list of the Primary Key fields --->>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<!--- Generate an array of parent objects --->>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>

<<cfoutput>>	
	<fuseaction name="$$objectName$$_Listing" access="public">
		<!-- Listing: I display a list of the records in the $$objectName$$ table. -->
		<set name="request.page.subtitle" value="$$objectName$$ List" />
		<set name="request.page.description" value="I display a list of the $$objectName$$ records in the table." />

		<xfa name="update" value="$$objectName$$_edit_form" />
		<xfa name="delete" value="$$objectName$$_delete" />
		<xfa name="display" value="$$objectName$$_display" />
		<xfa name="add" value="$$objectName$$_add_form" />
		<xfa name="grid_json" value="$$objectName$$_grid_json" />
		
		<set name="attributes._maxrows" value="10" overwrite="false" />
		<set name="attributes._startrow" value="1" overwrite="false" />
		<<cfloop list="$$lPKFields$$" index="thisPKField">>
		<set name="attributes._listSortByFieldList" value="$$objectName$$|$$thisPKField$$|ASC" overwrite="false" /><</cfloop>>
		
		<set name="fieldlist" value="$$lAllFields$$"/>
		<include circuit="udfs" template="udf_appendParam" />
		<include circuit="v$$datasourceName$$" template="dsp_list_$$objectName$$" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>

	<fuseaction name="$$objectName$$_grid_json" access="public">
		<!-- force layout: json -->
		<set name="request.layout" value="json" />
		
		<!-- params by ext.grid -->
		<set name="attributes.sort" value="$$thisPKField$$" overwrite="false" />
		<set name="attributes.dir" value="ASC" overwrite="false" />
		<set name="attributes.start" value="1" overwrite="false" />
		<set name="attributes.limit" value="20" overwrite="false" />
		
		<invoke object="Application.ao__AppObj_m$$datasourceName$$_$$objectName$$_Gateway" method="getRecordsForGrid" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="$$objectName$$|#attributes.sort#|#attributes.dir#" />
			<argument name="startrow" value="#attributes.start#" />
			<argument name="maxrows" value="#attributes.limit#" />
		</invoke>
	</fuseaction>
	
<</cfoutput>>
