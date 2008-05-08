<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.search" default="">
<cfparam name="attributes.form_submitted" default="false">

<cfif attributes.form_submitted AND len(attributes.search)>

	<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getTopics" returnvariable="qTopics">
		<cfinvokeargument name="search" value="#attributes.search#">
	</cfinvoke>
	
	<cfquery dbtype="query" name="qTopics">
		SELECT *
		FROM qTopics
		WHERE type NOT IN (<cfqueryparam cfsqltype="cf_sql_varchar" value="#lTypesHide#" list="true">)
		ORDER BY dt_lastpost DESC
	</cfquery>

</cfif>

<cfsetting enablecfoutputonly="No">