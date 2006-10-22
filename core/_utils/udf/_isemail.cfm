<cfsetting enablecfoutputonly="Yes"><cfsilent>
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cffunction name="isEmail" output="false" returntype="boolean">
	<cfargument name="email" type="string" required="true">
	<cfscript>
		if (REFindNoCase("^['_a-z0-9-]+(\.['_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$",arguments.email)) return true;
		else return false;
	</cfscript>
</cffunction>

</cfsilent><cfsetting enablecfoutputonly="No">