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
<cfparam name="attributes.existing_file" default="0">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.gallery_id#">
</cfinvoke>

<cfif NOT qGallery.recordcount OR session.userid NEQ qGallery.user_id>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>

<cfif NOT session.oUser.checkPermissions('edit-all')>
	<cfset attributes.existing_file = ''>
</cfif>

<cfif attributes.form_submitted>

	<cfif len(attributes.file) OR len(attributes.existing_file)>
	
		<cfset uuid = CreateUUID()>
		<cfset uuidZip = '#uuid#.zip'>
		<cfset bSkip = false>
			
		<cfif NOT DirectoryExists(stModuleConfig.files.storage)>
			<cfdirectory action="create" directory="#stModuleConfig.files.storage#" mode="777">
		</cfif>
			
		<cfif NOT DirectoryExists(application.lanshock.oHelper.UDF_Module('storagePathTemp'))>
			<cfdirectory action="create" directory="#application.lanshock.oHelper.UDF_Module('storagePathTemp')#" mode="777">
		</cfif>
		
		<cfif NOT DirectoryExists('#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuid#/')>
			<cfdirectory action="create" directory="#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuid#/" mode="777">
		</cfif>

		<cfif len(attributes.file)>
			<cffile action="upload" filefield="file" destination="#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuidZip#" mode="777" nameconflict="overwrite">
		<cfelse>
			<cfset uuidZip = attributes.existing_file>
		</cfif>
		
		<cftry>
			<cfscript>
				/* Create an instance of a component object */
				zip = CreateObject("component","#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.zip");
				/* Extract Zip file */ 
				status = zip.Extract('#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuidZip#','#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuid#/');
			</cfscript>
			<cfcatch>
				<cfset bSkip = true>
			</cfcatch>
		</cftry>
	
		<cfif NOT bSkip>
		
			<cfdirectory action="list" directory="#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuid#/" name="qDir" sort="name ASC">
			
			<cfif qDir.recordcount>
				<cfsetting requesttimeout="#qDir.recordcount*30#">
				
				<cfloop query="qDir">
					<cfif type NEQ "dir">
						<cftry>
							<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.gallery.gallery')#" method="setItem">
								<cfinvokeargument name="id" value="0">
								<cfinvokeargument name="gallery_id" value="#attributes.gallery_id#">
								<cfinvokeargument name="title" value="#left(name,255)#">
								<cfinvokeargument name="text" value="">
								<cfinvokeargument name="file" value="#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuid#/#name#">
								<cfinvokeargument name="settings" value="#stModuleConfig#">
							</cfinvoke>
							<cfcatch><!--- do nothing ---></cfcatch>
						</cftry>
					</cfif>
				</cfloop>
			</cfif>
		</cfif>
		
		<cfif DirectoryExists('#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuid#/')>
			<cfdirectory action="delete" directory="#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuid#/" recurse="true">
		</cfif>
		<cfif len(attributes.file) AND FileExists('#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuidZip#')>
			<cffile action="delete" file="#application.lanshock.oHelper.UDF_Module('storagePathTemp')##uuidZip#">
		</cfif>
	
	</cfif>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery&id=#attributes.gallery_id#')#" addtoken="false">

</cfif>

<cfdirectory name="qTmpFiles" action="list" directory="#application.lanshock.oHelper.UDF_Module('storagePathTemp')#" filter="*.zip">

<cfsetting enablecfoutputonly="No">