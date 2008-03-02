<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/comments/act_comment_delete.cfm $
$LastChangedDate: 2006-10-23 00:24:29 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 46 $
--->

<cfparam name="attributes.id" default="0">

<cfif session.oUser.isLoggedIn()>

	<cfinvoke component="comments" method="deletePost">		
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="user_id" value="#session.oUser.getDataValue('userid')#">
	</cfinvoke>

</cfif>

<cflocation url="#cgi.http_referer#" addtoken="false">

<cfsetting enablecfoutputonly="No">