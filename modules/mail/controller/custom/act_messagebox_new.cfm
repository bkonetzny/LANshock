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

<cfif attributes.form_submitted AND len(attributes.user_id)>
	<cfloop list="#attributes.user_id#" index="idx">
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="sendMessage">
			<cfinvokeargument name="user_id_from" value="#session.userid#">
			<cfinvokeargument name="user_id_to" value="#idx#">
			<cfinvokeargument name="title" value="#attributes.title#">
			<cfinvokeargument name="text" value="#attributes.text#">
		</cfinvoke>
	</cfloop>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.outbox')#" addtoken="false">
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.mail.model.messenger')#" method="getBuddylist" returnvariable="qBuddylist">
	<cfinvokeargument name="user_id" value="#session.userid#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">