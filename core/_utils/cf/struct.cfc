<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/session.cfc $
$LastChangedDate: 2006-10-22 23:59:51 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 34 $
--->

<cfcomponent>
	
	<cffunction name="structMerge" output="false" returntype="struct">
		<cfargument name="struct1" type="struct" required="true">
		<cfargument name="struct2" type="struct" required="true">
		<cfargument name="overwriteflag" type="boolean" required="false" default="true" hint="Overwrites Key of Struct1 with Key of Struct2">
	
		<cfset var stMerged = arguments.struct1>
		<cfset var idx = 0>
		
		<cfloop collection="#arguments.struct2#" item="idx">
			<cfif isStruct(arguments.struct2[idx]) AND StructKeyExists(stMerged, idx) AND isStruct(stMerged[idx])>
				<cfset stMerged[idx] = StructMerge(stMerged[idx],arguments.struct2[idx],arguments.overwriteflag)>
			<cfelse>
				<cfif arguments.overwriteflag>
					<cfset stMerged[idx] = arguments.struct2[idx]>
				<cfelse>
					<cfparam name="stMerged[idx]" default="#arguments.struct2[idx]#">
				</cfif>
			</cfif>
		</cfloop>
	
		<cfreturn stMerged>
	</cffunction>

</cfcomponent>