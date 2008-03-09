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

<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.gallery_id#">
</cfinvoke>

<cfif NOT qGallery.recordcount AND NOT ((session.userid EQ qGallery.user_id) OR (session.isAdmin AND UDF_SecurityCheck(area='edit',returntype='boolean')))>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>

<cfif attributes.id NEQ 0>
	<cfinvoke component="gallery" method="getItem" returnvariable="qItem">
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
			
	<cfif NOT DirectoryExists(stModuleConfig.files.storage)>
		<cfdirectory action="create" directory="#stModuleConfig.files.storage#" mode="777">
	</cfif>
		
	<cfif NOT DirectoryExists(stModuleConfig.files.tmp)>
		<cfdirectory action="create" directory="#stModuleConfig.files.tmp#" mode="777">
	</cfif>
		
	<cfif NOT DirectoryExists("#stModuleConfig.files.storage##attributes.gallery_id#/original/")>
		<cfdirectory action="create" directory="#stModuleConfig.files.storage##attributes.gallery_id#/original/" mode="777">
	</cfif>

	<cfset uuidFile = '#stModuleConfig.files.storage##attributes.gallery_id#/original/#CreateUUID()#.jpg'>
	<cfif len(attributes.file)>
		<cffile action="upload" filefield="file" destination="#uuidFile#" mode="777" nameconflict="overwrite">
	</cfif>
	
	<cfinvoke component="gallery" method="setItem" returnvariable="item_id">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="gallery_id" value="#attributes.gallery_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="text" value="#attributes.text#">
		<cfif len(attributes.file)>
			<cfinvokeargument name="file" value="#uuidFile#">
		</cfif>
		<cfinvokeargument name="settings" value="#stModuleConfig#">
	</cfinvoke>
	
	<!--- <cfif len(attributes.file) AND FileExists(uuidFile)>
		<cffile action="delete" file="#uuidFile#">
	</cfif> --->
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery&id=#attributes.gallery_id#')#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">