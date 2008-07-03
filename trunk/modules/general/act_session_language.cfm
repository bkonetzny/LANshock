<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.language" default="">

<cfif len(attributes.language)>

	<cfset stLocales = application.lanshock.oFactory.load('lanshock.core._utils.i18n.i18nUtil').getLocalesStruct()>
	
	<cfif StructKeyExists(stLocales,attributes.language)>

		<cfset session.oUser.setDataValue('lang',attributes.language)>
	
	</cfif>

</cfif>

<cfif len(cgi.http_referer)>
	<cflocation url="#cgi.http_referer#" addtoken="false">
<cfelse>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.language')#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">