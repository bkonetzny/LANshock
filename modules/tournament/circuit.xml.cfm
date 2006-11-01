<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public">

	<!-- Show Tournaments -->
	<fuseaction name="tournaments">
		<include template="act_tournaments.cfm"/>
		<include template="dsp_tournaments.cfm"/>
	</fuseaction>

	<!-- Copy of "tournaments" -->
	<fuseaction name="main">
		<include template="act_tournaments.cfm"/>
		<include template="dsp_tournaments.cfm"/>
	</fuseaction>

	<!-- Show My Tournaments -->
	<fuseaction name="mytournaments">
		<include template="act_mytournaments.cfm"/>
		<include template="dsp_mytournaments.cfm"/>
	</fuseaction>

	<!-- Show Timetable -->
	<fuseaction name="timetable">
		<include template="act_timetable.cfm"/>
		<include template="dsp_timetable.cfm"/>
	</fuseaction>

	<!-- Show Rankings -->
	<fuseaction name="rankings">
		<include template="act_rankings.cfm"/>
		<include template="dsp_rankings.cfm"/>
	</fuseaction>

	<!-- Show Management -->
	<fuseaction name="management">
		<include template="act_management.cfm"/>
		<include template="dsp_management.cfm"/>
	</fuseaction>

	<!-- Show Export -->
	<fuseaction name="export">
		<include template="act_export.cfm"/>
		<include template="dsp_export.cfm"/>
	</fuseaction>

	<!-- Show Rules -->
	<fuseaction name="rules">
		<include template="_tournament_header.cfm"/>
		<include template="dsp_rules.cfm"/>
	</fuseaction>

	<!-- Show Ranking -->
	<fuseaction name="ranking">
		<include template="_tournament_header.cfm"/>
		<include template="act_ranking.cfm"/>
	</fuseaction>

	<!-- Edit Ranking -->
	<fuseaction name="ranking_edit">
		<include template="_tournament_header.cfm"/>
		<include template="act_ranking_edit.cfm"/>
	</fuseaction>

	<!-- Join Tournament -->
	<fuseaction name="signup">
		<include template="_tournament_header.cfm"/>
		<include template="act_signup.cfm"/>
		<include template="dsp_signup.cfm"/>
		<include template="dsp_rules.cfm"/>
	</fuseaction>

	<!-- Show Teams -->
	<fuseaction name="teams">
		<include template="_tournament_header.cfm"/>
		<include template="act_teams.cfm"/>
		<include template="dsp_teams.cfm"/>
	</fuseaction>

	<!-- Show Teamdetails -->
	<fuseaction name="team_details">
		<include template="_tournament_header.cfm"/>
		<include template="act_team_details.cfm"/>
		<include template="dsp_team_details.cfm"/>
	</fuseaction>

	<!-- Edit Teamdetails -->
	<fuseaction name="team_edit">
		<include template="_tournament_header.cfm"/>
		<include template="act_team_edit.cfm"/>
		<include template="dsp_team_edit.cfm"/>
	</fuseaction>

	<!-- Leave Team -->
	<fuseaction name="team_leave">
		<include template="_tournament_header.cfm"/>
		<include template="act_team_leave.cfm"/>
		<include template="dsp_team_leave.cfm"/>
	</fuseaction>

	<!-- Join Team -->
	<fuseaction name="team_join">
		<include template="_tournament_header.cfm"/>
		<include template="act_team_join.cfm"/>
		<include template="dsp_team_join.cfm"/>
	</fuseaction>

	<!-- Delete Team (Leader Only) -->
	<fuseaction name="team_delete">
		<include template="_tournament_header.cfm"/>
		<include template="act_team_delete.cfm"/>
		<include template="dsp_team_delete.cfm"/>
	</fuseaction>

	<!-- Change Player Status (Leader Only) -->
	<fuseaction name="team_player_change_status">
		<include template="act_team_player_change_status.cfm"/>
	</fuseaction>

	<!-- Rearrange Players (Leader Only) -->
	<fuseaction name="team_player_rearrange_players">
		<include template="act_team_player_rearrange_players.cfm"/>
	</fuseaction>

	<!-- Delete Team (Leader Only) -->
	<fuseaction name="team_player_delete">
		<include template="_tournament_header.cfm"/>
		<include template="act_team_player_delete.cfm"/>
		<include template="dsp_team_player_delete.cfm"/>
	</fuseaction>

	<!-- Edit Groups -->
	<fuseaction name="groups_edit">
		<set name="check" value="#UDF_SecurityCheck(area='manage')#"/>
		<include template="act_groups_edit.cfm"/>
		<include template="dsp_groups_edit.cfm"/>
	</fuseaction>

	<!-- Delete Groups -->
	<fuseaction name="groups_delete">
		<set name="check" value="#UDF_SecurityCheck(area='manage')#"/>
		<include template="act_groups_delete.cfm"/>
	</fuseaction>

	<!-- Edit Tournaments -->
	<fuseaction name="tournaments_edit">
		<set name="check" value="#UDF_SecurityCheck(area='manage')#"/>
		<include template="act_tournaments_edit.cfm"/>
		<include template="dsp_tournaments_edit.cfm"/>
	</fuseaction>

	<!-- Edit Tournaments (Export Settings) -->
	<fuseaction name="tournaments_edit_exportsettings">
		<set name="check" value="#UDF_SecurityCheck(area='manage')#"/>
		<include template="dsp_tournaments_edit_exportsettings.cfm"/>
	</fuseaction>

	<!-- Edit Tournaments (Type Specific) -->
	<fuseaction name="tournaments_edit_settings">
		<set name="check" value="#UDF_SecurityCheck(area='manage')#"/>
		<include template="act_tournaments_edit_settings.cfm"/>
		<include template="dsp_tournaments_edit_settings.cfm"/>
	</fuseaction>

	<!-- Delete Tournaments -->
	<fuseaction name="tournaments_delete">
		<set name="check" value="#UDF_SecurityCheck(area='manage')#"/>
		<include template="act_tournaments_delete.cfm"/>
		<include template="dsp_tournaments_delete.cfm"/>
	</fuseaction>

	<!-- Change Tournamentstatus -->
	<fuseaction name="tournament_changestatus">
		<set name="check" value="#UDF_SecurityCheck(area='manage')#"/>
		<include template="_tournament_header.cfm"/>
		<include template="act_tournament_changestatus.cfm"/>
		<include template="dsp_tournament_changestatus.cfm"/>
	</fuseaction>

	<!-- Show Matches -->
	<fuseaction name="matches">
		<include template="_tournament_header.cfm"/>
		<include template="act_matches.cfm"/>
	</fuseaction>

	<!-- Show Matchdetails -->
	<fuseaction name="matchdetails">
		<include template="_tournament_header.cfm"/>
		<include template="act_matchdetails.cfm"/>
	</fuseaction>
	
</circuit>