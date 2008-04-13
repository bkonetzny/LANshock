<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_profile_edit_settings.cfm $
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

	oObUser = objectBreeze.objectCreate("user");
	oObUser.read(attributes.id);
</cfscript>

<cfparam name="attributes.homepage" default="#oObUser.getProperty('homepage')#">
<cfparam name="attributes.signature" default="#oObUser.getProperty('signature')#">
<cfparam name="attributes.geo_lat" default="#oObUser.getProperty('geo_lat')#">
<cfparam name="attributes.geo_long" default="#oObUser.getProperty('geo_long')#">

<cfif attributes.form_submitted>

	<cfscript>
		if(len(attributes.geo_lat) AND NOT isNumeric(attributes.geo_lat)) ArrayAppend(aError, request.content.geo_lat);
		if(len(attributes.geo_long) AND NOT isNumeric(attributes.geo_long)) ArrayAppend(aError, request.content.geo_long);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfscript>
			oObUser.setProperty("homepage",attributes.homepage);
			oObUser.setProperty("signature",attributes.signature);
			oObUser.setProperty("geo_lat",attributes.geo_lat);
			oObUser.setProperty("geo_long",attributes.geo_long);
			oObUser.commit();
		</cfscript>

		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails&id=#attributes.id#')#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">