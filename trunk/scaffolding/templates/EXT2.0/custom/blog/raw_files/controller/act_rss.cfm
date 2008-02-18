<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/act_rss.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfset stMetadata = structNew()>
<cfset stMetadata.title = application.lanshock.settings.appname & ' RSS 1.0'>
<cfset stMetadata.link = application.lanshock.environment.webpathfull>
<cfset stMetadata.description = application.lanshock.settings.appname>
<!--- <cfset stMetadata.image = structNew()>
<cfset stMetadata.image.url = "http://www.foo.com/site.gif">
<cfset stMetadata.image.title = "Foo">
<cfset stMetadata.image.link = "http://www.foo.com"> --->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.blog.model.cfc.news')#" method="getNews" returnvariable="qNews">
	<cfinvokeargument name="records" value="25">
</cfinvoke>

<cfset qRssEntries = queryNew("title,body,link,subject,date")>

<cfloop query="qNews">
	<cfset queryAddRow(qRssEntries,1)>
	<cfset querySetCell(qRssEntries,"title",qNews.title)>
	<cfset querySetCell(qRssEntries,"body",qNews.text)>
	<cfset querySetCell(qRssEntries,"link",application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.news_details&news_id=#qNews.id#&title=#UrlEncodedFormat(qNews.title)#',true))>
	<cfset querySetCell(qRssEntries,"subject",qNews.title)>
	<cfset querySetCell(qRssEntries,"date",qNews.date)>
</cfloop>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core._utils.rss.rss')#" method="generateRSS" returnvariable="sRSS">
	<cfinvokeargument name="type" value="RSS1">
	<cfinvokeargument name="data" value="#qRssEntries#">
	<cfinvokeargument name="metadata" value="#stMetadata#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">