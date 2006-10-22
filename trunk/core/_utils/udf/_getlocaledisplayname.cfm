<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cffunction name="GetLocaleDisplayName" output="false" returntype="string">
	<cfargument name="locale" type="string" required="true">
	
	<cfset var stLocal = StructNew()>

	<cfinvoke component="#request.lanshock.environment.componentpath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocal.stLocales">
	
	<cfparam name="stLocal.stLocales[arguments.locale]" default="">
	
	<cfreturn stLocal.stLocales[arguments.locale]>
</cffunction>

</cfsilent><cfsetting enablecfoutputonly="No">