<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.news_id" default="0">

<cfinvoke component="news" method="getNewsEntry" returnvariable="qNewsEntry">
	<cfinvokeargument name="id" value="#attributes.news_id#">
</cfinvoke>

<cfif NOT qNewsEntry.recordcount>
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.UrlToken#" addtoken="false">
</cfif>
	
<cfinvoke component="#request.lanshock.environment.componentpath#core.comments.comments" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="identifier" value="news#attributes.news_id#">
	<cfinvokeargument name="linktosource" value="news_details&news_id=#attributes.news_id#">
	<cfinvokeargument name="type" value="news">
	<cfinvokeargument name="topic_title" value="#qNewsEntry.title#">
</cfinvoke>

<cfset qTrackbacks = objectBreeze.getByWhere("news_trackback",'entry_id = #attributes.news_id#','date DESC').getQuery()>

<cfsetting enablecfoutputonly="No">