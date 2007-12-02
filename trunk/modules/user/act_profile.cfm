<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/act_profile.cfm $
$LastChangedDate: 2006-10-22 23:54:35 +0200 (So, 22 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 33 $
--->

<cfparam name="attributes.id" default="#request.session.userid#">

<cfif isNumeric(attributes.id)>
	<cfinvoke component="user" method="getUser" returnvariable="qUserData">	
		<cfinvokeargument name="id" value="#attributes.id#">
	</cfinvoke>
</cfif>

<cfif NOT isNumeric(attributes.id) OR NOT qUserData.recordcount>
	<cflocation url="#myself##request.lanshock.settings.modulePrefix.core#user.user_not_found&#request.session.urltoken#" addtoken="false">
</cfif>

<cfif request.session.UserID EQ attributes.id>
	<cfinvoke component="#application.lanshock.environment.componentpath#modules.mail.messenger" method="getMessages" returnvariable="qNewMail">	
		<cfinvokeargument name="user_id" value="#attributes.id#">
		<cfinvokeargument name="newonly" value="1">
	</cfinvoke>
</cfif>

<cfsetting enablecfoutputonly="No">