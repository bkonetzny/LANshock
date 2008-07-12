<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<<cfsilent>>
<<cfset objectName = oMetaData.getSelectedTableAlias()>>
<<cfset lPKFields = oMetaData.getPKListFromXML(objectName)>>
<</cfsilent>>
<<cfoutput>>
<cfparam name="attributes.sort" default="$$lPKFields$$">
<cfparam name="attributes.dir" default="ASC">
<cfparam name="attributes.start" default="1">
<cfparam name="attributes.limit" default="20">
<cfparam name="attributes.fields" default="">
<cfparam name="attributes.query" default="">
<cfset stFilters = StructNew()>
<cfset lFilterFields = reReplaceNoCase(attributes.fields,'[\[""\]]*','','ALL')>
<cfloop list="#lFilterFields#" index="idxFilters">
	<cfset stFilters[idxFilters] = attributes.query>
</cfloop>
<</cfoutput>>