<cfset stFieldGroupData = StructNew()>
<cfset stFieldGroupData.name = 'optional'>
<cfset stFieldGroupData.aFields = ArrayNew(1)>

<cfloop list="#lFieldsMove#" index="idxField">
	<cfset ArrayAppend(stFieldGroupData.aFields,stFieldsMove[idxField])>
</cfloop>

<cfset ArrayAppend(stTabData.aFieldGroups,stFieldGroupData)>