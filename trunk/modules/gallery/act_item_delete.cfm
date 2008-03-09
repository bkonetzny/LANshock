<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfparam name="attributes.gallery_id" default="0">
<cfparam name="attributes.id" default="0">
<cfparam name="attributes.delete_accepted" default="false">

<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.gallery_id#">
</cfinvoke>

<cfif NOT qGallery.recordcount AND NOT ((session.userid NEQ qGallery.user_id) OR (session.isAdmin AND UDF_SecurityCheck(area='delete',returntype='boolean')))>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>

<cfif attributes.form_submitted>

	<cfscript>
		// validation
		if(NOT attributes.delete_accepted) ArrayAppend(aError, request.content.item_delete_confirm);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="gallery" method="deleteItem">
			<cfinvokeargument name="id" value="#attributes.id#">
			<cfinvokeargument name="gallery_id" value="#attributes.gallery_id#">
			<cfinvokeargument name="settings" value="#stModuleConfig#">
		</cfinvoke>
			
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery&id=#attributes.gallery_id#')#" addtoken="false">

	</cfif>
	
</cfif>

<cfsetting enablecfoutputonly="No">