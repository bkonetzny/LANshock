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
</cfif>

<cfparam name="attributes.name" default="">

<cfif attributes.form_submitted>

	<cfinvoke component="discussion" method="setGroup">
		<cfinvokeargument name="id" value="#attributes.id#">
		<cfinvokeargument name="name" value="#attributes.name#">
	</cfinvoke>

	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&#request.session.urltoken#" addtoken="false">

</cfif>

<cfinvoke component="discussion" method="getGroups" returnvariable="qGroups"></cfinvoke>

<cfsetting enablecfoutputonly="No">