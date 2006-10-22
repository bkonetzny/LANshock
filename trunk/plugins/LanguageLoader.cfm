<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stImageDir.module = application.module[myfusebox.thiscircuit].module_path_web & 'images'>

<cfif application.module[myfusebox.thiscircuit].general.loadLanguageFile>

	<cfinvoke component="#application.lanshock.environment.componentpath#core.language" method="getLanguageStrings" returnvariable="request.content">
		<cfinvokeargument name="base" value="#request.content#">
		<cfinvokeargument name="lang" value="#request.session.lang#">
		<cfinvokeargument name="path" value="#application.module[myfusebox.thiscircuit].module_path_rel#">
	</cfinvoke>

</cfif>

<cfsetting enablecfoutputonly="No">