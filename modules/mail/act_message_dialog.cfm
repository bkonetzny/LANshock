<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/mail/act_message_dialog.cfm $
$LastChangedDate: 2006-10-23 00:48:53 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 55 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.title" default="">
<cfparam name="attributes.text" default="">
<cfparam name="attributes.user_id" default="">

<cfif attributes.form_submitted>
	<cfinvoke component="messenger" method="sendMessage">
		<cfinvokeargument name="user_id_from" value="#request.session.userid#">
		<cfinvokeargument name="user_id_to" value="#attributes.user_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="text" value="#attributes.text#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.message_dialog_confirm&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfinvoke component="messenger" method="getNewMessagesByBuddyID" returnvariable="qMessages">
	<cfinvokeargument name="user_id_to" value="#request.session.userid#">
	<cfinvokeargument name="user_id_from" value="#attributes.user_id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">