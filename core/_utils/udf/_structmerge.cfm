<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cffunction name="StructMerge" output="false" returntype="struct">
	<cfargument name="struct1" type="struct" required="true">
	<cfargument name="struct2" type="struct" required="true">
	<cfargument name="overwriteflag" type="boolean" required="false" default="true" hint="Overwrites Key of Struct1 with Key of Struct2">

	<cfscript>
		var stMerged = arguments.struct1;
	</cfscript>
	
	<cfloop collection="#arguments.struct2#" item="idx">
		<cfif isStruct(arguments.struct2[idx]) AND 
				StructKeyExists(stMerged, idx) AND 
				isStruct(stMerged[idx])>
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

</cfsilent><cfsetting enablecfoutputonly="No">