<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.user_id" default="#request.session.userid#">

<cfif NOT request.session.isAdmin>

	<cfset attributes.user_id = request.session.userid>

<cfelse>

	<cfinvoke component="tournaments" method="getTournaments" returnvariable="qTournaments">

	<cfinvoke component="team" method="getAllUsersInTeams" returnvariable="qUsers">

</cfif>

<cfinvoke component="tournaments" method="getUserTournaments" returnvariable="qMyTournaments">
	<cfinvokeargument name="userid" value="#attributes.user_id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">