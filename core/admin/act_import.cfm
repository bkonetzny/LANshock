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
<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.type" default="">

<cfparam name="attributes.file" default="">

<cfif len(attributes.type)>
	<cfinclude template="act_import_#attributes.type#.cfm">
</cfif>

<cfsetting enablecfoutputonly="No">