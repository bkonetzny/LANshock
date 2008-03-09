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
	<fuseaction name="$$objectName$$_Display" access="public">
		<!-- Display: I display the selected $$objectName$$ record. -->
		<set name="request.page.subtitle" value="View $$objectName$$" />
		<set name="request.page.description" value="I display the selected $$objectName$$ record." />

		<xfa name="Edit" value="$$objectName$$_Edit_Form" />
		<xfa name="Delete" value="$$objectName$$_Action_Delete" />
		<xfa name="List" value="$$objectName$$_Listing" />

		<reactor:record alias="$$objectName$$" returnvariable="o$$objectName$$" />
		<<cfloop list="lPKFields" index="thisPKField">>
		<set value="#o$$objectName$$.set$$thisPKField$$(attributes.$$thisPKField$$)#" /><</cfloop>>
		<invoke object="o$$objectName$$" method="load" />
		
		<set name="fieldlist" value="$$lAllFields$$"/>
		<include circuit="udfs" template="udf_appendParam" />
		<include circuit="v_$$sModule$$" template="display/dsp_display_$$objectName$$" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
	
<</cfoutput>>
