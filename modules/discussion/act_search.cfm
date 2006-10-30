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

	<cfinvoke component="#request.lanshock.environment.componentpath#core.comments.comments" method="getTopics" returnvariable="qTopics">
		<cfinvokeargument name="search" value="#attributes.search#">
	</cfinvoke>

</cfif>

<cfsetting enablecfoutputonly="No">