<cfoutput>
	<fuseaction access="public" name="seasons">
		<include circuit="#sModule#" template="custom/act_seasons"/>
		<include circuit="v_#sModule#" template="custom/dsp_seasons"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournaments">
		<include circuit="#sModule#" template="custom/act_tournaments"/>
		<include circuit="v_#sModule#" template="custom/dsp_tournaments"/>
	</fuseaction>

	<fuseaction access="public" name="mytournaments">
		<include circuit="#sModule#" template="custom/act_mytournaments"/>
		<include circuit="v_#sModule#" template="custom/dsp_mytournaments"/>
	</fuseaction>

	<fuseaction access="public" name="timetable">
		<include circuit="#sModule#" template="custom/act_timetable"/>
		<include circuit="v_#sModule#" template="custom/dsp_timetable"/>
	</fuseaction>

	<fuseaction access="public" name="rankings">
		<include circuit="#sModule#" template="custom/act_rankings"/>
		<include circuit="v_#sModule#" template="custom/dsp_rankings"/>
	</fuseaction>

	<fuseaction access="public" name="management">
		<include circuit="#sModule#" template="custom/act_management"/>
		<include circuit="v_#sModule#" template="custom/dsp_management"/>
	</fuseaction>

	<fuseaction access="public" name="export">
		<lanshock:security area="export"/>
		<include circuit="#sModule#" template="custom/act_export"/>
		<include circuit="v_#sModule#" template="custom/dsp_export"/>
	</fuseaction>

	<fuseaction access="public" name="rules">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="v_#sModule#" template="custom/dsp_rules"/>
	</fuseaction>

	<fuseaction access="public" name="ranking">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_ranking"/>
	</fuseaction>

	<fuseaction access="public" name="ranking_edit">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_ranking_edit"/>
	</fuseaction>

	<fuseaction access="public" name="signup">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_signup"/>
		<include circuit="v_#sModule#" template="custom/dsp_signup"/>
		<include circuit="v_#sModule#" template="custom/dsp_rules"/>
	</fuseaction>

	<fuseaction access="public" name="teams">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_teams"/>
		<include circuit="v_#sModule#" template="custom/dsp_teams"/>
	</fuseaction>

	<fuseaction access="public" name="team_details">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_team_details"/>
		<include circuit="v_#sModule#" template="custom/dsp_team_details"/>
	</fuseaction>

	<fuseaction access="public" name="team_edit">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_team_edit"/>
		<include circuit="v_#sModule#" template="custom/dsp_team_edit"/>
	</fuseaction>

	<fuseaction access="public" name="team_leave">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_team_leave"/>
		<include circuit="v_#sModule#" template="custom/dsp_team_leave"/>
	</fuseaction>

	<fuseaction access="public" name="team_join">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_team_join"/>
		<include circuit="v_#sModule#" template="custom/dsp_team_join"/>
	</fuseaction>

	<fuseaction access="public" name="team_delete">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_team_delete"/>
		<include circuit="v_#sModule#" template="custom/dsp_team_delete"/>
	</fuseaction>

	<fuseaction access="public" name="team_player_change_status">
		<include circuit="#sModule#" template="custom/act_team_player_change_status"/>
	</fuseaction>

	<fuseaction access="public" name="team_player_rearrange_players">
		<include circuit="#sModule#" template="custom/act_team_player_rearrange_players"/>
	</fuseaction>

	<fuseaction access="public" name="team_player_delete">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_team_player_delete"/>
		<include circuit="v_#sModule#" template="custom/dsp_team_player_delete"/>
	</fuseaction>

	<fuseaction access="public" name="tournaments_edit_exportsettings">
		<lanshock:security area="manage"/>
		<include circuit="v_#sModule#" template="custom/dsp_tournaments_edit_exportsettings"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_changestatus">
		<lanshock:security area="manage"/>
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_tournament_changestatus"/>
		<include circuit="v_#sModule#" template="custom/dsp_tournament_changestatus"/>
	</fuseaction>

	<fuseaction access="public" name="matches">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_matches"/>
	</fuseaction>

	<fuseaction access="public" name="matchdetails">
		<include circuit="v_#sModule#" template="custom/inc_dsp_tournament_header"/>
		<include circuit="#sModule#" template="custom/act_matchdetails"/>
	</fuseaction>
</cfoutput>