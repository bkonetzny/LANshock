<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcomponent hint="Language Manager">

	<cffunction name="getLanguageStrings" output="false" returntype="struct">
		<cfargument name="base" type="struct" required="true">
		<cfargument name="lang" type="string" required="true">
		<cfargument name="path" type="string" required="true">
		
		<cfset var key1 = ListGetAt(arguments.path,ListLen(arguments.path,'/')-1,'/')>
		<cfset var key2 = ListLast(arguments.path,'/')>
		<cfset var languageKey = ''>
		<cfset var content_new = ''>
		<cfset var sLastLoadedLanguaged = ''>

		<cfparam name="Application.lanshock.Cache.Language" default="#StructNew()#">
		
		<cfif StructKeyExists(Application.lanshock.Cache.Language,key1) AND 
				StructKeyExists(Application.lanshock.Cache.Language[key1],key2) AND 
				StructKeyExists(Application.lanshock.Cache.Language[key1][key2],'languages')>
		
			<!--- Load Modules Default Language --->
			<cfif len(Application.lanshock.Cache.Language[key1][key2].default)>
				<cfset languageKey = ListGetAt(Application.lanshock.Cache.Language[key1][key2].default,2,'.')>
				<cfset sLastLoadedLanguaged = languageKey>
				<cfset content_new = Application.LANshock.Cache.Language[key1][key2].languages[languageKey]>
				<cfset StructAppend(arguments.base,content_new,true)>
			</cfif>
			
			<!--- Load System Config Default Language --->
			<cfif StructKeyExists(Application.lanshock.Cache.Language[key1][key2].languages,application.lanshock.settings.language)>
				<cfset languageKey = application.lanshock.settings.language>
				
				<cfif sLastLoadedLanguaged NEQ languageKey>
					<cfset sLastLoadedLanguaged = languageKey>
					<cfset content_new = Application.LANshock.Cache.Language[key1][key2].languages[languageKey]>
					<cfset StructAppend(arguments.base,content_new,true)>
				</cfif>
			</cfif>
			
			<!--- Load Users Current Language --->
			<cfif StructKeyExists(Application.lanshock.Cache.Language[key1][key2].languages,arguments.lang)>
				<cfset languageKey = arguments.lang>

				<cfif sLastLoadedLanguaged NEQ languageKey>
					<cfset sLastLoadedLanguaged = languageKey>
					<cfset content_new = Application.LANshock.Cache.Language[key1][key2].languages[languageKey]>
					<cfset StructAppend(arguments.base,content_new,true)>
				</cfif>
			</cfif>
			
		<cfelse>
		
			<!--- reload language files? -> page loop? --->
		
		</cfif>
		
		<cfreturn arguments.base>
	</cffunction>

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
		
			<cfdirectory action="list" name="qLangFiles" directory="#application.lanshock.environment.abspath##sFileDirectory#" filter="*.properties">
			
			<cfloop query="qLangFiles">
		
				<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core._utils.i18n.javaRB')#" method="getResourceBundle" returnvariable="stRb">
					<cfinvokeargument name="rbFile" value="#application.lanshock.environment.abspath##sFileDirectory##qLangFiles.name#">
				</cfinvoke>
				
				<cfset application.lanshock.oCache.set("language:#sFileDirectory##qLangFiles.name#",stRb)>
			
			</cfloop>
			
			<cfset application.lanshock.oCache.set("language:#sFileDirectory#",now())>
			
		</cfif>
		
		<cfif application.lanshock.oCache.exists("language:#sFileDirectory##sFileLangUser#")>
			<cfset StructAppend(stReturn,application.lanshock.oCache.get("language:#sFileDirectory##sFileLangUser#"),true)>
		<cfelseif application.lanshock.oCache.exists("language:#sFileDirectory##sFileLangDefault#")>
			<cfset StructAppend(stReturn,application.lanshock.oCache.get("language:#sFileDirectory##sFileLangDefault#"),true)>
		</cfif>
		
		<cfreturn stReturn>
	</cffunction>

</cfcomponent>