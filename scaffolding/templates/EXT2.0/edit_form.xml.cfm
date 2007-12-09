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
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_Edit_Form" access="public">
		<lanshock:security area="$$objectName$$"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin" />
		
		<!-- Edit_Form: I display the selected $$objectName$$ record in a form which allows the user to edit it. -->
		<set name="request.page.subtitle" value="Edit $$objectName$$" />
		<set name="request.page.description" value="I display the selected $$objectName$$ record in a form which allows the user to edit it." />

		<xfa name="Save" value="$$objectName$$_Action_Update" />
		<xfa name="Cancel" value="$$objectName$$_Listing" />
		
		<reactor:record alias="$$objectName$$" returnvariable="o$$objectName$$" />
		<<cfloop list="$$lPKFields$$" index="thisPKField">>
		<set value="#o$$objectName$$.set$$thisPKField$$(attributes.$$thisPKField$$)#" /><</cfloop>>
		<invoke object="o$$objectName$$" method="load" />
		<<cfloop from="1" to="$$ArrayLen(aManyToOne)$$" index="i">>
		<set name="variables.sortByFieldList" value="" />
		<invoke object="Application.ao__AppObj_m$$datasourceName$$_$$aManyToOne[i].name$$_Gateway" method="getAll" returnvariable="q$$aManyToOne[i].name$$">
			<argument name="sortByFieldList" value="#variables.sortByFieldList#" />
		</invoke><</cfloop>>
		
		<set name="fieldlist" value="$$lAllFields$$"/>
		<set name="mode" value="edit" />
		<include circuit="udfs" template="udf_appendParam" />
		<include circuit="v_$$sModule$$" template="dsp_form_$$objectName$$" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
	
<</cfoutput>>
