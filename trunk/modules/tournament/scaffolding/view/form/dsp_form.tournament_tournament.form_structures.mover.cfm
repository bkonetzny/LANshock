<cfset stFieldGroupData = StructNew()>
<cfset stFieldGroupData.name = 'team'>
<cfset stFieldGroupData.aFields = ArrayNew(1)>

<cfloop list="maxteams,teamsize,teamsubstitute" index="idxField">
	<cfset ArrayAppend(stFieldGroupData.aFields,stFieldsMove[idxField])>
</cfloop>

<cfset ArrayAppend(stTabData.aFieldGroups,stFieldGroupData)>

<cfset stFieldGroupData = StructNew()>
<cfset stFieldGroupData.name = 'match'>
<cfset stFieldGroupData.aFields = ArrayNew(1)>

<cfloop list="pausetime,matchtime,matchcount" index="idxField">
	<cfset ArrayAppend(stFieldGroupData.aFields,stFieldsMove[idxField])>
</cfloop>

<cfset ArrayAppend(stTabData.aFieldGroups,stFieldGroupData)>

<cfset stFieldGroupData = StructNew()>
<cfset stFieldGroupData.name = 'export'>
<cfset stFieldGroupData.aFields = ArrayNew(1)>

<cfloop list="export_league,export_league_data" index="idxField">
	<cfset ArrayAppend(stFieldGroupData.aFields,stFieldsMove[idxField])>
</cfloop>

<cfset ArrayAppend(stTabData.aFieldGroups,stFieldGroupData)>