<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/news/act_news_details.cfm $
$LastChangedDate: 2006-10-30 23:34:27 +0100 (Mo, 30 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 63 $
--->

<cfparam name="attributes.news_id" default="0">

<cfinvoke component="#application.modulecache.news.cfc.news#" method="getNewsEntry" returnvariable="qNewsEntry">
	<cfinvokeargument name="id" value="#attributes.news_id#">
</cfinvoke>

<cfif NOT qNewsEntry.recordcount>
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.UrlToken#" addtoken="false">
</cfif>
	
<cfinvoke component="#request.lanshock.environment.componentpath#modules.comments.comments" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="identifier" value="news#attributes.news_id#">
	<cfinvokeargument name="linktosource" value="news_details&news_id=#attributes.news_id#">
	<cfinvokeargument name="type" value="news">
	<cfinvokeargument name="topic_title" value="#qNewsEntry.title#">
</cfinvoke>

<cfinvoke component="#Application.ao__AppObj_mlanshock_news_trackback_Gateway#" method="getByFields" returnvariable="qTrackbacks">
	<cfinvokeargument name="sortByFieldList" value="date"/>
	<cfinvokeargument name="entry_id" value="#attributes.news_id#"/>
</cfinvoke>

<cfsetting enablecfoutputonly="No">