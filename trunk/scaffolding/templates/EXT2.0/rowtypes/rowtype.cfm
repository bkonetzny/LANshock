<cfparam name="attributes.rowtype" default="">
<cfparam name="attributes.method" default="">
<cfparam name="attributes.stFieldData" default="#StructNew()#">

<cfset attributes.rowtype = lCase(attributes.rowtype)>
<cfset attributes.method = lCase(attributes.method)>

<cfif NOT directoryExists(getDirectoryFromPath(GetCurrentTemplatePath()) & attributes.rowtype)>
	<cfset attributes.rowtype = "unknown">
</cfif>

<cfif fileExists(getDirectoryFromPath(GetCurrentTemplatePath()) & attributes.rowtype & '/' & attributes.method & '.cfm')>
	<cfinclude template="#attributes.rowtype#/#attributes.method#.cfm">
</cfif>