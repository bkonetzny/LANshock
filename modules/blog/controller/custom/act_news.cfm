<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.category_id" default="">
<cfparam name="attributes.user_id" default="">

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "date|DESC">
<cfset stFilter.stJoins = StructNew()>
<cfset stFilter.stJoins.user = "name,firstname,lastname">
<cfif len(attributes.user_id)>
	<cfset stFilter.stFields.author = StructNew()>
	<cfset stFilter.stFields.author.mode = 'isEqual'>
	<cfset stFilter.stFields.author.value = attributes.user_id>
</cfif>
<cfif len(attributes.category_id)>
	<cfset stFilter.stJoins.news_entry_category = "category_id">
	<cfset stFilter.stFields['news_entry_category|category_id'] = StructNew()>
	<cfset stFilter.stFields['news_entry_category|category_id'].mode = 'isEqual'>
	<cfset stFilter.stFields['news_entry_category|category_id'].value = attributes.category_id>
<cfelse>
	<cfset stFilter.iRecords = 10>
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway')#" method="getRecords" returnvariable="qNews">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfset aQueryCommentCount = ArrayNew(1)>
<cfset aQueryTrackbacks = ArrayNew(1)>
<cfset aQueryCategories = ArrayNew(1)>

<cfloop query="qNews">
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getCommentsCount" returnvariable="iCommentCount">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="identifier" value="news#qNews.id#">
	</cfinvoke>
	
	<cfset ArrayAppend(aQueryCommentCount, iCommentCount)>
	
	<cfset stFilter = StructNew()>
	<cfset stFilter.lSortFields = "date|DESC">
	<cfset stFilter.stFields.entry_id = StructNew()>
	<cfset stFilter.stFields.entry_id.mode = 'isEqual'>
	<cfset stFilter.stFields.entry_id.value = qNews.id>

	<cfinvoke component="#application.lanshock.oFactory.load('news_trackback','reactorGateway')#" method="getRecords" returnvariable="qTrackbacks">
		<cfinvokeargument name="stFilter" value="#stFilter#">
	</cfinvoke>
	
	<cfset ArrayAppend(aQueryTrackbacks, qTrackbacks)>
	
	<cfset stFilter = StructNew()>
	<cfset stFilter.lSortFields = "news_category|name|ASC">
	<cfset stFilter.stJoins = StructNew()>
	<cfset stFilter.stJoins.news_category = "name">
	<cfset stFilter.stFields.entry_id = StructNew()>
	<cfset stFilter.stFields.entry_id.mode = 'isEqual'>
	<cfset stFilter.stFields.entry_id.value = qNews.id>

	<cfinvoke component="#application.lanshock.oFactory.load('news_entry_category','reactorGateway')#" method="getRecords" returnvariable="qCategories">
		<cfinvokeargument name="stFilter" value="#stFilter#">
	</cfinvoke>
	
	<cfset ArrayAppend(aQueryCategories, qCategories)>
</cfloop>

<cfset QueryAddColumn(qNews, 'iCommentCount', aQueryCommentCount)>
<cfset QueryAddColumn(qNews, 'qTrackbacks', aQueryTrackbacks)>
<cfset QueryAddColumn(qNews, 'qCategories', aQueryCategories)>

<cfsetting enablecfoutputonly="false">