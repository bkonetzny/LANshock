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

<cfinvoke component="gallery" method="getGallery" returnvariable="qGallery">
	<cfinvokeargument name="id" value="#attributes.gallery_id#">
</cfinvoke>

<cfif NOT qGallery.recordcount OR session.userid NEQ qGallery.user_id>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>

<cfif attributes.form_submitted>

	<cfif len(attributes.file)>
	
		<cfset uuid = CreateUUID()>
		<cfset uuidZip = '#uuid#.zip'>
		<cfset bSkip = false>
			
		<cfif NOT DirectoryExists(stModuleConfig.files.storage)>
			<cfdirectory action="create" directory="#stModuleConfig.files.storage#" mode="777">
		</cfif>
			
		<cfif NOT DirectoryExists(stModuleConfig.files.tmp)>
			<cfdirectory action="create" directory="#stModuleConfig.files.tmp#" mode="777">
		</cfif>
			
		<cfif NOT DirectoryExists('#stModuleConfig.files.tmp##uuid#/')>
			<cfdirectory action="create" directory="#stModuleConfig.files.tmp##uuid#/" mode="777">
		</cfif>

		<cffile action="upload" filefield="file" destination="#stModuleConfig.files.tmp##uuidZip#" mode="777" nameconflict="overwrite">
		
		<cftry>
			<cfscript>
				/* Create an instance of a component object */
				zip = CreateObject("component","#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.zip");
				/* Extract Zip file */ 
				status = zip.Extract('#stModuleConfig.files.tmp##uuidZip#','#stModuleConfig.files.tmp##uuid#/');
			</cfscript>
			<cfcatch>
				<cfset bSkip = true>
			</cfcatch>
		</cftry>
	
		<cfif NOT bSkip>
		
			<cfdirectory action="list" directory="#stModuleConfig.files.tmp##uuid#/" name="qDir" sort="name ASC">
			
			<cfloop query="qDir">
				<cfif type NEQ "dir">
					<cftry>
						<cfinvoke component="gallery" method="setItem">
							<cfinvokeargument name="id" value="0">
							<cfinvokeargument name="gallery_id" value="#attributes.gallery_id#">
							<cfinvokeargument name="title" value="#left(name,255)#">
							<cfinvokeargument name="text" value="">
							<cfinvokeargument name="file" value="#stModuleConfig.files.tmp##uuid#/#name#">
							<cfinvokeargument name="settings" value="#stModuleConfig#">
						</cfinvoke>
						<cfcatch><!--- do nothing ---></cfcatch>
					</cftry>
				</cfif>
			</cfloop>
		</cfif>
			
		<cfif DirectoryExists('#stModuleConfig.files.tmp##uuid#/')>
			<cfdirectory action="delete" directory="#stModuleConfig.files.tmp##uuid#/" recurse="true">
		</cfif>
		<cfif FileExists('#stModuleConfig.files.tmp##uuidZip#')>
			<cffile action="delete" file="#stModuleConfig.files.tmp##uuidZip#">
		</cfif>
	
	</cfif>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.gallery&id=#attributes.gallery_id#')#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">