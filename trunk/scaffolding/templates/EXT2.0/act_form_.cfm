<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/index.cfm $
$LastChangedDate: 2007-12-09 10:05:43 +0100 (So, 09 Dez 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 127 $
--->>

<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>

<<cfoutput>>
	<cfset o$$objectName$$ = application.lanshock.oFactory.load("$$objectName$$","reactorRecord")>
	<cfif variables.mode EQ 'edit'>
		<<cfloop list="$$lPKFields$$" index="thisPKField">>
		<cfset o$$objectName$$.set$$thisPKField$$(attributes.$$thisPKField$$)><</cfloop>>
		<cfset o$$objectName$$.load()>
	</cfif>
<</cfoutput>>