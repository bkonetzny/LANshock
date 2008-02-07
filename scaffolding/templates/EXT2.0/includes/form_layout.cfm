<cfsetting enablecfoutputonly="true">

<cfloop from="1" to="#ArrayLen(aFormTabs)#" index="idxTabs">

	<cfoutput>	
		<div style="width: 200px; border: 1px solid blue;">#aFormTabs[idxTabs].name#</div>
	</cfoutput>

	<cfloop from="1" to="#ArrayLen(aFormTabs[idxTabs].aFieldGroups)#" index="idxFieldGroups">
	
		<cfoutput>
			<fieldset class="inlineLabels">
				<legend>#aFormTabs[idxTabs].aFieldGroups[idxFieldGroups].name#</legend>
		</cfoutput>

			<cfloop from="1" to="#ArrayLen(aFormTabs[idxTabs].aFieldGroups[idxFieldGroups].aFields)#" index="idxFields">
				
				<cfset stFieldData = aFormTabs[idxTabs].aFieldGroups[idxFieldGroups].aFields[idxFields]>
				
				<cfif NOT StructKeyExists(stFieldData,'showOnForm')
						OR stFieldData.showOnForm>
					<cfmodule template="../rowtypes/rowtype.cfm" rowtype="#stFieldData.formType#" method="display" stFieldData="#stFieldData#">
				<cfelse>
					<cfmodule template="../rowtypes/rowtype.cfm" rowtype="hidden" method="display" stFieldData="#stFieldData#">
				</cfif>
			
			</cfloop>

		<cfoutput>
			</fieldset>
		</cfoutput>
	
	</cfloop>

</cfloop>

<cfsetting enablecfoutputonly="false">