<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cffunction name="ListSortByLen" returntype="string" output="false">
	<cfargument name="ListToSort" type="string" required="false" default="">

	<cfscript>
	var SortOrder = "asc";
	var Delimiters = ",";
	var ListIsSorted = "no";
	var ListLen = ListLen(ListToSort, Delimiters);
	var CurListItem = "";
	var NextListItem = "";

	if (ArrayLen(Arguments) gt 1) SortOrder = Arguments[2];
	
	if (ArrayLen(Arguments) gt 2) Delimiters = Arguments[3];
		
	while (Not ListIsSorted) {
		ListIsSorted = "yes";
		for (N = 1; N+1 lte ListLen; N=N+1) {
			CurListItem = ListGetAt(ListToSort, N, Delimiters);
			NextListItem = ListGetAt(ListToSort, N+1, Delimiters);
			
			if( (sortOrder is "asc" and len(curListItem) gt len(nextListItem)) or (sortOrder is "desc" and len(curListItem) lt len(nextListItem))) {
				listToSort = listSetAt(listToSort,n,nextListItem,delimiters);
				listToSort = listSetAt(listToSort,n+1,curListItem,delimiters);
				ListIsSorted = "no";
			}
		}
	}
	</cfscript>
	
	<cfreturn ListToSort>

</cffunction>

</cfsilent><cfsetting enablecfoutputonly="No">