<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.form_submitted" default="false">
<cfparam name="attributes.form_submitted2" default="false">
<cfparam name="attributes.form_submitted3" default="false">
<cfparam name="attributes.form_submitted4" default="false">
<cfparam name="attributes.form_submitted5" default="false">

<cfinvoke component="type_de" method="getMatch" returnvariable="stMatch">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
	<cfinvokeargument name="matchid" value="#attributes.matchid#">
</cfinvoke>

<cfset stResults = StructNew()>
<cfloop query="stMatch.results">
	<cfscript>
		stResults[currentrow] = StructNew();
		stResults[currentrow].team1_result = team1_result;
		stResults[currentrow].team2_result = team2_result;
	</cfscript>
</cfloop>

<cfif attributes.form_submitted>
	
	<cfset UDF_SecurityCheck(area='manage')>

	<cfinvoke component="type_de" method="updateMatch">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="matchid" value="#attributes.matchid#">
		<cfinvokeargument name="team1" value="#attributes.team1#">
		<cfinvokeargument name="team2" value="#attributes.team2#">
		<cfif len(attributes.team1) AND len(attributes.team2)>
			<cfinvokeargument name="status" value="play">
		</cfif>
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&matchid=#attributes.matchid#&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">

<cfelseif attributes.form_submitted2>
	
	<cfset UDF_SecurityCheck(area='manage')>

	<cfinvoke component="type_de" method="updateMatch">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="matchid" value="#attributes.matchid#">
		<cfinvokeargument name="status" value="#attributes.status#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&matchid=#attributes.matchid#&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">

<cfelseif attributes.form_submitted3>
	
	<cfset UDF_SecurityCheck(area='manage')>

	<cfinvoke component="type_de" method="updateMatch">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="matchid" value="#attributes.matchid#">
		<cfinvokeargument name="winner" value="#attributes.winner#">
		<cfif len(attributes.winner)>
			<cfinvokeargument name="status" value="done">
		</cfif>
		<cfinvokeargument name="checkedby_admin" value="#request.session.userid#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&matchid=#attributes.matchid#&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">

<cfelseif attributes.form_submitted4>
	
	<cfif NOT ListFind('#stMatch.team1.id#,#stMatch.team2.id#',qTeamCurrentUser.id)>
		<cfset UDF_SecurityCheck(area='manage')>
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

		<cfinvoke component="type_de" method="updateResults">
			<cfinvokeargument name="matchid" value="#attributes.matchid#">
			<cfinvokeargument name="results" value="#stResults#">
		</cfinvoke>
	
		<cfinvoke component="type_de" method="updateMatch">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="matchid" value="#attributes.matchid#">
			<cfinvokeargument name="submittedby_userid" value="#request.session.userid#">
			<cfinvokeargument name="submittedby_teamid" value="#qTeamCurrentUser.id#">
		</cfinvoke>
		
		<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&matchid=#attributes.matchid#&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">
	
	</cfif>
	
<cfelseif attributes.form_submitted5>
		
	<cfinvoke component="type_de" method="updateMatch">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="matchid" value="#attributes.matchid#">
		<cfif isDefined("attributes.check1")>
			<cfinvokeargument name="checkedby_userid" value="#request.session.userid#">
			<cfinvokeargument name="checkedby_teamid" value="#qTeamCurrentUser.id#">
			<cfinvokeargument name="status" value="admincheck">
		<cfelseif isDefined("attributes.check0")>
			<cfinvokeargument name="status" value="reset">
		</cfif>
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&matchid=#attributes.matchid#&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">

</cfif>

<cfif stMatch.status EQ 'empty' AND request.session.isAdmin>

	<cfinvoke component="team" method="getTeams" returnvariable="stTeams">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>
	
	<cfscript>
		iTeams = qTournament.currentteams;
		iTeams = 2^Ceiling(LogN(iTeams,2));
		iBrackets = iTeams;
		iRowCount = 0;
		
		while(iBrackets GTE 2){
			iRowCount = iRowCount + 1;
			iBrackets = iBrackets / 2;
		}
	
		iRowCountL = (iRowCount - 1) * 2;
		
		lWinners = '';
	</cfscript>
	
	<cfif stMatch.col NEQ iRowCountL+1>
	
		<cfif stMatch.col-1 LTE iRowCountL>
		
			<cfinvoke component="type_de" method="getMatchesByCol" returnvariable="qMatches">
				<cfinvokeargument name="tournamentid" value="#qTournament.id#">
				<cfinvokeargument name="col" value="#stMatch.col+1#">
			</cfinvoke>
		
			<cfloop query="qMatches">
				<cfscript>
					if(stMatch.col EQ iRowCountL){
						// get all winners of pre-round
						if(winner EQ 'team1') lWinners = ListAppend(lWinners,team2);
						if(winner EQ 'team2') lWinners = ListAppend(lWinners,team1);
						
						// get winners of related pre-rounds
						if(row EQ stMatch.row*2-1){
							if(winner EQ 'team1') idTeam1 = team2;
							if(winner EQ 'team2') idTeam1 = team1;
						}
						else if(row EQ stMatch.row*2){
							if(winner EQ 'team1') idTeam2 = team2;
							if(winner EQ 'team2') idTeam2 = team1;
						}
					}
					else{
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
					}
				</cfscript>
			</cfloop>
		
		<cfelse>
		
			<cfinvoke component="type_de" method="getMatchesByCol" returnvariable="qMatches">
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

</cfif>

<cfsetting enablecfoutputonly="No">