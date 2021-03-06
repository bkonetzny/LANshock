<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">

<cfparam name="attributes.gallery_id" default="0">
<cfparam name="attributes.id" default="0">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.gallery_id#">
</cfinvoke>

<cfif NOT qGallery.recordcount AND NOT ((session.userid EQ qGallery.user_id) OR (session.isAdmin AND UDF_SecurityCheck(area='edit',returntype='boolean')))>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>

<cfif attributes.id NEQ 0>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getItem" returnvariable="qItem">
		<cfinvokeargument name="id" value="#attributes.id#">
	</cfinvoke>

	<cfparam name="attributes.title" default="#qItem.title#">
	<cfparam name="attributes.text" default="#qItem.text#">
	<cfparam name="attributes.filename" default="#qItem.filename#">
</cfif>

<cfparam name="attributes.title" default="">
<cfparam name="attributes.text" default="">
<cfparam name="attributes.filename" default="">

<cfif attributes.form_submitted>
	
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="setItem" returnvariable="item_id">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="gallery_id" value="#attributes.gallery_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="text" value="#attributes.text#">
		<cfif len(attributes.file)>
			<cfinvokeargument name="bUploadFile" value="true">
		</cfif>
		<cfinvokeargument name="settings" value="#stModuleConfig#">
	</cfinvoke>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery&id=#attributes.gallery_id#')#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">