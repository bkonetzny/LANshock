<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cffunction name="getMappingFromPath" output="false" returntype="struct">
	<cfargument name="component" type="string" required="true">
	
	<cfscript>
		var stLocal = StructNew();
		var stReturn = StructNew();
		stReturn.sMapping = '';
		stReturn.success = false;
	</cfscript>

	<cftry>
		<cfscript>
			stLocal.cfcGetCFCs = CreateObject("component","cfide.componentutils.cfcexplorer");
			stLocal.aComponents = stLocal.cfcGetCFCs.getcfcs(1); // 1 = Refresh ColdFusions CFC-Cache
			stLocal.iArrayLen = ArrayLen(stLocal.aComponents);
			stLocal.sComponent = RePlaceNoCase(arguments.component, "\", "/", "ALL");
			stLocal.idx = '';
		</cfscript>
		<cfloop from="1" to="#stLocal.iArrayLen#" index="stLocal.idx">
			<cfscript>
				if(stLocal.aComponents[stLocal.idx].path EQ stLocal.sComponent){
					stReturn.sMapping = stLocal.aComponents[stLocal.idx].package & ".";
					stReturn.success = true;
					if(stReturn.sMapping EQ ".") stReturn.sMapping = '';
				}
			</cfscript>
		</cfloop>
		<cfcatch><!--- do nothing ---></cfcatch>
	</cftry>

	<cfreturn stReturn>
	
</cffunction>

</cfsilent><cfsetting enablecfoutputonly="No">