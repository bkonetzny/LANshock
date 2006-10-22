<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.id" default="#request.session.UserID#">

<cfif NOT isNumeric(attributes.id)>
	<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.user_not_found&#request.session.urltoken#" addtoken="false">
</cfif>

<cfinvoke component="user" method="getUser" returnvariable="qUserData">	
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfinvoke component="user" method="getUserHistory" returnvariable="qUserHistory">	
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif NOT qUserData.recordcount>
	<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.user_not_found&#request.session.urltoken#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">