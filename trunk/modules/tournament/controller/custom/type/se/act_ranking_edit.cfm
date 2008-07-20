<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/modules/tournament/act_type_se_ranking_edit.cfm $
$LastChangedDate: 2006-11-01 21:03:30 +0100 (Mi, 01 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 72 $
--->

<cfparam name="attributes.form_submitted" default="false">

<cfif attributes.form_submitted>

	<cfset stRanking = StructNew()>

	<cfloop collection="#attributes#" item="idx">
	
		<cfif left(idx,7) EQ 'ranking'>
		
			<cfset key = ListLast(idx,'_')>
			
			<cfif NOT StructKeyExists(stRanking,key)>
				<cfset stRanking[key] = StructNew()>
			</cfif>
			<cfif ListGetAt(idx,2,'_') EQ 'pos'>
				<cfset stRanking[key].pos = attributes[idx]>
			</cfif>
			<cfif ListGetAt(idx,2,'_') EQ 'teamid'>
				<cfset stRanking[key].teamid = attributes[idx]>
			</cfif>
			
		</cfif>
	
	</cfloop>

	<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="setRanking" returnvariable="qRanking">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="ranking" value="#stRanking#">
	</cfinvoke>
	
	<cflocation url="#application.lanshock.oHelper.buildUrl('#myfusebox.thiscircuit#.ranking&tournamentid=#qTournament.id#')#" addtoken="false">
	
</cfif>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.type_se')#" method="getRanking" returnvariable="qRanking">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfinvoke component="#application.lanshock.oFactory.load('lanshock.modules.tournament.model.team')#" method="getTeams" returnvariable="stTeams">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
</cfinvoke>

<cfloop query="qRanking">
	<cfparam name="attributes.ranking_pos_#currentrow#" default="#pos#">
	<cfparam name="attributes.ranking_teamid_#currentrow#" default="#teamid#">
</cfloop>

<cfsetting enablecfoutputonly="No">