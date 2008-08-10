<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeams" returnvariable="stTeams">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
</cfinvoke>

<cfif isDefined("form_submitted_dummyteams") AND form_submitted_dummyteams>

	<cfloop collection="#stTeams#" item="idx">
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="removeTeam">
			<cfinvokeargument name="teamid" value="#stTeams[idx].id#">
		</cfinvoke>
	</cfloop>
	
	<cfinvoke component="#application.lanshock.oFactory.load('user','reactorGateway')#" method="getRecords" returnvariable="qDummyUsers">
	
	<cfset iCount = 0>
	<cfloop condition="#iCount# LTE #attributes.dummyteams#">
		<cfloop query="qDummyUsers">
			<cfset iCount = iCount + 1>
			<cfif iCount LTE attributes.dummyteams>
				<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="createTeam" returnvariable="teamid">
					<cfinvokeargument name="name" value="#qDummyUsers.name# ###iCount#">
					<cfinvokeargument name="leaderid" value="#qDummyUsers.id#">
					<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
					<cfinvokeargument name="leagueid" value="">
				</cfinvoke>
			</cfif>
		</cfloop>
	</cfloop>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
	
</cfif>

<cfsetting enablecfoutputonly="No">