<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/comments/act_comment_edit.cfm $
$LastChangedDate: 2006-10-23 00:24:29 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 46 $
--->

<cfparam name="attributes.id" default="0">
<cfparam name="attributes.topic_id" default="0">
<cfparam name="attributes.parent_id" default="0">
<cfparam name="attributes.module" default="">
<cfparam name="attributes.identifier" default="">
<cfparam name="attributes.title" default="">
<cfparam name="attributes.text" default="">
<cfparam name="attributes.linktosource" default="">
<cfparam name="attributes.type" default="">
<cfparam name="attributes.appendsignature" default="false">

<cfset bDoPost = false>
	
<!--- check for parent_id or module and identifier --->
<cfif (isNumeric(attributes.topic_id) AND attributes.topic_id NEQ 0) OR (len(attributes.module) AND len(attributes.identifier))>
	<cfset bDoPost = true>
</cfif>
	
<!--- check for title or text --->
<cfif bDoPost AND NOT (len(attributes.title) AND len(attributes.text))>
	<cfset bDoPost = false>
</cfif>

<cfif bDoPost>
	<cfset bDoPost = session.oUser.isLoggedIn()>
</cfif>

<cfif bDoPost>
	<cfset iTopicID = attributes.topic_id>
	<cfif attributes.topic_id EQ 0>
		<cfinvoke component="comments" method="setTopic" returnvariable="iTopicID">
			<cfinvokeargument name="module" value="#attributes.module#">
			<cfinvokeargument name="identifier" value="#attributes.identifier#">
			<cfinvokeargument name="linktosource" value="#attributes.linktosource#">
			<cfinvokeargument name="type" value="#attributes.type#">
		</cfinvoke>
	</cfif>

	<cfinvoke component="comments" method="setPost">		
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="topic_id" value="#iTopicID#">
		<cfinvokeargument name="parent_id" value="#attributes.parent_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="text" value="#attributes.text#">
		<cfinvokeargument name="user_id" value="#session.oUser.getDataValue('userid')#">
		<cfinvokeargument name="appendsignature" value="#attributes.appendsignature#">
	</cfinvoke>
</cfif>

<cfif bDoPost AND attributes.topic_id EQ 0>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#attributes.module#.#attributes.linktosource#')#" addtoken="false">
<cfelse>
	<cflocation url="#cgi.http_referer#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">