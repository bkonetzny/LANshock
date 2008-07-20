<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_se_matchdetails.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.form_submitted2" default="false">
<cfparam name="attributes.form_submitted3" default="false">
<cfparam name="attributes.form_submitted4" default="false">
<cfparam name="attributes.form_submitted5" default="false">

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="getMatch" returnvariable="stMatch">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
	<cfinvokeargument name="matchid" value="#attributes.matchid#">
</cfinvoke>

<cfset stResults = StructNew()>
<cfloop query="stMatch.results">
	<cfset stResults[currentrow] = StructNew()>
	<cfset stResults[currentrow].team1_result = team1_result>
	<cfset stResults[currentrow].team2_result = team2_result>
</cfloop>

<cfif attributes.form_submitted>
	
	<cfif session.oUser.checkPermissions('manage')>
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateMatch">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="matchid" value="#attributes.matchid#">
			<cfif len(attributes.team1)>
				<cfinvokeargument name="team1" value="#attributes.team1#">
			</cfif>
			<cfif len(attributes.team2)>
				<cfinvokeargument name="team2" value="#attributes.team2#">
			</cfif>
			<cfif len(attributes.team1) AND len(attributes.team2)>
				<cfinvokeargument name="status" value="play">
			</cfif>
		</cfinvoke>
	</cfif>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#attributes.matchid#')#" addtoken="false">

<cfelseif attributes.form_submitted2>
	
	<cfif session.oUser.checkPermissions('manage')>
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateMatch">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="matchid" value="#attributes.matchid#">
			<cfinvokeargument name="status" value="#attributes.status#">
		</cfinvoke>
	</cfif>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#attributes.matchid#')#" addtoken="false">

<cfelseif attributes.form_submitted3>
	
	<cfif session.oUser.checkPermissions('manage')>
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateMatch">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="matchid" value="#attributes.matchid#">
			<cfinvokeargument name="winner" value="#attributes.winner#">
			<cfif len(attributes.winner)>
				<cfinvokeargument name="status" value="done">
			</cfif>
			<cfinvokeargument name="checkedby_admin" value="#session.userid#">
		</cfinvoke>
	</cfif>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#attributes.matchid#')#" addtoken="false">

<cfelseif attributes.form_submitted4>
	
	<cfif NOT ListFind('#stMatch.team1.id#,#stMatch.team2.id#',qTeamCurrentUser.id)
		AND NOT session.oUser.checkPermissions('manage')>
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#attributes.matchid#')#" addtoken="false">
	</cfif>
	
	<cfscript>
		stResults = StructNew();
		
		for(item in attributes){
			if(ListFirst(item,'_') EQ 'round'){
				key = ListGetAt(item,2,'_');
				if(NOT StructKeyExists(stResults,key)) stResults[key] = StructNew();
				if(ListGetAt(item,3,'_') EQ 'team1') stResults[key].team1_result = attributes[item];
				if(ListGetAt(item,3,'_') EQ 'team2') stResults[key].team2_result = attributes[item];
			}
		}
	</cfscript>
	
	<cfif isDefined("attributes.finish")>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateResults">
			<cfinvokeargument name="matchid" value="#attributes.matchid#">
			<cfinvokeargument name="results" value="#stResults#">
		</cfinvoke>
	
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateMatch">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="matchid" value="#attributes.matchid#">
			<cfinvokeargument name="submittedby_userid" value="#session.userid#">
			<cfinvokeargument name="submittedby_teamid" value="#qTeamCurrentUser.id#">
		</cfinvoke>
		
		<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#attributes.matchid#')#" addtoken="false">
	
	</cfif>
	
<cfelseif attributes.form_submitted5>
		
	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="updateMatch">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="matchid" value="#attributes.matchid#">
		<cfif isDefined("attributes.check1")>
			<cfinvokeargument name="checkedby_userid" value="#session.userid#">
			<cfinvokeargument name="checkedby_teamid" value="#qTeamCurrentUser.id#">
			<cfinvokeargument name="status" value="admincheck">
		<cfelseif isDefined("attributes.check0")>
			<cfinvokeargument name="status" value="reset">
		</cfif>
	</cfinvoke>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#qTournament.id#&matchid=#attributes.matchid#')#" addtoken="false">

</cfif>

<cfif stMatch.status EQ 'empty' AND session.oUser.checkPermissions('manage')>

	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeams" returnvariable="stTeams">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>
	
	<cfset lWinners = ''>
	
	<cfif stMatch.col-1 GTE 1>

		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="getMatchesByCol" returnvariable="qMatches">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="col" value="#stMatch.col-1#">
		</cfinvoke>
		
		<cfloop query="qMatches">
			<cfscript>
				// get all winners of pre-round
				if(winner EQ 'team1') lWinners = ListAppend(lWinners,team1);
				if(winner EQ 'team2') lWinners = ListAppend(lWinners,team2);
				
				// get winners of related pre-rounds
				if(row EQ stMatch.row*2-1){
					if(winner EQ 'team1') idTeam1 = team1;
					if(winner EQ 'team2') idTeam1 = team2;
				}
				else if(row EQ stMatch.row*2){
					if(winner EQ 'team1') idTeam2 = team1;
					if(winner EQ 'team2') idTeam2 = team2;
				}
			</cfscript>
		</cfloop>
	
	</cfif>

</cfif>
	
<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.comments.comments')#" method="getCommentsPanel" returnvariable="stComments">
	<cfinvokeargument name="module" value="#myfusebox.thiscircuit#">
	<cfinvokeargument name="identifier" value="match#attributes.matchid#">
	<cfinvokeargument name="linktosource" value="matchdetails&tournamentid=#attributes.tournamentid#&matchid=#attributes.matchid#">
	<cfinvokeargument name="type" value="match">
</cfinvoke>

<cfsetting enablecfoutputonly="No">