<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.gallery_id" default="0">
<cfparam name="attributes.id" default="0">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.gallery_id#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getItem" returnvariable="qItem">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getItemPartners" returnvariable="qItemPartners">
	<cfinvokeargument name="id" value="#attributes.id#">
	<cfinvokeargument name="gallery_id" value="#attributes.gallery_id#">
</cfinvoke>

<cfif NOT qGallery.recordcount OR NOT qItem.recordcount>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>
	
<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="identifier" value="gallery_item_#attributes.id#">
	<cfinvokeargument name="linktosource" value="item&id=#attributes.id#&gallery_id=#attributes.gallery_id#">
	<cfinvokeargument name="type" value="item">
	<cfinvokeargument name="topic_title" value="#qItem.title#">
</cfinvoke>

<cfquery name="qItemPartnersPrev" dbtype="query">
	SELECT *
	FROM qItemPartners
	WHERE id < <cfqueryparam cfsqltype="cf_sql_integer" value="#qItem.id#">
	ORDER BY id ASC
</cfquery>

<cfquery name="qHasPrev" dbtype="query">
	SELECT MAX(id) AS id
	FROM qItemPartnersPrev
</cfquery>

<cfif qHasPrev.recordcount>
	<cfset iPrevItemID = qHasPrev.id>
<cfelse>
	<cfset iPrevItemID = ''>
</cfif>

<cfquery name="qItemPartnersNext" dbtype="query">
	SELECT *
	FROM qItemPartners
	WHERE id > <cfqueryparam cfsqltype="cf_sql_integer" value="#qItem.id#">
	ORDER BY id ASC
</cfquery>

<cfquery name="qHasNext" dbtype="query">
	SELECT MIN(id) AS id
	FROM qItemPartnersNext
</cfquery>

<cfif qHasNext.recordcount>
	<cfset iNextItemID = qHasNext.id>
<cfelse>
	<cfset iNextItemID = ''>
</cfif>

<cfhtmlhead text='<link rel="alternate" type="application/rss+xml" title="#request.lanshock.settings.appname# - Gallery: #qGallery.title# - Media RSS" href="#application.lanshock.oHelper.buildUrl("gallery.media_rss&id=#attributes.gallery_id#")#" />'>

<cfsetting enablecfoutputonly="No">