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

<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.gallery_id#">
</cfinvoke>

<cfinvoke component="gallery" method="getItemlist" returnvariable="qItemlist">
	<cfinvokeargument name="gallery_id" value="#attributes.gallery_id#">
</cfinvoke>

<cfinvoke component="gallery" method="getItem" returnvariable="qItem">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif NOT qGallery.recordcount OR NOT qItem.recordcount>
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.URLToken#" addtoken="false">
</cfif>
	
<cfinvoke component="#request.lanshock.environment.componentpath#core.comments.comments" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="identifier" value="gallery_item_#attributes.id#">
	<cfinvokeargument name="linktosource" value="item&id=#attributes.id#&gallery_id=#attributes.gallery_id#">
	<cfinvokeargument name="type" value="item">
	<cfinvokeargument name="topic_title" value="#qItem.title#">
</cfinvoke>

<cfscript>
	iCurrentItemPos = ListFind(ValueList(qItemlist.id),qItem.id);
	iPrevItemPos = iCurrentItemPos-1;
	iNextItemPos = iCurrentItemPos+1;
	if(iPrevItemPos GT 0) iPrevItemID = ListGetAt(ValueList(qItemlist.id),iPrevItemPos);
	else iPrevItemID = '';
	if(iNextItemPos LTE ListLen(ValueList(qItemlist.id))) iNextItemID = ListGetAt(ValueList(qItemlist.id),iNextItemPos);
	else iNextItemID = '';
</cfscript>

<cfsetting enablecfoutputonly="No">