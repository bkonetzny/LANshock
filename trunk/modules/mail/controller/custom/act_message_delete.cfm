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
<cfparam name="attributes.messageids" default="#attributes.id#">
<cfparam name="attributes.all" default="false">

<cfif attributes.all>

	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="getMessages" returnvariable="qMessages">
		<cfinvokeargument name="user_id" value="#session.userid#">
		<cfinvokeargument name="mailtype" value="1">
	</cfinvoke>
	
	<cfset attributes.messageids = ValueList(qMessages.id)>

</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="deleteMessages">
	<cfinvokeargument name="user_id" value="#session.userid#">
	<cfinvokeargument name="messageids" value="#attributes.messageids#">
</cfinvoke>

<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.inbox')#" addtoken="false">

<cfsetting enablecfoutputonly="No">