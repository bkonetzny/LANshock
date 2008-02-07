<cfsetting enablecfoutputonly="true">

<cfset stFieldsMove = StructNew()>

<cfloop from="1" to="#ArrayLen(aFormTabs)#" index="idxTabs">
	<cfloop from="1" to="#ArrayLen(aFormTabs[idxTabs].aFieldGroups)#" index="idxFieldGroups">
		<cfloop from="#ArrayLen(aFormTabs[idxTabs].aFieldGroups[idxFieldGroups].aFields)#" to="1" step="-1" index="idxFields">
			<cfset stFieldData = aFormTabs[idxTabs].aFieldGroups[idxFieldGroups].aFields[idxFields]>
			<cfif ListFind(lFieldsMove,stFieldData.name)>
				<cfset stFieldsMove[stFieldData.name] = stFieldData>
				<cfset ArrayDeleteAt(aFormTabs[idxTabs].aFieldGroups[idxFieldGroups].aFields,idxFields)>
			</cfif>
		</cfloop>
	</cfloop>
</cfloop>

<cfsetting enablecfoutputonly="false">