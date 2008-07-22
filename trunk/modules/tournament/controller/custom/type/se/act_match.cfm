<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_se_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfset sCacheKey = 'module:tournament:#attributes.tournamentid#:matchview'>

<cfif session.oUser.checkPermissions('manage')>
	<cfparam name="attributes.reset_matches" default="false">
	<cfparam name="attributes.randomize_first_round" default="false">
	<cfparam name="attributes.calculateMatches" default="false">

	<cfif attributes.calculateMatches>
		<cfset application.lanshock.oCache.drop(sCacheKey)>
		
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="calculateMatches">
			<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
		</cfinvoke>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
	</cfif>
	
	<cfif qTournament.status EQ 'warmup'>
		
		<cfif attributes.reset_matches>
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="resetAllMatches">
				<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			</cfinvoke>

			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="createAllMatches">
				<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
			</cfinvoke>
			
			<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
		</cfif>
		
		<cfif attributes.randomize_first_round>
			<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="randomizeFirstRound">
				<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			</cfinvoke>
			
			<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
		</cfif>
	
	</cfif>
</cfif>

<cfif NOT application.lanshock.oCache.exists(sCacheKey)>

	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="getMatches" returnvariable="qMatches">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
	</cfinvoke>
	
	<cfset stHtmlMatches = StructNew()>
	
	<cfloop query="qMatches">
	
		<cfset sClass = 'match_status_open'>
		<cfif len(checkedby_admin) OR qMatches.status EQ 'done'>
			<cfset sClass = 'match_status_checked'>
		<cfelseif len(submittedby_dt) OR len(checkedby_dt)>
			<cfset sClass = 'match_status_submitted'>
		</cfif>
		<cfset bShowLink = false>
		<cfif qTournament.status NEQ 'signup' AND (status NEQ 'empty' OR session.oUser.checkPermissions('manage'))>
			<cfset bShowLink = true>
		</cfif>
		
		<cfset bHasTeam1 = false>
		<cfif len(qMatches.team1_name)>
			<cfset bHasTeam1 = true>
		</cfif>
		<cfset bHasTeam2 = false>
		<cfif len(qMatches.team2_name)>
			<cfset bHasTeam2 = true>
		</cfif>
		
		<cfsavecontent variable="HtmlBox">
			<cfoutput>
				<div class="#sClass# team_#qMatches.team1#_box team_#qMatches.team2#_box">
				<cfif bShowLink>
					<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matchdetails&tournamentid=#qTournament.id#&matchid=#id#')#">
				</cfif>
				<span class="team_name team_#qMatches.team1#<cfif winner EQ 'team1'> team_winner<cfelseif winner EQ 'team2'> team_loser</cfif><cfif NOT bHasTeam1> team_wildcard</cfif>"><cfif bHasTeam1>#qMatches.team1_name#<cfelse>#request.content.unknown_team#</cfif></span>
				<span class="team_delimiter">#request.content.versus_short#</span>
				<span class="team_name team_#qMatches.team2#<cfif winner EQ 'team2'> team_winner<cfelseif winner EQ 'team1'> team_loser</cfif><cfif NOT bHasTeam2> team_wildcard</cfif>"><cfif bHasTeam2>#qMatches.team2_name#<cfelse>#request.content.unknown_team#</cfif></span>
				<cfif bShowLink>
					</a>
				</cfif>
				</div>
			</cfoutput>
		</cfsavecontent>
		
		<cfset stHtmlMatches['#col#_#row#'] = HtmlBox>
	</cfloop>
	
</cfif>

<cfsetting enablecfoutputonly="No">