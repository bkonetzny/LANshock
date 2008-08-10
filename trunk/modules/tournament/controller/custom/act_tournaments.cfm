<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<!--- <cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "name|ASC">

<cfinvoke component="#application.lanshock.oFactory.load('tournament_group','reactorGateway')#" method="getRecords" returnvariable="qGroups">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke> --->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getTournaments" returnvariable="qTournaments">

<!--- <cfset stFilter = StructNew()>
<cfset stFilter.lSortFields = "name|ASC">

<cfinvoke component="#application.lanshock.oFactory.load('tournament_tournament','reactorGateway')#" method="getRecords" returnvariable="qTournaments">
	<cfinvokeargument name="stFilter" value="#stFilter#">
</cfinvoke> --->

<cfif session.userloggedin>
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.tournaments')#" method="getUserTournaments" returnvariable="qUserTournaments">
		<cfinvokeargument name="userid" value="#session.userid#">
	</cfinvoke>

	<cfif stModuleConfig.groupmaxsignups>
		<cfset aUserGroupIDs = ArrayNew(1)>
		<cfloop list="#ValueList(qUserTournaments.groupid)#" index="idx">
			<cfparam name="aUserGroupIDs['#idx#']" default="0">
			<cfset aUserGroupIDs[idx] = aUserGroupIDs[idx] + 1>
		</cfloop>
	</cfif>
	
	<cfif stModuleConfig.coinsystem>
		<cfset iUserCoins = stModuleConfig.coinsystem_usercoins>
		<cfloop list="#ValueList(qUserTournaments.coins)#" index="idx">
			<cfset iUserCoins = iUserCoins - idx>
		</cfloop>
	</cfif>
</cfif>

<cfsetting enablecfoutputonly="No">