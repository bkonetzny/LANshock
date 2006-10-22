<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.buddy_id" default="">

<cfif isNumeric(attributes.buddy_id) AND attributes.buddy_id GT 0>
	<cfinvoke component="messenger" method="addBuddy">
		<cfinvokeargument name="user_id" value="#request.session.userid#">
		<cfinvokeargument name="buddy_id" value="#attributes.buddy_id#">
	</cfinvoke>
</cfif>

<cflocation url="#cgi.http_referer#" addtoken="false">

<cfsetting enablecfoutputonly="No">