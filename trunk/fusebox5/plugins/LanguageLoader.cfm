<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset sCurrentModule = right(myfusebox.thiscircuit,len(myfusebox.thiscircuit)-2)>

<cfif application.lanshock.oModules.isLoaded(sCurrentModule)>

	<cfset stImageDir.module = 'modules/#sCurrentModule#/images'>
	
	<cfif application.lanshock.oModules.getModuleConfig(sCurrentModule).general.loadLanguageFile>
	
		<cfinvoke component="#application.lanshock.oLanguage#" method="loadProperties" returnvariable="request.content">
			<cfinvokeargument name="base" value="#request.content#">
			<cfinvokeargument name="lang" value="#session.lang#">
			<cfinvokeargument name="file" value="modules/#sCurrentModule#/lang.properties">
		</cfinvoke>
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">