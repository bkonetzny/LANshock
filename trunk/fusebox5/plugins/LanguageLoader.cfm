<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset sCurrentModule = myfusebox.thiscircuit>
<cfif ListFirst(myfusebox.thiscircuit,'_') EQ 'c'>
	<cfset sCurrentModule = right(myfusebox.thiscircuit,len(myfusebox.thiscircuit)-2)>
</cfif>

<cfif application.lanshock.oModules.isLoaded(sCurrentModule)>

	<cfset stImageDir.module = application.lanshock.oRuntime.getEnvironment().sWebPath & 'modules/#sCurrentModule#/images'>
	
	<cfif application.lanshock.oModules.getModuleConfig(sCurrentModule).general.loadLanguageFile>
	
		<cfinvoke component="#application.lanshock.oLanguage#" method="loadProperties" returnvariable="request.content">
			<cfinvokeargument name="base" value="#request.content#">
			<cfinvokeargument name="lang" value="#session.lang#">
			<cfinvokeargument name="file" value="modules/#sCurrentModule#/lang.properties">
		</cfinvoke>
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="false">