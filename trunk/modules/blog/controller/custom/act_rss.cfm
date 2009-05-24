<cfsetting enablecfoutputonly="true">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "date|DESC">
<cfset stFilter.iRecords = 25>

<cfinvoke component="#application.lanshock.oFactory.load('news_entry','reactorGateway')#" method="getRecords" returnvariable="qNews">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfset syndFeed = application.lanshock.oFactory.load('lanshock.core._utils.rss.rssville.feed').init()>
<cfset syndFeed.setTitle(application.lanshock.settings.appname & ' RSS 2.0')>
<cfset syndFeed.setDescription(application.lanshock.settings.appname)>
<cfset syndFeed.setAuthor(application.lanshock.settings.appname)>
<cfset syndFeed.setLink(application.lanshock.oRuntime.getEnvironment().sServerPath)>
<cfset syndFeed.setCopyright('Copyright ' & year(now()) & ' by ' & application.lanshock.settings.appname)>
<!--- <cfset syndFeed.setLanguage("en-us")>
<cfset syndFeed.addCategorySimple("News")>
<cfset syndFeed.setWebmaster("webmaster@yourcompany.com")> --->

<cfloop query="qNews">
	<cfset entry = application.lanshock.oFactory.load(sObject='lanshock.core._utils.rss.rssville.entry',bCache=false).init()>
	<cfset entry.setTitle(qNews.title)>
	<!--- <cfset entry.addCategorySimple("News")> --->
	<cfset entry.setDescriptionSimple(qNews.text)>
	<cfset entry.setLink(application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#&title=#UrlEncodedFormat(qNews.title)#',true))>
	<cfset entry.setPubDate(qNews.date)>
	<cfset syndFeed.addEntry(entry)>
</cfloop>

<cfset sRSS = syndFeed.generate(syndFeed.FEED_TYPE_RSS20)>

<cfsetting enablecfoutputonly="false">