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

<cfparam name="attributes.id" default="0">
<cfparam name="attributes.delete_accepted" default="false">

<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif NOT qGallery.recordcount AND NOT ((request.session.userid NEQ qGallery.user_id) OR (request.session.isAdmin AND UDF_SecurityCheck(area='delete',returntype='boolean')))>
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.URLToken#" addtoken="false">
</cfif>

<cfif attributes.form_submitted>

	<cfscript>
		// validation
		if(NOT attributes.delete_accepted) ArrayAppend(aError, request.content.gallery_delete_confirm);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="gallery" method="deleteGallery">
			<cfinvokeargument name="id" value="#attributes.id#">
			<cfinvokeargument name="settings" value="#stModuleConfig#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.URLToken#" addtoken="no">
		
	</cfif>
	
</cfif>

<cfsetting enablecfoutputonly="No">