<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lFields = oMetaData.getFieldListFromXML(objectName)>>
<<cfset stFields.aTable = oMetaData.getFieldsFromXML(objectName)>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<<cfset aManyToMany = oMetaData.getRelationshipsFromXML(objectName,"manyToMany")>>
<<cfset sModule = oMetaData.getModule()>>

<<cfoutput>>
	<fuseaction name="$$objectName$$_action_add" access="public">
		<set name="mode" value="insert" />
		<xfa name="save" value="$$objectName$$_action_add" />
		<do action="$$objectName$$_action_save"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_action_update" access="public">
		<set name="mode" value="edit" />
		<xfa name="save" value="$$objectName$$_action_update" />
		<do action="$$objectName$$_action_save"/>
	</fuseaction>
	
	<fuseaction name="$$objectName$$_action_save" access="private" lanshock:includedCircuit="true">
		<lanshock:security area="$$objectName$$"/>
		<set name="bHasErrors" value="false" />
		
		<xfa name="continue" value="$$objectName$$_listing" />
		<xfa name="cancel" value="$$objectName$$_listing" />
		
		<<cfset idxRelation = 'aTable'>>
		<<cfloop from="1" to="$$ArrayLen(stFields[idxRelation])$$" index="i">>
			<<cfmodule template="../templates/EXT2.0/rowtypes/rowtype.cfm" rowtype="$$stFields[idxRelation][i].formType$$" method="xml_validation_pre">>
		<</cfloop>>
		
		<set name="attributes.$$objectName$$_id" value="0" overwrite="false"/>
		<reactor:record alias="$$objectName$$" returnvariable="o$$objectName$$" />
		<if condition="variables.mode EQ 'insert'">
			<true>
				<<cfloop list="$$lFields$$" index="thisField">><<cfif NOT ListFindNoCase(lPKFields,thisField)>>
				<set value="#o$$objectName$$.set$$thisField$$(attributes.$$thisField$$)#" /><</cfif>><</cfloop>>
			</true>
			<false>
				<<cfloop list="$$lFields$$" index="thisField">>
				<set value="#o$$objectName$$.set$$thisField$$(attributes.$$thisField$$)#" /><</cfloop>>
			</false>
		</if>
		
		<if condition="bHasErrors">
			<false>
				<invoke object="o$$objectName$$" method="validate" />
				<set name="bObjectValid" value="#NOT o$$objectName$$.hasErrors()#" />
				<if condition="variables.bObjectValid">
					<false>
						<set name="bHasErrors" value="true" />
					</false>
				</if>
			</false>
		</if>
		
		<<cfloop from="1" to="$$ArrayLen(aManyToMany)$$" index="i">>
		<if condition="bHasErrors">
			<false>
				<invoke object="o$$objectName$$" method="get$$aManyToMany[i].name$$iterator" returnvariable="o$$aManyToMany[i].name$$iterator" />
				<invoke object="o$$aManyToMany[i].name$$iterator" method="deleteAll" />
				<if condition="StructKeyExists(attributes,'$$aManyToMany[i].name$$')">
					<true>
						<loop list="#attributes.$$aManyToMany[i].name$$#" index="idx">
							<invoke object="o$$aManyToMany[i].name$$iterator" method="add">
								<argument name="$$aManyToMany[i].links[1].to$$" value="#o$$objectName$$.get$$lPKFields$$()#"/>
								<argument name="$$aManyToMany[i].links[1].name$$" value="#idx#"/>
							</invoke>
						</loop>
					</true>
				</if>
				<invoke object="o$$aManyToMany[i].name$$iterator" method="validate" />
				<set name="bRel$$aManyToMany[i].name$$Valid" value="#NOT o$$aManyToMany[i].name$$iterator.hasErrors()#"/>
				<if condition="variables.bRel$$aManyToMany[i].name$$Valid">
					<false>
						<set name="bHasErrors" value="true" />
					</false>
				</if>
			</false>
		</if>
		<</cfloop>>

		<if condition="bHasErrors">
			<false>
				<invoke object="o$$objectName$$" method="save" />
				<relocate url="#application.lanshock.oHelper.buildUrl('#XFA.Continue#&amp;_listSortByFieldList=#URLEncodedFormat(attributes._listSortByFieldList)#&amp;_startrow=#attributes._Startrow#&amp;_maxrows=#attributes._Maxrows#')#" />
			</false>
			<true>
				<set name="request.layout" value="admin"/>
				
				<do action="$$objectName$$_form_loadrelated"/>
				
				<include circuit="udfs" template="udf_appendParam" />
				
				<set name="aErrors" value="#o$$objectName$$._getErrorCollection().getErrors()#" />
				<set name="aTranslatedErrors" value="#o$$objectName$$._getErrorCollection().getTranslatedErrors()#" />
				
				<include circuit="v_$$sModule$$" template="dsp_form_$$objectName$$" contentvariable="request.page.pageContent" append="true" />
			</true>
		</if>
	</fuseaction>
	
<</cfoutput>>
