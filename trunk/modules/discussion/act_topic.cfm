<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.uuid" default="">
<cfparam name="attributes.id" default="">

<cfif len(attributes.uuid)>

	<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getTopic" returnvariable="qTopic">
		<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
		<cfinvokeargument name="identifier" value="topic_#attributes.uuid#">
	</cfinvoke>

	<cfif qTopic.recordcount>
		<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&id=#qTopic.id#&#session.urltoken#" addtoken="false">
	</cfif>

<cfelseif isNumeric(attributes.id)>

	<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getTopic" returnvariable="qTopic">
		<cfinvokeargument name="id" value="#attributes.id#">
	</cfinvoke>

<cfelse>
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#session.urltoken#" addtoken="false">
</cfif>

<cfif NOT qTopic.recordcount>
	<cflocation url="#myself##myfusebox.thiscircuit#.main&#session.urltoken#" addtoken="false">
</cfif>

<cfif ListFind(lTypesHide,qTopic.type)>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.main')#" addtoken="false">
</cfif>

<cfinvoke component="discussion" method="getGroups" returnvariable="qGroups"></cfinvoke>

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#qTopic.module#">
	<cfinvokeargument name="identifier" value="#qTopic.identifier#">
	<cfinvokeargument name="linktosource" value="topic&id=#qTopic.id#">
	<cfinvokeargument name="type" value="post">
	<cfinvokeargument name="topic_title" value="#qTopic.title#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">