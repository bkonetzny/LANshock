<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.user_id" default="#session.userid#">

<cfif NOT session.oUser.checkPermissions('manage')>
	<cfset attributes.user_id = session.userid>
<cfelse>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournaments" returnvariable="qTournaments">
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getAllUsersInTeams" returnvariable="qUsers">
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getUserTournaments" returnvariable="qMyTournaments">
	<cfinvokeargument name="userid" value="#attributes.user_id#">
</cfinvoke>

<cfsetting enablecfoutputonly="No">