<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getItemlist" returnvariable="qItemlist">
	<cfinvokeargument name="gallery_id" value="#attributes.id#">
</cfinvoke>
	
<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getCommentCountStruct" returnvariable="qCommentCount">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
</cfinvoke>

<cfhtmlhead text='<link rel="alternate" type="application/rss+xml" title="#request.lanshock.settings.appname# - Gallery: #qGallery.title# - Media RSS" href="#application.lanshock.oHelper.buildUrl("gallery.media_rss&id=#attributes.id#")#" />'>

<cfsetting enablecfoutputonly="No">