<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfloop collection="#attributes#" item="idx">
	<cfset attributes[idx] = trim(attributes[idx])>
</cfloop>

<cfsetting enablecfoutputonly="No">