<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_profile_edit_personaldata.cfm $
$LastChangedDate: 2007-07-08 13:01:39 +0200 (So, 08 Jul 2007) $
$LastChangedBy: majestixs $
$LastChangedRevision: 96 $
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

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#core._utils.i18n.i18nUtil" method="getLocalesStruct" returnvariable="stLocales">

<cfparam name="attributes.firstname" default="#oObUser.getProperty('firstname')#">
<cfparam name="attributes.lastname" default="#oObUser.getProperty('lastname')#">
<cfparam name="attributes.dt_birthdate" default="#oObUser.getProperty('dt_birthdate')#">
<cfparam name="attributes.gender" default="#oObUser.getProperty('gender')#">
<cfparam name="attributes.idcardnumber" default="#oObUser.getProperty('idcardnumber')#">
<cfparam name="attributes.language" default="#oObUser.getProperty('language')#">
<cfparam name="attributes.country" default="#oObUser.getProperty('country')#">
<cfparam name="attributes.city" default="#oObUser.getProperty('city')#">
<cfparam name="attributes.street" default="#oObUser.getProperty('street')#">
<cfparam name="attributes.zip" default="#oObUser.getProperty('zip')#">

<cfscript>
	if(attributes.gender EQ 0) attributes.gender = 1;

	if(NOT len(attributes.language)) attributes.language = request.lanshock.settings.language;
	
	if(NOT len(attributes.country)) attributes.country = listFirst(attributes.language,'_');
	
	if(NOT isDate(attributes.dt_birthdate)) attributes.dt_birthdate = now();
</cfscript>

<cfif attributes.form_submitted>

	<cfparam name="attributes.profile_verified" default="0">

	<cfscript>
		if(session.isAdmin OR stModuleConfig.userprofile.edit_personal_data OR NOT isNumeric(attributes.id)){
			if(NOT len(attributes.firstname)) ArrayAppend(aError, request.content.firstname);
			if(NOT len(attributes.lastname)) ArrayAppend(aError, request.content.lastname);
			if(session.isAdmin OR NOT attributes.profile_verified) attributes.dt_birthdate = LSParseDateTime(attributes.dt_birthdate);
			if(NOT isDate(attributes.dt_birthdate)) ArrayAppend(aError, request.content.dt_birthdate);
		}
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfscript>
			oObUser.setProperty("firstname",attributes.firstname);
			oObUser.setProperty("lastname",attributes.lastname);
			oObUser.setProperty("dt_birthdate",attributes.dt_birthdate);
			oObUser.setProperty("gender",attributes.gender);
			oObUser.setProperty("idcardnumber",attributes.idcardnumber);
			oObUser.setProperty("country",attributes.country);
			oObUser.setProperty("city",attributes.city);
			oObUser.setProperty("street",attributes.street);
			oObUser.setProperty("zip",attributes.zip);
			if(session.isAdmin) oObUser.setProperty("profile_verified",attributes.profile_verified);
			oObUser.commit();
		</cfscript>

		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails&id=#attributes.id#')#" addtoken="false">
	
	</cfif>

</cfif>

<cfparam name="attributes.profile_verified" default="#oObUser.getProperty('profile_verified')#">

<cfsetting enablecfoutputonly="No">