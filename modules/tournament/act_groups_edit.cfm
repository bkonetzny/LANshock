<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.form_action" default="">

<cfparam name="attributes.id" default="0">

<cfinvoke component="tournaments" method="getGroups" returnvariable="qGroups">

<cfinvoke component="tournaments" method="getGroup" returnvariable="qGetCurrentSelection">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif qGetCurrentSelection.recordcount>
	<cfparam name="attributes.name" default="#qGetCurrentSelection.name#">
	<cfparam name="attributes.description" default="#qGetCurrentSelection.description#">
	<cfparam name="attributes.maxsignups" default="#qGetCurrentSelection.maxsignups#">
</cfif>

<cfparam name="attributes.name" default="">
<cfparam name="attributes.description" default="">
<cfparam name="attributes.maxsignups" default="0">

<cfif attributes.form_submitted>

	<cfscript>
		// validation
		if(NOT len(attributes.name)) ArrayAppend(aError, request.content.error_group_name);
		if(NOT len(attributes.maxsignups) OR NOT isNUmeric(attributes.maxsignups)) ArrayAppend(aError, request.content.error_group_maxsignups);
	</cfscript>
	
	<cfif NOT ArrayLen(aError)>

		<cfinvoke component="tournaments" method="setGroup">
			<cfinvokeargument name="id" value="#attributes.id#">
			<cfinvokeargument name="name" value="#attributes.name#">
			<cfinvokeargument name="description" value="#attributes.description#">
			<cfinvokeargument name="maxsignups" value="#attributes.maxsignups#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.groups_edit&#request.session.UrlToken#" addtoken="false">
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">