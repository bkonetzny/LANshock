<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent hint="Language Manager">

	<cffunction name="loadProperties" output="false" returntype="struct">
		<cfargument name="base" type="struct" required="false" default="#StructNew()#">
		<cfargument name="lang" type="string" required="true">
		<cfargument name="file" type="string" required="true">
		
		<cfset var stReturn = arguments.base>
		<cfset var sFileDirectory = getDirectoryFromPath(arguments.file)>
		<cfset var sFileLangDefault = LCase(getFileFromPath(arguments.file))>
		<cfset var sFileLangUser = LCase(replace(sFileLangDefault,'.properties','_#arguments.lang#.properties'))>
		<cfset var qLangFiles = 0>
		<cfset var stRb = StructNew()>
		
		<cfif NOT application.lanshock.oCache.exists("language:#sFileDirectory#")>
		
			<cfdirectory action="list" name="qLangFiles" directory="#application.lanshock.oRuntime.getEnvironment().sBasePath##sFileDirectory#" filter="*.properties">
			
			<cfloop query="qLangFiles">
		
				<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core._utils.i18n.javaRB')#" method="getResourceBundle" returnvariable="stRb">
					<cfinvokeargument name="rbFile" value="#application.lanshock.oRuntime.getEnvironment().sBasePath##sFileDirectory##qLangFiles.name#">
				</cfinvoke>
				
				<cfset application.lanshock.oCache.set("language:#sFileDirectory##qLangFiles.name#",stRb)>
			
			</cfloop>
			
			<cfset application.lanshock.oCache.set("language:#sFileDirectory#",now())>
			
		</cfif>

		<cfif application.lanshock.oCache.exists("language:#sFileDirectory##sFileLangDefault#")>
			<cfset StructAppend(stReturn,application.lanshock.oCache.get("language:#sFileDirectory##sFileLangDefault#"),true)>
		</cfif>
		<cfif application.lanshock.oCache.exists("language:#sFileDirectory##sFileLangUser#")>
			<cfset StructAppend(stReturn,application.lanshock.oCache.get("language:#sFileDirectory##sFileLangUser#"),true)>
		</cfif>
		
		<cfreturn stReturn>
	</cffunction>

</cfcomponent>