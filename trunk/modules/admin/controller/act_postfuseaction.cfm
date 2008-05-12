<cfif isDefined('request.layout')>
	<cfif ListFindNoCase('json,none',request.layout)>
		<cfset _fba.debug = false>
		<cfif request.layout EQ 'json'>
			<cfinclude template="../view/dsp_layout_json">
		</cfif>
	<cfelseif request.layout EQ 'admin'>
		<cfinclude template="../view/dsp_layout">
	</cfif>
</cfif>