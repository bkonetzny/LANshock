<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.id" default="0">
<cfparam name="attributes.checkTopics" default="false">

<cfif attributes.checkTopics>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getTopics" returnvariable="qTopics">
	
	<cfloop query="qTopics">
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="updateTopicData">
			<cfinvokeargument name="id" value="#qTopics.id#">
		</cfinvoke>
	</cfloop>
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getBoard" returnvariable="qBoard">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif qBoard.recordcount>
	<cfparam name="attributes.group_id" default="#qBoard.group_id#">
	<cfparam name="attributes.title" default="#qBoard.title#">
	<cfparam name="attributes.subtitle" default="#qBoard.subtitle#">
</cfif>

<cfparam name="attributes.group_id" default="">
<cfparam name="attributes.title" default="">
<cfparam name="attributes.subtitle" default="">
<cfparam name="attributes.mapped_module_type" default="">

<cfif attributes.form_submitted>

	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="setBoard">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="group_id" value="#attributes.group_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="subtitle" value="#attributes.subtitle#">
	</cfinvoke>

	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#')#" addtoken="false">

</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.discussion.discussion')#" method="getGroups" returnvariable="qGroups">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getModuleTypes" returnvariable="stModuleTypes">

<cfif NOT qGroups.recordcount>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.group_edit')#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">