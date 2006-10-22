<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cffunction name="isBIF" output="false" returntype="string">
	<cfargument name="name" type="string" required="false" default="">

	<cfreturn ListFindNoCase(StructKeyList(GetFunctionList()),replacenocase(arguments.name,'()','','ALL')) GT 0>
</cffunction>

<!--- <cfscript>
/**
 * Returns true if the function is a BIF (built in function).
 * 
 * @param name 	 The name to check. 
 * @return Returns a boolean. 
 * @author Raymond Camden (ray@camdenfamily.com) 
 * @version 1, September 26, 2001 
 */
function IsBIF(name) {
    return ListFindNoCase(StructKeyList(GetFunctionList()),name) GT 0;
}
</cfscript> --->

</cfsilent><cfsetting enablecfoutputonly="No">