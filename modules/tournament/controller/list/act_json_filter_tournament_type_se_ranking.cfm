<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)
$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/act_json_filter_.cfm $
$LastChangedDate: 2008-07-12 15:03:05 +0200 (Sa, 12 Jul 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 390 $
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
