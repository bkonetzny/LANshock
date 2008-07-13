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
<cfparam name="attributes.title" default="">
<cfparam name="attributes.text" default="">
<cfparam name="attributes.user_id" default="">

<cfif attributes.form_submitted>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="sendMessage">
		<cfinvokeargument name="user_id_from" value="#session.userid#">
		<cfinvokeargument name="user_id_to" value="#attributes.user_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="text" value="#attributes.text#">
	</cfinvoke>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.message_dialog_confirm')#" addtoken="false">
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="getNewMessagesByBuddyID" returnvariable="qMessages">
	<cfinvokeargument name="user_id_to" value="#session.userid#">
	<cfinvokeargument name="user_id_from" value="#attributes.user_id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">