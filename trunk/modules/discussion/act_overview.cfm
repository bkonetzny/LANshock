<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="discussion" method="getGroups" returnvariable="qGroups"></cfinvoke>

<cfinvoke component="#request.lanshock.environment.componentpath#core.comments.comments" method="getTopics" returnvariable="qTopics"></cfinvoke>

<cfquery dbtype="query" name="qTopTopics" maxrows="10">
	SELECT *
	FROM qTopics
	ORDER BY postcount DESC
</cfquery>

<cfquery dbtype="query" name="qLastPosts" maxrows="10">
	SELECT *
	FROM qTopics
	ORDER BY dt_lastpost DESC
</cfquery>

<cfquery dbtype="query" name="qLastTopics" maxrows="10">
	SELECT *
	FROM qTopics
	ORDER BY dt_created DESC
</cfquery>

<cfsetting enablecfoutputonly="No">