<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	// useful constants
	self = "";
	myself = "#self#?#application.fusebox.fuseactionVariable#=";
	
	// make important Variables accessible for Components
	request.varScope = StructNew();
	request.varScope.stImageDir = stImageDir;
	request.varScope.self = self;
	request.varScope.myself = myself;
	request.varScope.myfusebox = myfusebox;
</cfscript>

<!--- Load LANshock UDF-Lib --->
<cfinclude template="core/lanshock.udf.lib.cfm">

<cfset stNav = UDF_getNavigation()>
<cfset aNav = StructSort(stNav,'textnocase','ASC','name')>

</cfsilent><cfsetting enablecfoutputonly="No">