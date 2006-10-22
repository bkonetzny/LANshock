<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.topic_id" default="0">
<cfparam name="attributes.mode" default="0">

<cfif request.session.userloggedin>

	<cfinvoke component="comments" method="setTopicEnableDisable">		
		<cfinvokeargument name="topic_id" value="#attributes.topic_id#">
		<cfinvokeargument name="mode" value="#attributes.mode#">
	</cfinvoke>

</cfif>

<cflocation url="#cgi.http_referer#" addtoken="false">

<cfsetting enablecfoutputonly="No">