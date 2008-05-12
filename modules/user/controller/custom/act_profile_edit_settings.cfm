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

<cfset oUser = application.lanshock.oFactory.load('user','reactorRecord')>
<cfset oUser.setId(session.userid)>
<cfset oUser.load()>
	
<cfparam name="attributes.homepage" default="#oUser.getHomepage()#">
<cfparam name="attributes.signature" default="#oUser.getSignature()#">
<cfparam name="attributes.geo_latlong" default="#oUser.getGeo_latlong()#">

<cfif attributes.form_submitted>

	<cfscript>
		if(NOT (ListLen(attributes.geo_latlong,',') EQ 2 AND isNumeric(ListFirst(attributes.geo_latlong,',')) AND isNumeric(ListLast(attributes.geo_latlong,',')))) ArrayAppend(aError, request.content.geo_lat);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>
	
		<cfset oUser.setHomepage(attributes.homepage)>
		<cfset oUser.setSignature(attributes.signature)>
		<cfset oUser.setGeo_latlong(attributes.geo_latlong)>
		<cfset oUser.save()>

		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.userdetails')#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">