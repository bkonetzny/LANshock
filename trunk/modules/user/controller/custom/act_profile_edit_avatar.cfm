<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_profile_edit_avatar.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="aError" default="#ArrayNew(1)#">

<cfif attributes.form_submitted>

	<cfparam name="attributes.avatar_delete" default="false">
		
	<cfif attributes.avatar_delete OR len(avatar)>
		<cftry>
			<cffile action="delete" file="#application.lanshock.oHelper.UDF_Module('absStoragePathPublic')#avatars/#session.userid#.png">
			<cfcatch><cfset ArrayAppend(aError,cfcatch.message)></cfcatch>
		</cftry>
	</cfif>
	
	<!--- avatar image --->
	<cfif len(avatar)>
	
		<cffile action="upload" filefield="avatar" destination="#application.lanshock.oHelper.UDF_Module('storagePathTemp')#" nameconflict="makeunique" mode="777">
		<cfset sUploadFile = cffile.serverdirectory & '/' & cffile.serverfile>
		
		<cfif NOT directoryExists("#application.lanshock.oHelper.UDF_Module('absStoragePathPublic')#avatars/")>
			<cfdirectory action="create" directory="#application.lanshock.oHelper.UDF_Module('absStoragePathPublic')#avatars/" mode="777">
		</cfif>
		
		<cftry>
			<cfset oImage = application.lanshock.oFactory.load('lanshock.core._utils.image.image')>
		
			<cfset oImage.setOption('defaultJpegCompression','100')>
			<cfset oImage.setOption('tempDirectory',application.lanshock.oHelper.UDF_Module('storagePathTemp'))>
			
			<cfset oImage.resize('',sUploadFile,'#application.lanshock.oHelper.UDF_Module('absStoragePathPublic')#avatars/#session.userid#.png',80,80,true)>

			<cfcatch><cfset ArrayAppend(aError,cfcatch.message)></cfcatch>
		</cftry>
		
		<cffile action="delete" file="#sUploadFile#">
	</cfif>
	
	<cfif NOT ArrayLen(aError)>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#" addtoken="false">
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">