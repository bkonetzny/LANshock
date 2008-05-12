<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/dsp_layout.cfm $
$LastChangedDate: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 205 $
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