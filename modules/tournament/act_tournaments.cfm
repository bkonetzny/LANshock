<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif StructKeyExists(attributes,'view')>
	<cfset request.session.oPreferences.setPreference(myfusebox.thiscircuit,'view',attributes.view)>
</cfif>

<cfset stPreferences = request.session.oPreferences.getPreferences(myfusebox.thiscircuit)>
<cfif len(stPreferences.view)>
	<cfset attributes.view = stPreferences.view>
</cfif>

<cfparam name="attributes.view" default="#stModuleConfig.layout.listview.default#">

<cfset request.session.oPreferences.setPreference(myfusebox.thiscircuit,'view',attributes.view)>

<cfinvoke component="tournaments" method="getGroups" returnvariable="qGroups">

<cfinvoke component="tournaments" method="getTournaments" returnvariable="qTournaments">

<cfif request.session.userloggedin>
	<cfinvoke component="tournaments" method="getUserTournaments" returnvariable="qUserTournaments">
		<cfinvokeargument name="userid" value="#request.session.userid#">
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