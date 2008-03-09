<<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
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