<!--- 
I am the scaffolder manager. I call the requested functions of the scaffolder.
 --->
 
<!--- Need the following line since in all except trivial cases it will take a while to generate the code. --->
<cfsetting requestTimeOut = "3600" >

<cfif isDefined("url.scaffolding_go") OR isDefined("form.scaffolding_go")>
	<!--- Set up all the required file and URL paths --->
	<cfinclude template="act_findfilepaths.cfm">
	
	<!--- Copy URL and Form scope to attributes --->
	<cfscript>
		if (NOT IsDefined("attributes"))
    		attributes=structNew();
		StructAppend(attributes, url, "no");
		StructAppend(attributes, form, "no");
	</cfscript>

	<!--- If we asked for the user interface, show it then stop. Next step will be called by the interface so we stop. --->
	<cfif ListFindNoCase(attributes.scaffolding_go,"display")>
		<cfinclude template="dsp_scaffolding.cfm">
		<cfabort>
	</cfif>
	
	<!--- Build the argumentsCollection to pass to the metadata object from the available attributes --->
	<cfset argumentCollection = structNew()>
	<cfset lArguments = "configFilePath,datasource,username,password,project,template,author,authorEmail,copyright,licence,version,lTables">
	
	<cfloop list="#lArguments#" index="thisArgument">
		<cfif isDefined("attributes.scaffolding_#thisArgument#") AND trim(Evaluate("attributes.scaffolding_#thisArgument#")) IS NOT "">
			<cfset argumentCollection[thisArgument] = Evaluate("attributes.scaffolding_#thisArgument#")>
		</cfif>
	</cfloop>
	<!--- Create the MetaData object.  --->
	<cfset oMetaData = CreateObject("component","scaffolder.scaffolder.metadata").init(argumentCollection=argumentCollection)>
	
	<!--- If we requested the database introspection. --->
	<cfif ListFindNoCase(attributes.scaffolding_go,"introspectDB")>
		<cfset oMetaData.introspectDB()>
	</cfif>
	
	<!--- If we requested the code to be generated set up the cftemplate object and call build. --->
	<cfif ListFindNoCase(attributes.scaffolding_go,"build")>
		<cfset cftemplate = CreateObject("component","scaffolder.scaffolder.cftemplate").init()>
		<cfset destinationFilePath = GetDirectoryFromPath(GetBaseTemplatePath())&"/generated/lanshock/">
		<cfset sModule = "admin">
		<cfif isDefined("attributes.scaffolding_lTables")>
			<cfset oMetaData.build(cftemplate=cftemplate,destinationFilePath=destinationFilePath,sModule=sModule,lTables=attributes.scaffolding_lTables)>
		<cfelse>
			<cfset oMetaData.build(cftemplate=cftemplate,destinationFilePath=destinationFilePath,sModule=sModule)>
		</cfif>
	</cfif>
 	
 	<!--- If we did not request run then stop here. --->
 	<cfif NOT ListFindNoCase(attributes.scaffolding_go,"run")>
		<cfabort>
	</cfif>
</cfif>
