<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.id" default="0">

<cfif request.session.userloggedin>

	<cfinvoke component="comments" method="deletePost">		
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="user_id" value="#request.session.userid#">
	</cfinvoke>

</cfif>

<cflocation url="#cgi.http_referer#" addtoken="false">

<cfsetting enablecfoutputonly="No">