<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfcontent type="text/xml">
<cfset getPageContext().getOut().clearBuffer()><cfoutput>#sXmlResponse#</cfoutput>

<cfsetting enablecfoutputonly="No">