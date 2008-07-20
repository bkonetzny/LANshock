<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_se_match.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.markteam" default="">
<cfif session.oUser.checkPermissions('manage')>
	<cfparam name="attributes.showstatus" default="false">
<cfelse>
	<cfset attributes.showstatus = false>
</cfif>
<cfparam name="attributes.reset_matches" default="false">
<cfparam name="attributes.randomize_first_round" default="false">
<cfparam name="attributes.calculateMatches" default="false">

<cfif attributes.calculateMatches>
	<cfinvoke component="#application.lanshock.oFactory.load(bCache=false,sObject='lanshock.modules.tournament.model.type_se')#" method="calculateMatches" returnvariable="aStatus">
		<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
	</cfinvoke>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.#myfusebox.thisfuseaction#&tournamentid=#attributes.tournamentid#')#" addtoken="false">
</cfif>

<cfif qTournament.status EQ 'warmup'>
	
	<cfif attributes.reset_matches>
		<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="resetAllMatches">
			<cfinvokeargument name="tournamentid" value="#qTournament.id#">
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

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="getMatches" returnvariable="qMatches">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfsavecontent variable="HtmlBox">
	<cfoutput>
		#request.content.unknown_team#<br>
		#request.content.versus_short#<br>
		#request.content.unknown_team#
	</cfoutput>
</cfsavecontent>

<cfset stHtmlMatches = StructNew()>
<cfset stHtmlMatches['blank'] = HtmlBox>

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
				<div style="background-color: #statuscolor#">
			</cfif>
			<cfif qTournament.status NEQ 'signup' AND (status NEQ 'empty' OR session.oUser.checkPermissions('manage'))>
				<a href="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.matchdetails&tournamentid=#qTournament.id#&matchid=#id#')#">
			</cfif>
			<span title="#team1_name#">#sTeamPre##sTeamName##sTeamPost#</span><br>
			#request.content.versus_short#<br>
			<span title="#team2_name#">#sTeam2Pre##sTeam2Name##sTeam2Post#</span>
			<cfif qTournament.status NEQ 'signup' AND (status NEQ 'empty' OR session.oUser.checkPermissions('manage'))>
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