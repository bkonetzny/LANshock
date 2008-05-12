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

<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
<cfset oUser.setId(session.userid)>
<cfset oUser.load()>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.core._utils.i18n.i18nUtil')#" method="getLocalesStruct" returnvariable="stLocales">

<cfparam name="attributes.firstname" default="#oUser.getFirstname()#">
<cfparam name="attributes.lastname" default="#oUser.getLastname()#">
<cfparam name="attributes.dt_birthdate" default="#oUser.getDt_birthdate()#">
<cfparam name="attributes.gender" default="#oUser.getGender()#">
<cfparam name="attributes.language" default="#oUser.getLanguage()#">
<cfparam name="attributes.country" default="#oUser.getCountry()#">
<cfparam name="attributes.city" default="#oUser.getCity()#">
<cfparam name="attributes.street" default="#oUser.getStreet()#">
<cfparam name="attributes.zip" default="#oUser.getZip()#">
<cfset attributes.status = oUser.getStatus()>

<cfscript>
	if(attributes.gender EQ 0) attributes.gender = 1;

	if(NOT len(attributes.language)) attributes.language = request.lanshock.settings.language;
	
	//if(NOT len(attributes.country)) attributes.country = listFirst(attributes.language,'_');
	
	if(NOT isDate(attributes.dt_birthdate)) attributes.dt_birthdate = now();
</cfscript>

<cfif attributes.form_submitted>

	<cfparam name="attributes.profile_verified" default="0">

	<cfscript>
		if(NOT len(attributes.firstname)) ArrayAppend(aError, request.content.firstname);
		if(NOT len(attributes.lastname)) ArrayAppend(aError, request.content.lastname);
		if(session.isAdmin OR NOT attributes.profile_verified) attributes.dt_birthdate = LSParseDateTime(attributes.dt_birthdate);
		if(NOT isDate(attributes.dt_birthdate)) ArrayAppend(aError, request.content.dt_birthdate);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfset oUser.setFirstname(attributes.firstname)>
		<cfset oUser.setLastname(attributes.lastname)>
		<cfset oUser.setDt_birthdate(attributes.dt_birthdate)>
		<cfset oUser.setGender(attributes.gender)>
		<cfset oUser.setCountry(attributes.country)>
		<cfset oUser.setCity(attributes.city)>
		<cfset oUser.setStreet(attributes.street)>
		<cfset oUser.setZip(attributes.zip)>
		<cfset oUser.save()>

		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#" addtoken="false">
	
	</cfif>

</cfif>

<cfset aCountryList = StructSort(stCountryList)>

<cfsetting enablecfoutputonly="No">