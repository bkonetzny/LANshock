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

</cfcomponent>