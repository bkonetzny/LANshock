<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.news_id" default="">

<cfif NOT isNumeric(attributes.news_id)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>

<cfset stFilter = StructNew()>
<cfset stFilter.stJoins = StructNew()>
<cfset stFilter.stJoins.user = "name,firstname,lastname">
<cfset stFilter.stFields.id = StructNew()>
<cfset stFilter.stFields.id.mode = 'isEqual'>
<cfset stFilter.stFields.id.value = attributes.news_id>

<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway',false)#" method="getRecords" returnvariable="qNewsEntry">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfif NOT qNewsEntry.recordcount>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>
	
<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="identifier" value="news#attributes.news_id#">
	<cfinvokeargument name="linktosource" value="news_details&news_id=#attributes.news_id#">
	<cfinvokeargument name="type" value="news">
	<cfinvokeargument name="topic_title" value="#qNewsEntry.title#">
</cfinvoke>

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "date|DESC">
<cfset stFilter.stFields.entry_id = StructNew()>
<cfset stFilter.stFields.entry_id.mode = 'isEqual'>
<cfset stFilter.stFields.entry_id.value = attributes.news_id>

<cfinvoke component="#application.lanshock.oFactory.load('news_trackback','reactorGateway')#" method="getRecords" returnvariable="qTrackbacks">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "news_category|name|ASC">
<cfset stFilter.stJoins = StructNew()>
<cfset stFilter.stJoins.news_category = "name">
<cfset stFilter.stFields.entry_id = StructNew()>
<cfset stFilter.stFields.entry_id.mode = 'isEqual'>
<cfset stFilter.stFields.entry_id.value = attributes.news_id>

<cfinvoke component="#application.lanshock.oFactory.load('news_entry_category','reactorGateway')#" method="getRecords" returnvariable="qCategories">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfsetting enablecfoutputonly="false">