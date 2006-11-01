<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfparam name="attributes.markteam" default="">
<cfif request.session.isAdmin>
	<cfparam name="attributes.showstatus" default="true">
<cfelse>
	<cfset attributes.showstatus = false>
</cfif>
<cfparam name="attributes.randomize_first_round" default="false">

<cfif attributes.randomize_first_round AND qTournament.status EQ 'warmup'>
	
	<cfinvoke component="team" method="getTeams" returnvariable="stTeams">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>

	<cfscript>
		lTeamIDs = '';
		iTeamsReal = qTournament.currentteams;
		iTeamsDummy = 2^Ceiling(LogN(iTeamsReal,2))-iTeamsReal;

		iTeams = qTournament.currentteams;
		iTeams = 2^Ceiling(LogN(iTeams,2));
		iBrackets = iTeams;
		iRowCount = 0;
		
		while(iBrackets GTE 2){
			iRowCount = iRowCount + 1;
			iBrackets = iBrackets / 2;
		}
		
		firstRoundCol = (iRowCount - 1) * 2 + 1;
	</cfscript>
	
	<cfloop collection="#stTeams#" item="team">
		<cfset lTeamIDs = ListAppend(lTeamIDs,stTeams[team].id)>
	</cfloop>
	
	<cfif iTeamsDummy GT 0>
		<cfloop from="1" to="#iTeamsDummy#" index="dummy">
			<cfset lTeamIDs = ListAppend(lTeamIDs,0)>
		</cfloop>
	</cfif>
	
	<cfset lTeamIDs = ListRandom(lTeamIDs)>

	<cfinvoke component="type_de" method="getMatchesByCol" returnvariable="qMatchesFirstRound">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="col" value="#firstRoundCol#">
	</cfinvoke>
	
	<cfloop query="qMatchesFirstRound">
		
		<cfinvoke component="type_de" method="updateMatch">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
			<cfinvokeargument name="matchid" value="#id#">
			<cfinvokeargument name="team1" value="#ListFirst(lTeamIDs)#">
			<cfset lTeamIDs = listDeleteAt(lTeamIDs,1)>
			<cfinvokeargument name="team2" value="#ListFirst(lTeamIDs)#">
			<cfset lTeamIDs = listDeleteAt(lTeamIDs,1)>
			<cfinvokeargument name="status" value="play">
		</cfinvoke>
	
	</cfloop>

</cfif>

<cfinvoke component="type_de" method="getMatches" returnvariable="qMatches">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfset stHtmlMatches = StructNew()>

<cfsavecontent variable="HtmlBox">
	<cfoutput>
		#request.content.unknown_team#<br>
		#request.content.versus_short#<br>
		#request.content.unknown_team#
	</cfoutput>
</cfsavecontent>
<cfscript>
	stHtmlMatches['blank'] = HtmlBox;
</cfscript>

<cfloop query="qMatches">

	<cfscript>
		sTeamPre = '';
		sTeamPost = '';
				
		if(len(team1_name)){
			if(len(team1_name) GT 12) sTeamname = '#left(team1_name,12)#...';
			else sTeamname = team1_name;
			
			if(winner EQ 'team1'){
				if(attributes.markteam EQ team1){
					sTeamPre = '<strong><span style="color: red;">';
					sTeamPost = '</span></strong>';
				}
				else{
					sTeamPre = '<strong>';
					sTeamPost = '</strong>';
				}
			}
			else if(attributes.markteam EQ team1){
				sTeamPre = '<span style="color: red;">';
				sTeamPost = '</span>';
			}
		}
		else{
			sTeamName = request.content.unknown_team;
		}
		
		sTeam2Pre = '';
		sTeam2Post = '';
				
		if(len(team2_name)){
			if(len(team2_name) GT 12) sTeam2Name = '#left(team2_name,12)#...';
			else sTeam2Name = team2_name;
			
			if(winner EQ 'team2'){
				if(attributes.markteam EQ team2){
					sTeam2Pre = '<strong><span style="color: red;">';
					sTeam2Post = '</span></strong>';
				}
				else{
					sTeam2Pre = '<strong>';
					sTeam2Post = '</strong>';
				}
			}
			else if(attributes.markteam EQ team2){
				sTeam2Pre = '<span style="color: red;">';
				sTeam2Post = '</span>';
			}
		}
		else{
			sTeam2Name = request.content.unknown_team;
		}
	</cfscript>
	
	<cfsavecontent variable="HtmlBox">
		<cfoutput>
			<cfif attributes.showstatus>
				<cfscript>
					if(len(checkedby_admin)) statuscolor = '##67C72E'; // green
					else if(len(submittedby_dt) OR len(checkedby_dt)) statuscolor = '##EDB42E'; // orange
					else statuscolor = '##EA6C0F'; // red
				</cfscript>
				<div style="background-color:  #statuscolor#">
			</cfif>
			<cfif qTournament.status NEQ 'signup' AND (status NEQ 'empty' OR request.session.isAdmin)>
				<a href="#myself##myfusebox.thiscircuit#.matchdetails&tournamentid=#qTournament.id#&matchid=#id#&#request.session.urltoken#">
			</cfif>
			<span title="#team1_name#">#sTeamPre##sTeamName##sTeamPost#</span><br>
			#request.content.versus_short#<br>
			<span title="#team2_name#">#sTeam2Pre##sTeam2Name##sTeam2Post#</span>
			<cfif qTournament.status NEQ 'signup' AND (status NEQ 'empty' OR request.session.isAdmin)>
				</a>
			</cfif>
			<cfif attributes.showstatus>
				</div>
			</cfif>
		</cfoutput>
	</cfsavecontent>
	
	<cfscript>
		stHtmlMatches['#col#_#row#'] = HtmlBox;
	</cfscript>
</cfloop>

<cfsetting enablecfoutputonly="No">