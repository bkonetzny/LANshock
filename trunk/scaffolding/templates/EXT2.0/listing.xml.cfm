<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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
	<fuseaction name="$$objectName$$_listing" access="public">
		<lanshock:security area="$$objectName$$"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin" />
		
		<!-- Listing: I display a list of the records in the $$objectName$$ table. -->
		<set name="request.page.objectName" value="$$objectName$$" />
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
		
		<set name="fieldlist" value="$$lAllFields$$" />
		<include circuit="udfs" template="udf_appendParam" />
		<include circuit="v_$$sModule$$" template="list/dsp_list_$$objectName$$" />
	</fuseaction>

	<fuseaction name="$$objectName$$_grid_json" access="public" lanshock:showlayout="none">
		<lanshock:security area="$$objectName$$"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json" />
		
		<!-- params by ext.grid -->
		<include circuit="$$sModule$$" template="act_json_filter" />
		
		<invoke object="application.lanshock.oFactory.load('$$objectName$$','reactorGateway')" method="getRecordsForGrid" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="$$objectName$$|#attributes.sort#|#attributes.dir#" />
			<argument name="startrow" value="#attributes.start#" />
			<argument name="maxrows" value="#attributes.limit#" />
			<argument name="filter" value="#stFilters#" />
		</invoke>
	</fuseaction>
	
<</cfoutput>>
