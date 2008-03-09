<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/act_news.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
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
	<cfset stFilter.stFields.category_id = StructNew()>
	<cfset stFilter.stFields.category_id.mode = 'isEqual'>
	<cfset stFilter.stFields.category_id.value = attributes.category_id>
<cfelse>
	<cfset stFilter.iRecords = 10>
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway',false)#" method="getRecords" returnvariable="qNews">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">