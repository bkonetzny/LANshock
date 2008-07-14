<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent>
	
	<cffunction name="createConfig" output="false" returntype="void">

		<cfset var sConfig = ''>
		<cfset var sObjectsXML = ''>
		<cfset var idxTables = ''>
		<cfset var idxFields = ''>
		<cfset var idxRelations = ''>
		<cfset var idxManyToMany = ''>
		<cfset var idxFormData = ''>
		<cfset var sManyToManySourceColumn = ''>
		<cfset var sManyToManyTargetColumn = ''>
		<cfset var lTables = ''>
		<cfset var stDatasource = StructNew()>
		<cfset var stScaffoldingCustom = StructNew()>
		<cfset var stRuntimeConfig = application.lanshock.oRuntime.getRuntimeConfig()>
		<!--- <cfset var bCreateList = true>
		<cfset var bCreateForm = true> --->
		<cfset var qProjectFiles = 0>
		<cfset var sFormType = ''>
		
		<cfinvoke component="#application.lanshock.oModules#" method="getDatasourceStructure" returnvariable="stDatasource"/>
		
		<cfset lTables = ListSort(StructKeyList(stDatasource),'textnocase')>

		<cfloop list="#lTables#" index="idxTables">
			<cfset idxTables = LCase(idxTables)>
			<cfset stScaffoldingCustom = StructNew()>
			<!--- <cfset bCreateList = true>
			<cfset bCreateForm = true> --->
			
			<cfif StructKeyExists(stDatasource[idxTables],'module')>
				<cfset stScaffoldingCustom = getScaffoldingData(stDatasource[idxTables].module,idxTables)>
			</cfif>
			
			<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9)>
			<cfset sObjectsXML = sObjectsXML & '<object name="#idxTables#" alias="#idxTables#"'>
			<cfif NOT StructIsEmpty(stScaffoldingCustom)
					AND NOT StructIsEmpty(stScaffoldingCustom.stList)
					AND len(stScaffoldingCustom.stList.sSortDefault)>
				<cfset sObjectsXML = sObjectsXML & ' sSortDefault="#stScaffoldingCustom.stList.sSortDefault#"'>
			</cfif>
			<cfset sObjectsXML = sObjectsXML & '>'>
			<!--- <cfset sObjectsXML = sObjectsXML & '<object name="#idxTables#" alias="#idxTables#" customCreateList="#bCreateList#" customCreateForm="#bCreateForm#">'> --->
			<cfloop from="1" to="#ArrayLen(stDatasource[idxTables].field)#" index="idxFields">
				<cfset sFormType = ''>

				<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & chr(9)>
				<cfset sObjectsXML = sObjectsXML & '<field name="#stDatasource[idxTables].field[idxFields].name#" alias="#stDatasource[idxTables].field[idxFields].name#"'>
				<cfif isDefined("stDatasource[idxTables].pk[1].fields") AND
					ListFindNoCase(stDatasource[idxTables].pk[1].fields,stDatasource[idxTables].field[idxFields].name)>
					<cfset sObjectsXML = sObjectsXML & ' formType="PkField" primaryKeySeq="1"'>
				<cfelse>
					<cfif NOT StructIsEmpty(stScaffoldingCustom)
						AND NOT StructIsEmpty(stScaffoldingCustom.stForm)
						AND ArrayLen(stScaffoldingCustom.stForm.aData)>
						<cfloop from="1" to="#ArrayLen(stScaffoldingCustom.stForm.aData)#" index="idxFormData">
							<cfif stScaffoldingCustom.stForm.aData[idxFormData].XmlAttributes.name EQ stDatasource[idxTables].field[idxFields].name>
								<cfset sFormType = stScaffoldingCustom.stForm.aData[idxFormData].XmlAttributes.formType>
							</cfif>
						</cfloop>
					</cfif>
					<cfif NOT len(sFormType)>
						<cfset sFormType = getFormTypeByDbType(stDatasource[idxTables].field[idxFields].type)>
					</cfif>
					<cfset sObjectsXML = sObjectsXML & ' formType="#sFormType#" primaryKeySeq="0"'>
				</cfif>
				<cfset sObjectsXML = sObjectsXML & ' format="trim"'>
				<cfif StructKeyExists(stDatasource[idxTables].field[idxFields],'len')>
					<cfset sObjectsXML = sObjectsXML & ' maxlength="#stDatasource[idxTables].field[idxFields].len#"'>
				</cfif>
				<cfif StructKeyExists(stDatasource[idxTables].field[idxFields],'null')
					AND stDatasource[idxTables].field[idxFields].null>
					<cfset sObjectsXML = sObjectsXML & ' required="false"'>
				<cfelse>
					<cfset sObjectsXML = sObjectsXML & ' required="true"'>
				</cfif>
				<cfif NOT StructIsEmpty(stScaffoldingCustom)
					AND NOT StructIsEmpty(stScaffoldingCustom.stForm)
					AND len(stScaffoldingCustom.stForm.lFields)>
					<cfif ListFindNoCase(stScaffoldingCustom.stForm.lFields,stDatasource[idxTables].field[idxFields].name)>
						<cfset sObjectsXML = sObjectsXML & ' showOnForm="true"'>
					<cfelse>
						<cfset sObjectsXML = sObjectsXML & ' showOnForm="false"'>
					</cfif>
				<cfelse>
					<cfset sObjectsXML = sObjectsXML & ' showOnForm="true"'>
				</cfif>
				<cfif NOT StructIsEmpty(stScaffoldingCustom)
					AND NOT StructIsEmpty(stScaffoldingCustom.stList)
					AND len(stScaffoldingCustom.stList.lFields)>
					<cfif ListFindNoCase(stScaffoldingCustom.stList.lFields,stDatasource[idxTables].field[idxFields].name)>
						<cfset sObjectsXML = sObjectsXML & ' showOnList="true"'>
					<cfelse>
						<cfset sObjectsXML = sObjectsXML & ' showOnList="false"'>
					</cfif>
				<cfelse>
					<cfset sObjectsXML = sObjectsXML & ' showOnList="true"'>
				</cfif>
				<cfset sObjectsXML = sObjectsXML & ' type="#stDatasource[idxTables].field[idxFields].type#" sqlType="CF_SQL_#UCase(stDatasource[idxTables].field[idxFields].type)#" fuseDocType="#stDatasource[idxTables].field[idxFields].type#"'>
				<cfset sObjectsXML = sObjectsXML & '/>'>
			</cfloop>
			<cfloop from="1" to="#ArrayLen(stDatasource[idxTables].fk)#" index="idxRelations">
				<cfif StructKeyExists(stDatasource[idxTables].fk[idxRelations],'type')>
					<cfswitch expression="#stDatasource[idxTables].fk[idxRelations].type#">
						<cfcase value="manyToOne">
							<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & chr(9)>
							<cfset sObjectsXML = sObjectsXML & '<manyToOne name="#ListFirst(stDatasource[idxTables].fk[idxRelations].mapping,'.')#">'>
							<cfset sObjectsXML = sObjectsXML & '<relate from="#stDatasource[idxTables].fk[idxRelations].field#" to="#ListLast(stDatasource[idxTables].fk[idxRelations].mapping,'.')#"/>'>
							<cfset sObjectsXML = sObjectsXML & '</manyToOne>'>
						</cfcase>
						<cfcase value="oneToMany">
							<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & chr(9)>
							<cfset sObjectsXML = sObjectsXML & '<oneToMany name="#ListFirst(stDatasource[idxTables].fk[idxRelations].mapping,'.')#">'>
							<cfset sObjectsXML = sObjectsXML & '<relate from="#stDatasource[idxTables].fk[idxRelations].field#" to="#ListLast(stDatasource[idxTables].fk[idxRelations].mapping,'.')#"/>'>
							<cfset sObjectsXML = sObjectsXML & '</oneToMany>'>
						</cfcase>
						<cfcase value="manyToMany">
							<cfset sManyToManyTargetColumn = ''>
							<cfset sManyToManySourceColumn = ''>
							<cfloop from="1" to="#ArrayLen(stDatasource[ListFirst(stDatasource[idxTables].fk[idxRelations].mapping,'.')].fk)#" index="idxManyToMany">
								<cfif ListFirst(stDatasource[ListFirst(stDatasource[idxTables].fk[idxRelations].mapping,'.')].fk[idxManyToMany].mapping,'.') NEQ idxTables>
									<cfset sManyToManyTargetColumn = ListLast(stDatasource[ListFirst(stDatasource[idxTables].fk[idxRelations].mapping,'.')].fk[idxManyToMany].field,'.')>
								<cfelse>
									<cfset sManyToManySourceColumn = ListLast(stDatasource[ListFirst(stDatasource[idxTables].fk[idxRelations].mapping,'.')].fk[idxManyToMany].field,'.')>
								</cfif>
							</cfloop>
							<cfif len(sManyToManyTargetColumn) AND len(sManyToManySourceColumn)>
								<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & chr(9)>
								<cfset sObjectsXML = sObjectsXML & '<manyToMany name="#ListFirst(stDatasource[idxTables].fk[idxRelations].mapping,'.')#">'>
								<cfset sObjectsXML = sObjectsXML & '<relate name="#stDatasource[idxTables].fk[idxRelations].field#" from="#sManyToManySourceColumn#" to="#sManyToManyTargetColumn#"/>'>
								<cfset sObjectsXML = sObjectsXML & '</manyToMany>'>
							</cfif>
						</cfcase>
					</cfswitch>
				</cfif>
			</cfloop>			
			<cfif NOT StructIsEmpty(stScaffoldingCustom)
				AND len(stScaffoldingCustom.sRelations)>
				<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & chr(9) & stScaffoldingCustom.sRelations>
			</cfif>
			<cfset sObjectsXML = sObjectsXML & chr(13) & chr(9) & chr(9) & '</object>'>
		</cfloop>

		<cfsavecontent variable="sConfig">
			<cfoutput>
<?xml version="1.0" encoding="UTF-8"?>
<!-- generated by LANshock at #now()# -->
<scaffolding>
	<config>
		<properties datasource="#stRuntimeConfig.lanshock.datasource#" licence="" project="LANshock" template="EXT2.0" version="1.0"/>
	</config>
	<objects>#sObjectsXML#
	</objects>
</scaffolding>
			</cfoutput>
		</cfsavecontent>
		
		<cffile action="write" file="#application.lanshock.oRuntime.getEnvironment().sStoragePath#secure/config/scaffolder/scaffolding.xml" output="#trim(sConfig)#" mode="777">
		
	</cffunction>
	
	<cffunction name="getScaffoldingData" output="false" returntype="struct">
		<cfargument name="sModule" type="string" required="true">
		<cfargument name="sTable" type="string" required="true">

		<cfset var stModuleConfig = StructNew()>
		<cfset var stScaffoldingCustom = StructNew()>
		<cfset var idxScaffoldingTables = ''>
		<cfset var idxScaffoldingType = ''>
		<cfset var stScaffoldingReturn = StructNew()>

		<cfinvoke component="#application.lanshock.oModules#" method="loadModuleInfoXml" returnvariable="stModuleConfig">
			<cfinvokeargument name="folder" value="#arguments.sModule#">
		</cfinvoke>
		
		<cfif stModuleConfig.status
			AND NOT StructIsEmpty(stModuleConfig.data.special)
			AND StructKeyExists(stModuleConfig.data.special,'scaffolding')>
				
			<cfset stScaffoldingCustom = stModuleConfig.data.special.scaffolding>
			
			<cfloop from="1" to="#ArrayLen(stScaffoldingCustom.XmlChildren)#" index="idxScaffoldingTables">
				<cfif stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlAttributes.name EQ arguments.sTable>
					<cfset stScaffoldingReturn.stList = StructNew()>
					<cfset stScaffoldingReturn.stList.lFields = ''>
					<cfset stScaffoldingReturn.stList.sSortDefault = ''>
					<cfset stScaffoldingReturn.stList.aData = ArrayNew(1)>
					<cfset stScaffoldingReturn.stForm = StructNew()>
					<cfset stScaffoldingReturn.stForm.lFields = ''>
					<cfset stScaffoldingReturn.stForm.aData = ArrayNew(1)>
					<cfset stScaffoldingReturn.sRelations = ''>
					<cfloop from="1" to="#ArrayLen(stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren)#" index="idxScaffoldingType">
						<cfif StructKeyExists(stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlAttributes,'fields')>
							<cfset stScaffoldingReturn['st' & stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].xmlName].lFields = stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlAttributes.fields>
						</cfif>
						<cfif StructKeyExists(stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlAttributes,'sortDefault')>
							<cfset stScaffoldingReturn['st' & stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].xmlName].sSortDefault = stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlAttributes.sortDefault>
						</cfif>
						<cfif ArrayLen(stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlChildren)>
							<cfset stScaffoldingReturn['st' & stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].xmlName].aData = stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlChildren>
						<cfelseif len(stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlText)>
							<cfset stScaffoldingReturn['s' & stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].xmlName] = trim(stScaffoldingCustom.XmlChildren[idxScaffoldingTables].XmlChildren[idxScaffoldingType].XmlText)>
						</cfif>
					</cfloop>
				</cfif>
			</cfloop>
		</cfif>
		
		<cfreturn stScaffoldingReturn>
		
	</cffunction>
	
	<cffunction name="getFormTypeByDbType" output="false" returntype="string">
		<cfargument name="sDbType" type="string" required="true">

		<cfset var sFormType = ''>
		
		<cfswitch expression="#arguments.sDbType#">
			<cfcase value="integer,double,varchar">
				<cfset sFormType = 'text'>
			</cfcase>
			<cfcase value="text">
				<cfset sFormType = 'textarea'>
			</cfcase>
			<cfcase value="datetime">
				<cfset sFormType = 'datetime'>
			</cfcase>
			<cfcase value="boolean">
				<cfset sFormType = 'checkbox'>
			</cfcase>
			<cfdefaultcase>
				<cfthrow message="scaffolder.sDbType.noFormType.#arguments.sDbType#">
			</cfdefaultcase>
		</cfswitch>
		
		<cfreturn sFormType>
		
	</cffunction>

</cfcomponent>