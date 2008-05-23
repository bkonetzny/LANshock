<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/comments/act_comments_enable_disable.cfm $
$LastChangedDate: 2006-10-23 00:24:29 +0200 (Mo, 23 Okt 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 46 $
--->

<cfparam name="attributes.topic_id" default="0">
<cfparam name="attributes.mode" default="0">

<cfif session.oUser.isLoggedIn()>

	<cfinvoke component="comments" method="setTopicEnableDisable">		
		<cfinvokeargument name="topic_id" value="#attributes.topic_id#">
		<cfinvokeargument name="mode" value="#attributes.mode#">
	</cfinvoke>

</cfif>

<cfif len(cgi.http_referer)>
	<cflocation url="#cgi.http_referer#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">