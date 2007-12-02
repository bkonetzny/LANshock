<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_user_history.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
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