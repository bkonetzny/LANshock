<cfsetting enablecfoutputonly="Yes">
<!---
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
--->

<cfscript>
	stExportTeams = StructNew();
	stExportTeams[0] = StructNew();
	stExportTeams[0].wwclid = 'F';
	iTempTeamCount = 0;
	lTempTeamIDs = '';
</cfscript>

<cfloop list="#attributes.tournament_export_ids#" index="idx">

	<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournamentData">
		<cfinvokeargument name="id" value="#idx#">
	</cfinvoke>
	
	<cfscript>
		if(qTournamentData.teamsize EQ 1) sPrefix = 'PT';
		else sPrefix = 'CT';
	</cfscript>

	<cfinvoke component="team" method="getTeams" returnvariable="stTeams">
		<cfinvokeargument name="tournamentid" value="#idx#">
	</cfinvoke>

	<cfloop collection="#stTeams#" item="idxTeam">
		<cfscript>
			currentTeamID = stTeams[idxTeam].id;
			stExportTeams[currentTeamID] = StructNew();
			stExportTeams[currentTeamID].leaderid = stTeams[idxTeam].leaderid;
			stExportTeams[currentTeamID].name = stTeams[idxTeam].name;
			stExportTeams[currentTeamID].email = stTeams[idxTeam].leaderemail;
			
			if(len(stTeams[idxTeam].leagueid) GTE 2 AND findNoCase(left(stTeams[idxTeam].leagueid,1),'CP') AND isNumeric(right(stTeams[idxTeam].leagueid,len(stTeams[idxTeam].leagueid)-1)))
				stExportTeams[currentTeamID].wwclid = stTeams[idxTeam].leagueid;
			else{
				iTempTeamCount = iTempTeamCount + 1;
				stExportTeams[currentTeamID].wwclid = sPrefix & iTempTeamCount;
				lTempTeamIDs = ListAppend(lTempTeamIDs,currentTeamID);
			}
		</cfscript>

	</cfloop>

</cfloop>

<cfxml variable="xmlexport">
<wwcl>
<cfoutput>
 	<!-- ASUS.WWCL Export XML Format version 1.1 -->
	<submit>
		<tool>LANshock (#application.lanshock.settings.version# | http://lanshock.com)</tool>
		<timestamp>#DateDiff('s',CreateDateTime("1970","01","01","00","00","00"),now())#</timestamp>
		<party_name>#attributes.wwcl_partyname#</party_name>
		<pid>#attributes.wwcl_pid#</pid>
		<pvdid>#attributes.wwcl_pvdid#</pvdid>
		<stadt>#attributes.wwcl_location#</stadt>
	</submit>
	
	<cfif listLen(lTempTeamIDs)>
	<tmpplayer>
	<cfloop list="#lTempTeamIDs#" index="idxTmp">
		<data><tmpid>#stExportTeams[idxTmp].wwclid#</tmpid><name>#XMLFormat(stExportTeams[idxTmp].name)#</name><email>#XMLFormat(stExportTeams[idxTmp].email)#</email></data>
	</cfloop>
	</tmpplayer>
	</cfif>
	
	<cfloop list="#attributes.tournament_export_ids#" index="idx">

		<cfinvoke component="tournaments" method="getTournamentData" returnvariable="qTournamentData">
			<cfinvokeargument name="id" value="#idx#">
		</cfinvoke>
		
		<cfloop query="qTournamentData">
		<tourney>
			<name>#XMLFormat(name)#</name>
			<gid>#export_league_data#</gid>
			<mode><cfif type EQ 'de'>D<cfelseif type EQ 'se'>S</cfif></mode>
			<maxplayer>#2^Ceiling(LogN(currentteams,2))#</maxplayer>

			<cfswitch expression="#type#">
				<cfcase value="se">

					<cfinvoke component="type_se" method="generateWwclExport" returnvariable="exportContent">
						<cfinvokeargument name="tournamentid" value="#idx#">
						<cfinvokeargument name="stExportTeams" value="#stExportTeams#">
					</cfinvoke>
					
				</cfcase>
				<cfcase value="de">

					<cfinvoke component="type_de" method="generateWwclExport" returnvariable="exportContent">
						<cfinvokeargument name="tournamentid" value="#idx#">
						<cfinvokeargument name="stExportTeams" value="#stExportTeams#">
					</cfinvoke>
					
				</cfcase>
			</cfswitch>
			
			#exportContent#

		</tourney>
		</cfloop>
	
	</cfloop>
</cfoutput>
</wwcl>
</cfxml>

<cffile action="write" file="#UDF_Module('absPath')#/export/export.wwcl.xml" output="#toString(xmlexport)#" addnewline="true">

<cfsetting enablecfoutputonly="No">