<cfsetting enablecfoutputonly="true">

<cfset aFormTabs = ArrayNew(1)>

<cfset stTabData = StructNew()>
<cfset stTabData.name = 'edit'>
<cfset stTabData.aFieldGroups = ArrayNew(1)>

<cfloop list="aTable,aManyToOne,aManyToMany,aOneToMany" index="idxRelation">

	<cfif NOT ArrayIsEmpty(stFields[idxRelation])>

		<cfset stFieldGroupData = StructNew()>
		<cfset stFieldGroupData.name = idxRelation>
		<cfset stFieldGroupData.aFields = ArrayNew(1)>
		
		<cfif idxRelation EQ "aTable">
			<cfloop from="1" to="#ArrayLen(stFields[idxRelation])#" index="i">
				<cfset stFieldData = stFields[idxRelation][i]>
				<cfset stFieldData.uuid = replace(CreateUUID(),'-','','ALL')>
				
				<cfset ArrayAppend(stFieldGroupData.aFields,stFieldData)>
			</cfloop>
		<cfelseif ListFind("aManyToOne,aManyToMany,aOneToMany",idxRelation)>
			<cfloop from="1" to="#ArrayLen(stFields[idxRelation])#" index="i">
				<cfset stFieldData = stFields[idxRelation][i]>
				<cfset stFieldData.uuid = replace(CreateUUID(),'-','','ALL')>
				<cfset stFieldData.formType = "select_manytomany">
				
				<cfset ArrayAppend(stFieldGroupData.aFields,stFieldData)>
			</cfloop>
		</cfif>
				
		<cfset ArrayAppend(stTabData.aFieldGroups,stFieldGroupData)>
	</cfif>
</cfloop>
				
<cfset ArrayAppend(aFormTabs,stTabData)>

<cfsetting enablecfoutputonly="false">