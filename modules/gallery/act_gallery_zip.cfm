<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.gallery_id" default="">

<cfset sDirectory = '#stModuleConfig.files.storage#/#attributes.gallery_id#/'>
<cfset sTargetDirectory = '#stModuleConfig.files.storage#/storage/'>
<cfset sZipFile = '#sTargetDirectory#gallery#attributes.gallery_id#.zip'>

<cfif isNumeric(attributes.gallery_id) AND directoryExists(sDirectory)>
	<cfif fileExists(sZipFile)>
		<cffile action="delete" file="#sZipFile#">
	</cfif>
	<cfif NOT directoryExists(sTargetDirectory)>
		<cfdirectory action="create" directory="#sTargetDirectory#" mode="777">
	</cfif>
	<cfscript>
		/* Create an instance of a component object */
		zip = CreateObject("component","#application.lanshock.environment.componentpath#core._utils.zip");
		/* Add files to Zip file */
		status = zip.AddFiles(zipFilePath=sZipFile,directory=sDirectory,recurse=true);
	</cfscript>
</cfif>

<cflocation url="#myself##myfusebox.thiscircuit#.gallery&id=#attributes.gallery_id#&#request.session.URLToken#" addtoken="false">

<cfsetting enablecfoutputonly="No">