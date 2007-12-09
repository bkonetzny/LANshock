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

<cfif NOT isNumeric(attributes.category_id)>
	<cfset attributes.category_id = ''>
</cfif>

<cfif NOT isNumeric(attributes.user_id)>
	<cfset attributes.user_id = ''>
</cfif>

<cfinvoke component="#application.modulecache.news.cfc.news#" method="getNews" returnvariable="qNews">
	<cfif NOT len(attributes.category_id)>
		<cfinvokeargument name="records" value="10">
	</cfif>
	<cfif len(attributes.user_id)>
		<cfinvokeargument name="user_id" value="#attributes.user_id#">
	</cfif>
	<cfif len(attributes.category_id)>
		<cfinvokeargument name="category_id" value="#attributes.category_id#">
	</cfif>
</cfinvoke>

<cfsetting enablecfoutputonly="No">