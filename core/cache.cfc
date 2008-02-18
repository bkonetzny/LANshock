<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/session.cfc $
$LastChangedDate: 2006-10-22 23:59:51 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 34 $
--->

<cfcomponent>
	
	<cffunction name="init" output="false" returntype="void">
		<cfset variables.stCache = StructNew()>
	</cffunction>
	
	<cffunction name="set" output="false" returntype="void">
		<cfargument name="sKey" type="string" required="false">
		<cfargument name="oData" type="any" required="false">
		
		<cfset variables.stCache[lCase(arguments.sKey)] = oData>
	</cffunction>
	
	<cffunction name="get" output="false" returntype="any">
		<cfargument name="sKey" type="string" required="false">
		
		<cfif StructKeyExists(variables.stCache,arguments.sKey)>
			<cfreturn variables.stCache[arguments.sKey]>
		</cfif>
	</cffunction>

	<cffunction name="getKeys" output="false" returntype="string">
		<cfreturn lCase(StructKeyList(variables.stCache))>
	</cffunction>
	
	<cffunction name="exists" output="false" returntype="boolean">
		<cfargument name="sKey" type="string" required="false">
		
		<cfreturn StructKeyExists(variables.stCache,arguments.sKey)>
	</cffunction>
	
	<cffunction name="drop" output="false" returntype="void">
		<cfargument name="sKey" type="string" required="true">
		
		<cfset StructKeyDelete(variables.stCache,arguments.sKey)>
	</cffunction>

	<cffunction name="dropAll" output="false" returntype="void">
		<cfset init()>
	</cffunction>

</cfcomponent>