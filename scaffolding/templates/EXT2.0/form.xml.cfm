<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<cfset aManyToOne = oMetaData.getRelationshipsFromXML(objectName,"manyToOne")>>
<<cfset aManyToMany = oMetaData.getRelationshipsFromXML(objectName,"manyToMany")>>
<<cfset aOneToMany = oMetaData.getRelationshipsFromXML(objectName,"oneToMany")>>
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_add_form" access="public">
		<set name="mode" value="insert" />
		<xfa name="save" value="$$objectName$$_action_add" />
		<do action="$$objectName$$_form"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_edit_form" access="public">
		<set name="mode" value="edit" />
		<xfa name="save" value="$$objectName$$_action_update" />
		<do action="$$objectName$$_form"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_form" access="private" lanshock:includedCircuit="true">
		<lanshock:security area="$$objectName$$"/>
		<set name="request.layout" value="admin" />
		<xfa name="cancel" value="$$objectName$$_listing" />
		
		<reactor:record alias="$$objectName$$" returnvariable="o$$objectName$$" />
		<if condition="variables.mode EQ 'edit'">
			<true>
				<<cfloop list="$$lPKFields$$" index="thisPKField">>
				<set value="#o$$objectName$$.set$$thisPKField$$(attributes.$$thisPKField$$)#" /><</cfloop>>
				<invoke object="o$$objectName$$" method="load" />
			</true>
		</if>
		
		<do action="$$objectName$$_form_loadrelated"/>
		
		<include circuit="udfs" template="udf_appendParam" />
		<include circuit="v_$$sModule$$" template="dsp_form_$$objectName$$" contentvariable="request.page.pageContent" append="true" />
	</fuseaction>
	
	<fuseaction name="$$objectName$$_form_loadrelated" access="private" lanshock:includedCircuit="true">
		<set name="stRelated" value="#StructNew()#"/>
		<set name="stRelated.stManyToOne" value="#StructNew()#"/>
		<set name="stRelated.stManyToMany" value="#StructNew()#"/>
		<set name="stRelated.stOneToMany" value="#StructNew()#"/>
		
		<!-- stManyToOne -->
		<<cfloop from="1" to="$$ArrayLen(aManyToOne)$$" index="i">>
		<invoke object="application.lanshock.oFactory.load('$$aManyToOne[i].name$$','reactorGateway')" method="getOptions" returnvariable="stRelated.stManyToOne.$$aManyToOne[i].name$$.qData"/>
		<</cfloop>>
		
		<!-- stManyToMany -->
		<<cfloop from="1" to="$$ArrayLen(aManyToMany)$$" index="i">>
			<<cfset aRelOneToMany = oMetaData.getRelationshipsFromXML(aManyToMany[i].alias,"oneToMany")>>
			<<cfloop from="1" to="$$ArrayLen(aRelOneToMany)$$" index="i2">>
				<<cfif aRelOneToMany[i2].alias NEQ objectName>>
					<invoke object="application.lanshock.oFactory.load('$$aManyToMany[i].name$$','reactorGateway')" method="getRelOptions" returnvariable="stRelated.stManyToMany.$$aManyToMany[i].name$$.qData">
						<argument name="sRelTable" value="$$aRelOneToMany[i2].alias$$" />
					</invoke>
				<</cfif>>
			<</cfloop>>
		<</cfloop>>
		
		<!-- stOneToMany -->
		<<cfloop from="1" to="$$ArrayLen(aOneToMany)$$" index="i">>
		<invoke object="application.lanshock.oFactory.load('$$aOneToMany[i].name$$','reactorGateway')" method="getOptions" returnvariable="stRelated.stOneToMany.$$aOneToMany[i].name$$.qData"/>
		<</cfloop>>
	</fuseaction>
<</cfoutput>>