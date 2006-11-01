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

	<cfinvoke component="type_se" method="setRanking" returnvariable="qRanking">
		<cfinvokeargument name="tournamentid" value="#qTournament.id#">
		<cfinvokeargument name="ranking" value="#stRanking#">
	</cfinvoke>
	
	<cflocation url="#myself##myfusebox.thiscircuit#.ranking&tournamentid=#qTournament.id#&#request.session.urltoken#" addtoken="false">
	
</cfif>

<cfinvoke component="type_se" method="getRanking" returnvariable="qRanking">
	<cfinvokeargument name="tournamentid" value="#qTournament.id#">
</cfinvoke>

<cfinvoke component="team" method="getTeams" returnvariable="stTeams">
	<cfinvokeargument name="tournamentid" value="#attributes.tournamentid#">
</cfinvoke>

<cfloop query="qRanking">
	<cfparam name="attributes.ranking_pos_#currentrow#" default="#pos#">
	<cfparam name="attributes.ranking_teamid_#currentrow#" default="#teamid#">
</cfloop>

<cfsetting enablecfoutputonly="No">