<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)
$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/act_json_filter.cfm $
$LastChangedDate: 2008-07-05 14:13:10 +0200 (Sa, 05 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 379 $
--->
<cfparam name="attributes.sort" default="id">
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
