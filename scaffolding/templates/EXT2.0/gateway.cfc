<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<!--- Set the name of the object (table) being updated --->>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfoutput>>
<cfcomponent displayname="$$objectName$$Gateway.cfc" extends="reactor.project.$$oMetaData.getDatasource()$$.Gateway.$$objectName$$Gateway">

</cfcomponent>
<</cfoutput>>