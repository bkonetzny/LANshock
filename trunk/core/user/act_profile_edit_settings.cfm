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

		<cflocation url="#myself##myfusebox.thiscircuit#.userdetails&id=#attributes.id#&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">