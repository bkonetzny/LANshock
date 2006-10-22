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
	<cfinvoke component="messenger" method="sendMessage">
		<cfinvokeargument name="user_id_from" value="#request.session.userid#">
		<cfinvokeargument name="user_id_to" value="#attributes.user_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="text" value="#attributes.text#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#request.session.UrlToken#" addtoken="false">
</cfif>

<cfinvoke component="messenger" method="getBuddylist" returnvariable="qBuddylist">
	<cfinvokeargument name="user_id" value="#request.session.userid#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">