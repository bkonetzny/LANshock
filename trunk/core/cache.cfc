<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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
		
		<cfset StructDelete(variables.stCache,arguments.sKey)>
	</cffunction>

	<cffunction name="dropAll" output="false" returntype="void">
		<cfset StructClear(variables.stCache)>
	</cffunction>

	<cffunction name="size" output="false" returntype="numeric">
		<cfset var iCacheSize = 0>
		<cfset var idx = ''>

		<cfloop list="#getKeys()#" index="idx">
			<cfset iCacheSize = iCacheSize + len(serialize(get(idx)))>
		</cfloop>

		<cfset iCacheSize = iCacheSize * 8>
		
		<cfreturn iCacheSize>
	</cffunction>

</cfcomponent>