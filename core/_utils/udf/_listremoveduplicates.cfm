<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
/**
 * Remove duplicates from a list.
 * 
 * @param lst 	 List to parse. (Required)
 * @param delim 	 List delimiter. Defaults to a comma. (Optional)
 * @return Returns a string. 
 * @author Keith Gaughan (keith@digital-crew.com) 
 * @version 1, August 22, 2005 
 */
function listRemoveDuplicates(lst) {
    var i       = 0;
    var delim   = ",";
    var asArray = "";
    var set     = StructNew();

    if (ArrayLen(arguments) gt 1) delim = arguments[2];

    asArray = ListToArray(lst, delim);
    for (i = 1; i LTE ArrayLen(asArray); i = i + 1) set[asArray[i]] = "";

    return structKeyList(set, delim);
}
</cfscript>

</cfsilent><cfsetting enablecfoutputonly="No">