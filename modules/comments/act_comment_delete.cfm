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
	<cfset iUserID = session.oUser.getDataValue('userid')>

	<cfif session.oUser.checkPermissions('comments-manage','comments')>
		<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="getPostData">
			SELECT user_id
			FROM core_comments_posts
			WHERE id = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.id#">
		</cfquery>
		<cfset iUserID = getPostData.user_id>
	</cfif>
	
	<cfinvoke component="comments" method="deletePost">		
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="user_id" value="#iUserID#">
	</cfinvoke>
</cfif>

<cfif len(cgi.http_referer)>
	<cflocation url="#cgi.http_referer#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">