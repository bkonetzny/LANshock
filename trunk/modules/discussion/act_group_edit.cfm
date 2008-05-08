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

<cfinvoke component="discussion" method="getGroup" returnvariable="qGroup">
	<cfinvokeargument name="id" value="#attributes.id#">
</cfinvoke>

<cfif qGroup.recordcount>
	<cfparam name="attributes.name" default="#qGroup.name#">
	<cfparam name="attributes.permission" default="#qGroup.permission#">
</cfif>

<cfparam name="attributes.name" default="">
<cfparam name="attributes.permission" default="">

<cfif attributes.form_submitted>

	<cfinvoke component="discussion" method="setGroup">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="name" value="#attributes.name#">
		<cfinvokeargument name="permission" value="#attributes.permission#">
	</cfinvoke>

	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#session.urltoken#" addtoken="false">

</cfif>

<cfinvoke component="discussion" method="getGroups" returnvariable="qGroups"></cfinvoke>

<cfsetting enablecfoutputonly="No">