<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfloop collection="#attributes#" item="idx">
	<cfif isSimpleValue(attributes[idx])>
		<cfset attributes[idx] = trim(attributes[idx])>
	</cfif>
</cfloop>

<cfsetting enablecfoutputonly="false">