<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->>

<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfoutput>>
<cfcomponent displayname="$$objectName$$Gateway.cfc" extends="reactor.project.$$oMetaData.getDatasource()$$.Gateway.$$objectName$$Gateway">

</cfcomponent>
<</cfoutput>>