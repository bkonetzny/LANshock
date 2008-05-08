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

<cfinvoke component="discussion" method="getBoard" returnvariable="qBoard">
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

	<cfinvoke component="discussion" method="setBoard">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="group_id" value="#attributes.group_id#">
		<cfinvokeargument name="title" value="#attributes.title#">
		<cfinvokeargument name="subtitle" value="#attributes.subtitle#">
	</cfinvoke>

	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.urltoken#" addtoken="false">

</cfif>

<cfinvoke component="discussion" method="getGroups" returnvariable="qGroups"></cfinvoke>

<cfinvoke component="#application.lanshock.oRuntime.getEnvironment().sComponentPath#modules.comments.comments" method="getModuleTypes" returnvariable="stModuleTypes">

<cfif StructKeyExists(stModuleTypes,myfusebox.thiscircuit)>
	<cfset StructDelete(stModuleTypes,myfusebox.thiscircuit)>
</cfif>

<cfif NOT qGroups.recordcount>
	<cflocation url="#myself##myfusebox.thiscircuit#.group_edit&#session.urltoken#" addtoken="false">
</cfif>

<cfsetting enablecfoutputonly="No">