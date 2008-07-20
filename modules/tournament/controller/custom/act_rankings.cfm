<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "name|DESC">

<cfinvoke component="#application.lanshock.oFactory.load('tournament_group','reactorGateway')#" method="getRecords" returnvariable="qGroups">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournaments" returnvariable="qTournaments">

<cfsetting enablecfoutputonly="No">