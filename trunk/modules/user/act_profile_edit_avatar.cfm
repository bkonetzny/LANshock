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
<cfparam name="attributes.id" default="#request.session.userid#">

<cfif NOT isNumeric(attributes.id)>
	<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.user_not_found&1&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif request.session.isAdmin AND NOT attributes.id EQ request.session.userid>
	<cfset check = UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin')>
</cfif>
	
<cfscript>
	if(request.session.isAdmin) UDF_SecurityCheck('guest',request.lanshock.settings.modulePrefix.core & 'admin');
	else attributes.id = request.session.userid;
</cfscript>

<cfif attributes.form_submitted>

	<cfparam name="attributes.avatar_delete" default="false">
		
	<cfif attributes.avatar_delete>
		<cftry>
			<cffile action="delete" file="#UDF_Module('absPath')#avatar/#attributes.id#">
			<cfcatch><!--- do nothing ---></cfcatch>
		</cftry>
	</cfif>
	
	<!--- avatar image --->
	<cfif len(avatar)>
		<cffile action="upload" filefield="avatar" destination="#UDF_Module('absPath')#avatar/temp/" mode="777" nameconflict="makeunique">
		<cftry>
			<cfif ListFindNoCase("gif,jpg,jpeg", cffile.serverfileext)>
				<cfscript>
					imageCFC = createObject("component","#application.lanshock.environment.componentpath#core._utils.image.image");
					oImage = imageCFC.getImageInfo("","#UDF_Module('absPath')#avatar/temp/#cffile.serverfile#");
					if(oImage.width / application.lanshock.settings.layout.avatar.width GTE oImage.height / application.lanshock.settings.layout.avatar.height)
						imageCFC.scaleX(oImage.img,"","#UDF_Module('absPath')#avatar/#attributes.id#.png",application.lanshock.settings.layout.avatar.width);
					else imageCFC.scaleY(oImage.img,"","#UDF_Module('absPath')#avatar/#attributes.id#.png",application.lanshock.settings.layout.avatar.height);
				</cfscript>
			</cfif>
			<cffile action="delete" file="#UDF_Module('absPath')#avatar/temp/#cffile.serverfile#">
			<cfcatch>
				<cftry>
					<cffile action="delete" file="#UDF_Module('absPath')#avatar/temp/#cffile.serverfile#">
					<cfcatch><!--- do nothing ---></cfcatch>
				</cftry>
			</cfcatch>
		</cftry>
	<cfelseif len(attributes.avatar_sample) AND FileExists('#UDF_Module('absPath')#avatar/samples/#attributes.avatar_sample#')>
		<cfscript>
			imageCFC = createObject("component","#application.lanshock.environment.componentpath#core._utils.image.image");
			oImage = imageCFC.getImageInfo("","#UDF_Module('absPath')#avatar/samples/#attributes.avatar_sample#");
			if(oImage.width / application.lanshock.settings.layout.avatar.width GTE oImage.height / application.lanshock.settings.layout.avatar.height)
				imageCFC.scaleX(oImage.img,"","#UDF_Module('absPath')#avatar/#attributes.id#.png",application.lanshock.settings.layout.avatar.width);
			else imageCFC.scaleY(oImage.img,"","#UDF_Module('absPath')#avatar/#attributes.id#.png",application.lanshock.settings.layout.avatar.height);
		</cfscript>
		<!--- <cffile action="copy" destination="#UDF_Module('absPath')#avatar/#attributes.id#" mode="777" source="#UDF_Module('absPath')#avatar/samples/#attributes.avatar_sample#"> --->
	</cfif>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.userdetails&id=#attributes.id#&#request.session.UrlToken#" addtoken="false">

</cfif>

<cfdirectory directory="#UDF_Module('absPath')#avatar/samples/" filter="*.jpg" name="qSamples1">
<cfdirectory directory="#UDF_Module('absPath')#avatar/samples/" filter="*.gif" name="qSamples2">

<cfset lSamples = ''>
<cfloop query="qSamples1">
	<cfset lSamples = ListAppend(lSamples,name)>
</cfloop>
<cfloop query="qSamples2">
	<cfset lSamples = ListAppend(lSamples,name)>
</cfloop>

<cfsetting enablecfoutputonly="No">