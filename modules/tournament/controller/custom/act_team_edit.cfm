<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfif qTournament.teamsize EQ 1>
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.teams&tournamentid=#qTournament.id#')#" addtoken="false">
</cfif>

<cfparam name="aError" default="#ArrayNew(1)#">
<cfparam name="attributes.form_submitted" default="false">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeamData" returnvariable="stTeam">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	<cfinvokeargument name="teamid" value="#attributes.teamid#">
</cfinvoke>

<cfquery datasource="#application.lanshock.oRuntime.getEnvironment().sDatasource#" name="qUser" cachedwithin="#CreateTimeSpan(0,0,30,0)#">
	SELECT id, name
	FROM user
	ORDER BY name
</cfquery>

<cfparam name="attributes.teamname" default="#stTeam.name#">
<cfparam name="attributes.leagueid" default="#stTeam.leagueid#">
<cfparam name="attributes.autoacceptids" default="#stTeam.autoacceptids#">

<cfif attributes.form_submitted>

	<cfif session.userid NEQ stTeam.leaderid>
		<cfset ArrayAppend(aError, request.content.error_team_edit_mustbeleader)>
	<cfelse>

		<cfif isDefined("attributes.changeDetails")>
	
			<cfscript>
				if(NOT len(attributes.teamname)) ArrayAppend(aError, request.content.error_team_edit_teamname_invalid);
			</cfscript>
	
			<cfif NOT ArrayLen(aError)>
		
				<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="setTeamData">
					<cfinvokeargument name="teamid" value="#attributes.teamid#">
					<cfinvokeargument name="teamname" value="#attributes.teamname#">
					<cfinvokeargument name="leagueid" value="#attributes.leagueid#">
				</cfinvoke>
				
				<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_edit&tournamentid=#attributes.tournamentid#&teamid=#attributes.teamid#')#" addtoken="false">
			
			</cfif>
			
		<cfelseif isDefined("attributes.addUsers")>
	
			<cfscript>
				lNewIDs = ListAppend(attributes.autoacceptids, attributes.ids_manual);
			</cfscript>
		
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="setTeamData">
				<cfinvokeargument name="teamid" value="#attributes.teamid#">
				<cfinvokeargument name="autoacceptids" value="#lNewIDs#">
			</cfinvoke>
			
			<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_edit&tournamentid=#attributes.tournamentid#&teamid=#attributes.teamid#')#" addtoken="false">
			
		<cfelseif isDefined("attributes.removeUsers")>
			
			<cfset lNewIDs = attributes.autoacceptids>
			<cfloop list="#attributes.ids_auto#" index="idx">
				<cfif ListFind(lNewIDs,idx)>
					<cfset lNewIDs = ListDeleteAt(lNewIDs,ListFind(lNewIDs,idx))>
				</cfif>
			</cfloop>
		
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="setTeamData">
				<cfinvokeargument name="teamid" value="#attributes.teamid#">
				<cfinvokeargument name="autoacceptids" value="#lNewIDs#">
			</cfinvoke>
			
			<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.team_edit&tournamentid=#attributes.tournamentid#&teamid=#attributes.teamid#')#" addtoken="false">
			
		</cfif>
	
	</cfif>

</cfif>

<cfsetting enablecfoutputonly="No">