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
	<cfparam name="attributes.randomize_first_round" default="false">
	<cfparam name="attributes.calculateMatches" default="false">

	<cfif qTournament.status EQ 'playing' AND attributes.calculateMatches>
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="calculateMatches">
			<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
		</cfinvoke>
		
		<cfset application.lanshock.oCache.drop(sCacheKey)>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
	</cfif>
	
	<cfif qTournament.status EQ 'warmup' AND attributes.randomize_first_round>
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="randomizeFirstRound">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		</cfinvoke>
		
		<cfset application.lanshock.oCache.drop(sCacheKey)>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
	</cfif>
</cfif>

<cfif NOT application.lanshock.oCache.exists(sCacheKey)>

	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="getMatches" returnvariable="qMatches">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
	</cfinvoke>
	
	<cfset stHtmlMatches = StructNew()>
	
	<cfloop query="qMatches">
	
		<cfset sClass = 'match_status_open'>
		<cfif qMatches.status EQ 'done'>
			<cfset sClass = 'match_status_checked'>
		<cfelseif len(submittedby_dt) OR len(checkedby_dt) OR qMatches.status EQ 'admincheck'>
			<cfset sClass = 'match_status_submitted'>
		</cfif>
		<cfset bShowLink = false>
		<cfif qTournament.status NEQ 'signup' AND (status NEQ 'empty' OR session.oUser.checkPermissions('manage'))>
			<cfset bShowLink = true>
		</cfif>
		
		<cfset sClass1 = ''>
		<cfif qMatches.team1 EQ 0>
			<cfset qMatches.team1_name = request.content.team_wildcard>
			<cfset sClass1 = ' team_wildcard'>
		<cfelseif NOT len(qMatches.team1_name)>
			<cfset qMatches.team1_name = request.content.unknown_team>
			<cfset sClass1 = ' team_unknown'>
		</cfif>
		
		<cfset sClass2 = ''>
		<cfif qMatches.team2 EQ 0>
			<cfset qMatches.team2_name = request.content.team_wildcard>
			<cfset sClass2 = ' team_wildcard'>
		<cfelseif NOT len(qMatches.team2_name)>
			<cfset qMatches.team2_name = request.content.unknown_team>
			<cfset sClass2 = ' team_unknown'>
		</cfif>
		
		<cfsavecontent variable="HtmlBox">
			<cfoutput>
				<div class="match_box_status #sClass# team_#qMatches.team1#_box team_#qMatches.team2#_box">
				<cfif bShowLink>
					<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matchdetails&tournamentid=#qTournament.id#&matchid=#id#')#">
				</cfif>
				<span class="team_name team_#qMatches.team1#<cfif winner EQ 'team1'> team_winner<cfelseif winner EQ 'team2'> team_loser</cfif>#sClass1#"><cfif len(qMatches.team1_country)><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/#LCase(qMatches.team1_country)#.png" alt=""> </cfif>#qMatches.team1_name#</span>
				<cfif len(qMatches.team1_result_sum) AND len(qMatches.team2_result_sum)>
					<span class="team_delimiter_result">#qMatches.team1_result_sum# : #qMatches.team2_result_sum#</span>
				<cfelse>
					<span class="team_delimiter">#request.content.versus_short#</span>
				</cfif>
				<span class="team_name team_#qMatches.team2#<cfif winner EQ 'team2'> team_winner<cfelseif winner EQ 'team1'> team_loser</cfif>#sClass2#"><cfif len(qMatches.team2_country)><img src="#application.lanshock.oRuntime.getEnvironment().sWebPath#templates/_shared/images/famfamfam/flags/png/#LCase(qMatches.team2_country)#.png" alt=""> </cfif>#qMatches.team2_name#</span>
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