<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif NOT stModuleConfig.user_create AND NOT request.session.isAdmin>
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.URLToken#" addtoken="false">
</cfif>

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfparam name="attributes.id" default="0">

<cfif attributes.id NEQ 0>
	<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
		<cfinvokeargument name="id" value="#attributes.id#">
	</cfinvoke>
	
	<cfif NOT qGallery.recordcount AND NOT ((request.session.userid NEQ qGallery.user_id) OR (request.session.isAdmin AND UDF_SecurityCheck(area='delete',returntype='boolean')))>
		<cflocation url="#myself##myfusebox.thiscircuit#.gallery&id=#attributes.id#&#request.session.URLToken#" addtoken="false">
	</cfif>

	<cfparam name="attributes.title" default="#qGallery.title#">
	<cfparam name="attributes.date" default="#qGallery.dt_created#">
	<cfparam name="attributes.text" default="#qGallery.text#">
	<cfparam name="attributes.visible" default="#qGallery.visible#">
	<cfparam name="attributes.tn" default="#qGallery.tn#">
</cfif>

<cfparam name="attributes.title" default="">
<cfparam name="attributes.date" default="#now()#">
<cfparam name="attributes.text" default="">
<cfparam name="attributes.visible" default="1">
<cfparam name="attributes.tn" default="">

<cfif attributes.form_submitted>

	<cfscript>
		attributes.date = LSParseDateTime(attributes.date & ' ' & attributes.time);

		if(NOT len(attributes.title)) ArrayAppend(aError, request.content.gallery_name);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfinvoke component="gallery" method="setGallery" returnvariable="gallery_id">
			<cfinvokeargument name="id" value="#attributes.id#">
			<cfinvokeargument name="title" value="#attributes.title#">
			<cfinvokeargument name="date" value="#attributes.date#">
			<cfinvokeargument name="text" value="#attributes.text#">
			<cfinvokeargument name="visible" value="#attributes.visible#">
			<cfinvokeargument name="user_id" value="#request.session.userid#">
			<cfinvokeargument name="tn" value="#attributes.tn#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.gallery&id=#gallery_id#&#request.session.URLToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfif attributes.id NEQ 0>
	<cfinvoke component="gallery" method="getItemlist" returnvariable="qItemlist">
		<cfinvokeargument name="gallery_id" value="#attributes.id#">
	</cfinvoke>
</cfif>

<cfsetting enablecfoutputonly="No">