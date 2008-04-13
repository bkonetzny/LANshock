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
<cfparam name="attributes.id" default="#session.userid#">

<cfif NOT isNumeric(attributes.id)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.user_not_found')#" addtoken="false">
</cfif>

<cfif session.isAdmin AND NOT attributes.id EQ session.userid>
	<cfset check = UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin')>
</cfif>
	
<cfscript>
	if(session.isAdmin) UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin');
	else attributes.id = session.userid;
</cfscript>

<cfif attributes.form_submitted>

	<cfparam name="attributes.avatar_delete" default="false">
		
	<cfif attributes.avatar_delete>
		<cftry>
			<cffile action="delete" file="#application.lanshock.oHelper.UDF_Module('absStoragePathPublic')#avatars/#attributes.id#.png">
			<cfcatch><!--- do nothing ---></cfcatch>
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
			
			<cfset oImage.resize('',sUploadFile,'#application.lanshock.oHelper.UDF_Module('absStoragePathPublic')#avatars/#attributes.id#.png',application.lanshock.settings.layout.avatar.width,application.lanshock.settings.layout.avatar.height,true)>

			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
		
		<cffile action="delete" file="#sUploadFile#">
	</cfif>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails&id=#attributes.id#')#" addtoken="false">

</cfif>

<cfsetting enablecfoutputonly="No">