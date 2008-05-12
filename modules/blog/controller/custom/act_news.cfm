<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://lanshock.svn.sourceforge.net/svnroot/lanshock/trunk/scaffolding/templates/EXT2.0/custom/blog/raw_files/controller/act_news.cfm $
$LastChangedDate: 2008-03-09 12:47:41 +0100 (So, 09 Mrz 2008) $
$LastChangedBy: majestixs $
$LastChangedRevision: 205 $
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

<cfsetting enablecfoutputonly="No">