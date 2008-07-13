<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.mailtype" default="0">
<cfif myfusebox.thisfuseaction EQ 'outbox'>
	<cfset attributes.mailtype = 1>
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="getMessages" returnvariable="qMessages">
	<cfinvokeargument name="user_id" value="#session.userid#">
	<cfinvokeargument name="mailtype" value="#attributes.mailtype#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">