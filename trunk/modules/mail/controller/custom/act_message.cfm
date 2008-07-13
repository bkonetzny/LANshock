<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.id" default="">
<cfparam name="attributes.mailtype" default="0">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="getMessage" returnvariable="qMessage">
	<cfinvokeargument name="user_id" value="#session.userid#">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif NOT qMessage.recordcount>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.inbox')#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">