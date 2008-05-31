<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/act_buddy_del.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfparam name="attributes.buddy_id" default="">

<cfif isNumeric(attributes.buddy_id) AND attributes.buddy_id GT 0>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="removeBuddy">
		<cfinvokeargument name="user_id" value="#session.userid#">
		<cfinvokeargument name="buddy_id" value="#attributes.buddy_id#">
	</cfinvoke>
</cfif>

<cflocation url="#cgi.http_referer#" addtoken="false">

<cfsetting enablecfoutputonly="No">