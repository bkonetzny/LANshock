<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getTopics" returnvariable="qTopics"></cfinvoke>

<cfquery dbtype="query" name="qTopTopics" maxrows="5">
	SELECT *
	FROM qTopics
	WHERE type NOT IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#lTypesHide#" list="true">)
	ORDER BY postcount DESC
</cfquery>

<cfquery dbtype="query" name="qLastPosts" maxrows="5">
	SELECT *
	FROM qTopics
	WHERE type NOT IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#lTypesHide#" list="true">)
	ORDER BY dt_lastpost DESC
</cfquery>

<cfsetting enablecfoutputonly="No">