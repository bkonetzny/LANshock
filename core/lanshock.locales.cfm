<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif NOT isDefined("application.lanshock.cache.language")
	OR StructIsEmpty(application.lanshock.cache.language)
	OR NOT stModuleConfig.cache.languagefiles>

	<cfscript>
		stGlobalLocales = StructNew();
		stGlobalLocales.core = StructNew();
		stGlobalLocales.modules = StructNew();
		stGlobalLocales.templates = StructNew();
	</cfscript>

	<cfdirectory action="list" directory="#application.lanshock.environment.abspath#core/" name="qDirCore">
	<cfloop query="qDirCore">
		<cfif type EQ 'dir'>
			<cfset currentDir = name>
			<cfset stGlobalLocales.core[currentDir] = StructNew()>
			<cfset stGlobalLocales.core[currentDir].default = ''>
			<cfset stGlobalLocales.core[currentDir].languages = StructNew()>
			
			<cfif FileExists('#application.lanshock.environment.abspath#core/#currentDir#/lang.default')>
				<cffile action="read" file="#application.lanshock.environment.abspath#core/#currentDir#/lang.default" variable="lang_default">
				<cfset stGlobalLocales.core[currentDir].default = trim(lang_default)>
			</cfif>
			
			<cfdirectory action="list" directory="#application.lanshock.environment.abspath#core/#currentDir#" name="qDirLocales" filter="*.properties">
			<cfloop query="qDirLocales">
				<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
					<cfinvokeargument name="rbFile" value="#application.lanshock.environment.abspath#core/#currentDir#/#name#">
				</cfinvoke>
				<cfset stGlobalLocales.core[currentDir].languages[ListGetAt(name,2,'.')] = stRB>
			</cfloop>
		</cfif>
	</cfloop>

	<cfdirectory action="list" directory="#application.lanshock.environment.abspath#modules/" name="qDirModules">
	<cfloop query="qDirModules">
		<cfif type EQ 'dir'>
			<cfset currentDir = name>
			<cfset stGlobalLocales.modules[currentDir] = StructNew()>
			<cfset stGlobalLocales.modules[currentDir].default = ''>
			<cfset stGlobalLocales.modules[currentDir].languages = StructNew()>
			
			<cfif FileExists('#application.lanshock.environment.abspath#modules/#currentDir#/lang.default')>
				<cffile action="read" file="#application.lanshock.environment.abspath#modules/#currentDir#/lang.default" variable="lang_default">
				<cfset stGlobalLocales.modules[currentDir].default = trim(lang_default)>
			</cfif>
			
			<cfdirectory action="list" directory="#application.lanshock.environment.abspath#modules/#currentDir#" name="qDirLocales" filter="*.properties">
			<cfloop query="qDirLocales">
				<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
					<cfinvokeargument name="rbFile" value="#application.lanshock.environment.abspath#modules/#currentDir#/#name#">
				</cfinvoke>
				<cfset stGlobalLocales.modules[currentDir].languages[ListGetAt(name,2,'.')] = stRB>
			</cfloop>
		</cfif>
	</cfloop>

	<cfdirectory action="list" directory="#application.lanshock.environment.abspath#templates/" name="qDirTemplates">
	<cfloop query="qDirTemplates">
		<cfif type EQ 'dir'>
			<cfset currentDir = name>
			<cfset stGlobalLocales.templates[currentDir] = StructNew()>
			<cfset stGlobalLocales.templates[currentDir].default = ''>
			<cfset stGlobalLocales.templates[currentDir].languages = StructNew()>
			
			<cfif FileExists('#application.lanshock.environment.abspath#core/#currentDir#/lang.default')>
				<cffile action="read" file="#application.lanshock.environment.abspath#core/#currentDir#/lang.default" variable="lang_default">
				<cfset stGlobalLocales.templates[currentDir].default = trim(lang_default)>
			</cfif>
			
			<cfdirectory action="list" directory="#application.lanshock.environment.abspath#templates/#currentDir#" name="qDirLocales" filter="*.properties">
			<cfloop query="qDirLocales">
				<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.javaRB" method="getResourceBundle" returnvariable="stRB">
					<cfinvokeargument name="rbFile" value="#application.lanshock.environment.abspath#templates/#currentDir#/#name#">
				</cfinvoke>
				<cfset stGlobalLocales.templates[currentDir].languages[ListGetAt(name,2,'.')] = stRB>
			</cfloop>
		</cfif>
	</cfloop>
	
	<cfset application.lanshock.cache.language = stGlobalLocales>

</cfif>

</cfsilent><cfsetting enablecfoutputonly="No">