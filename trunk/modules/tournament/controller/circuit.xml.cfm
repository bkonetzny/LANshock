<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/" xmlns:lanshock="lanshock/">

	
	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/tournament/i18n/lang.properties" returnvariable="request.content"/>
			
				
				
<lanshock:i18n load="modules/tournament/i18n/custom/lang.properties" returnvariable="request.content"/>
				
			
			<include circuit="tournament" template="settings"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<postfuseaction>
		<lanshock:fuseaction>
			<if condition="isDefined('request.layout')">
				<true>
					<if condition="request.layout EQ 'json'">
						<true>
							<set name="_fba.debug" value="false"/>
							<include circuit="v_tournament" template="dsp_layout_json"/>
						</true>
						<false>
							<if condition="request.layout EQ 'none'">
								<true>
									<set name="_fba.debug" value="false"/>
								</true>
								<false>
									<if condition="request.layout EQ 'admin'">
										<true>
											
										</true>
									</if>
								</false>
							</if>
						</false>
					</if>
				</true>
				
			</if>
		</lanshock:fuseaction>
	</postfuseaction>
	
	<fuseaction access="public" name="main">
		
			
			<xfa name="relocate" value="seasons"/>
<lanshock:relocate xfa="relocate"/>
			
		
	</fuseaction>
	
	<fuseaction access="public" name="seasons">
		<include circuit="tournament" template="custom/act_seasons"/>
		<include circuit="v_tournament" template="custom/dsp_seasons"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournaments">
		<include circuit="tournament" template="custom/act_tournaments"/>
		<include circuit="v_tournament" template="custom/dsp_tournaments"/>
	</fuseaction>
	
	<fuseaction access="public" name="mytournaments">
		<include circuit="tournament" template="custom/act_mytournaments"/>
		<include circuit="v_tournament" template="custom/dsp_mytournaments"/>
	</fuseaction>
	
	<fuseaction access="public" name="timetable">
		<include circuit="tournament" template="custom/act_timetable"/>
		<include circuit="v_tournament" template="custom/dsp_timetable"/>
	</fuseaction>
	
	<fuseaction access="public" name="rankings">
		<include circuit="tournament" template="custom/act_rankings"/>
		<include circuit="v_tournament" template="custom/dsp_rankings"/>
	</fuseaction>
	
	<fuseaction access="public" name="management">
		<include circuit="tournament" template="custom/act_management"/>
		<include circuit="v_tournament" template="custom/dsp_management"/>
	</fuseaction>
	
	<fuseaction access="public" name="export">
		<lanshock:security area="export"/>
		<include circuit="tournament" template="custom/act_export"/>
		<include circuit="v_tournament" template="custom/dsp_export"/>
	</fuseaction>
	
	<fuseaction access="public" name="rules">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="v_tournament" template="custom/dsp_rules"/>
	</fuseaction>
	
	<fuseaction access="public" name="ranking">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_ranking"/>
	</fuseaction>
	
	<fuseaction access="public" name="ranking_edit">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_ranking_edit"/>
	</fuseaction>
	
	<fuseaction access="public" name="signup">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_signup"/>
		<include circuit="v_tournament" template="custom/dsp_signup"/>
		<include circuit="v_tournament" template="custom/dsp_rules"/>
	</fuseaction>
	
	<fuseaction access="public" name="teams">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_teams"/>
		<include circuit="v_tournament" template="custom/dsp_teams"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_details">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_team_details"/>
		<include circuit="v_tournament" template="custom/dsp_team_details"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_edit">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_team_edit"/>
		<include circuit="v_tournament" template="custom/dsp_team_edit"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_leave">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_team_leave"/>
		<include circuit="v_tournament" template="custom/dsp_team_leave"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_join">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_team_join"/>
		<include circuit="v_tournament" template="custom/dsp_team_join"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_delete">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_team_delete"/>
		<include circuit="v_tournament" template="custom/dsp_team_delete"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_player_change_status">
		<include circuit="tournament" template="custom/act_team_player_change_status"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_player_rearrange_players">
		<include circuit="tournament" template="custom/act_team_player_rearrange_players"/>
	</fuseaction>
	
	<fuseaction access="public" name="team_player_delete">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_team_player_delete"/>
		<include circuit="v_tournament" template="custom/dsp_team_player_delete"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournaments_edit_exportsettings">
		<lanshock:security area="manage"/>
		<include circuit="v_tournament" template="custom/dsp_tournaments_edit_exportsettings"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_changestatus">
		<lanshock:security area="manage"/>
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_tournament_changestatus"/>
		<include circuit="v_tournament" template="custom/dsp_tournament_changestatus"/>
	</fuseaction>
	
	<fuseaction access="public" name="matches">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_matches"/>
	</fuseaction>
	
	<fuseaction access="public" name="matchdetails">
		<include circuit="v_tournament" template="custom/inc_dsp_tournament_header"/>
		<include circuit="tournament" template="custom/act_matchdetails"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_group_listing">
		<lanshock:security area="tournament_group"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_group table. -->
		<set name="request.page.objectName" value="tournament_group"/>
		<set name="request.page.description" value="I display a list of the tournament_group records in the table."/>
		<xfa name="update" value="tournament_group_edit_form"/>
		<xfa name="delete" value="tournament_group_delete"/>
		<xfa name="display" value="tournament_group_display"/>
		<xfa name="add" value="tournament_group_add_form"/>
		<xfa name="grid_json" value="tournament_group_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_group|id|ASC"/>
		
		<set name="fieldlist" value="id,season_id,name,description,maxsignups,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_group"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_group_grid_json">
		<lanshock:security area="tournament_group"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_group"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_group','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_group|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_group_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_group_action_add"/>
		<do action="tournament_group_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_group_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_group_action_update"/>
		<do action="tournament_group_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_group_form">
		<lanshock:security area="tournament_group"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_group_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_group"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_group"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_group.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_group"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_group_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_group_action_add"/>
		<do action="tournament_group_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_group_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_group_action_update"/>
		<do action="tournament_group_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_group_action_save">
		<lanshock:security area="tournament_group"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_group_listing"/>
		<xfa name="cancel" value="tournament_group_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_group"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_group_delete">
		<lanshock:security area="tournament_group"/>
		
		<!-- Delete: I delete the selected tournament_group records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('tournament_group','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_match_listing">
		<lanshock:security area="tournament_match"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_match table. -->
		<set name="request.page.objectName" value="tournament_match"/>
		<set name="request.page.description" value="I display a list of the tournament_match records in the table."/>
		<xfa name="update" value="tournament_match_edit_form"/>
		<xfa name="delete" value="tournament_match_delete"/>
		<xfa name="display" value="tournament_match_display"/>
		<xfa name="add" value="tournament_match_add_form"/>
		<xfa name="grid_json" value="tournament_match_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_match|id|ASC"/>
		
		<set name="fieldlist" value="id,tournamentid,status,row,col,team1,team2,winner,submittedby_userid,submittedby_teamid,submittedby_dt,checkedby_userid,checkedby_teamid,checkedby_dt,checkedby_admin,checkedby_admin_dt,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_match"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_match_grid_json">
		<lanshock:security area="tournament_match"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_match"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_match','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_match|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_match_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_match_action_add"/>
		<do action="tournament_match_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_match_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_match_action_update"/>
		<do action="tournament_match_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_match_form">
		<lanshock:security area="tournament_match"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_match_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_match"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_match"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_match.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_match"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_match_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_match_action_add"/>
		<do action="tournament_match_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_match_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_match_action_update"/>
		<do action="tournament_match_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_match_action_save">
		<lanshock:security area="tournament_match"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_match_listing"/>
		<xfa name="cancel" value="tournament_match_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_match"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_match_delete">
		<lanshock:security area="tournament_match"/>
		
		<!-- Delete: I delete the selected tournament_match records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('tournament_match','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_player_listing">
		<lanshock:security area="tournament_player"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_player table. -->
		<set name="request.page.objectName" value="tournament_player"/>
		<set name="request.page.description" value="I display a list of the tournament_player records in the table."/>
		<xfa name="update" value="tournament_player_edit_form"/>
		<xfa name="delete" value="tournament_player_delete"/>
		<xfa name="display" value="tournament_player_display"/>
		<xfa name="add" value="tournament_player_add_form"/>
		<xfa name="grid_json" value="tournament_player_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_player|id|ASC"/>
		
		<set name="fieldlist" value="id,userid,teamid,status,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_player"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_player_grid_json">
		<lanshock:security area="tournament_player"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_player"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_player','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_player|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_player_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_player_action_add"/>
		<do action="tournament_player_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_player_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_player_action_update"/>
		<do action="tournament_player_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_player_form">
		<lanshock:security area="tournament_player"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_player_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_player"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_player"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_player.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_player"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_player_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_player_action_add"/>
		<do action="tournament_player_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_player_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_player_action_update"/>
		<do action="tournament_player_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_player_action_save">
		<lanshock:security area="tournament_player"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_player_listing"/>
		<xfa name="cancel" value="tournament_player_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_player"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_player_delete">
		<lanshock:security area="tournament_player"/>
		
		<!-- Delete: I delete the selected tournament_player records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('tournament_player','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_ranking_listing">
		<lanshock:security area="tournament_ranking"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_ranking table. -->
		<set name="request.page.objectName" value="tournament_ranking"/>
		<set name="request.page.description" value="I display a list of the tournament_ranking records in the table."/>
		<xfa name="update" value="tournament_ranking_edit_form"/>
		<xfa name="delete" value="tournament_ranking_delete"/>
		<xfa name="display" value="tournament_ranking_display"/>
		<xfa name="add" value="tournament_ranking_add_form"/>
		<xfa name="grid_json" value="tournament_ranking_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_ranking|id|ASC"/>
		
		<set name="fieldlist" value="id,tournamentid,teamid,pos,stats_win,stats_lose,points_win,points_lose,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_ranking"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_ranking_grid_json">
		<lanshock:security area="tournament_ranking"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_ranking"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_ranking','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_ranking|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_ranking_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_ranking_action_add"/>
		<do action="tournament_ranking_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_ranking_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_ranking_action_update"/>
		<do action="tournament_ranking_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_ranking_form">
		<lanshock:security area="tournament_ranking"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_ranking_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_ranking"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_ranking"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_ranking.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_ranking"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_ranking_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_ranking_action_add"/>
		<do action="tournament_ranking_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_ranking_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_ranking_action_update"/>
		<do action="tournament_ranking_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_ranking_action_save">
		<lanshock:security area="tournament_ranking"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_ranking_listing"/>
		<xfa name="cancel" value="tournament_ranking_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_ranking"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_ranking_delete">
		<lanshock:security area="tournament_ranking"/>
		
		<!-- Delete: I delete the selected tournament_ranking records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('tournament_ranking','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_result_listing">
		<lanshock:security area="tournament_result"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_result table. -->
		<set name="request.page.objectName" value="tournament_result"/>
		<set name="request.page.description" value="I display a list of the tournament_result records in the table."/>
		<xfa name="update" value="tournament_result_edit_form"/>
		<xfa name="delete" value="tournament_result_delete"/>
		<xfa name="display" value="tournament_result_display"/>
		<xfa name="add" value="tournament_result_add_form"/>
		<xfa name="grid_json" value="tournament_result_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_result|id|ASC"/>
		
		<set name="fieldlist" value="id,matchid,team1_result,team2_result,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_result"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_result_grid_json">
		<lanshock:security area="tournament_result"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_result"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_result','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_result|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_result_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_result_action_add"/>
		<do action="tournament_result_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_result_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_result_action_update"/>
		<do action="tournament_result_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_result_form">
		<lanshock:security area="tournament_result"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_result_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_result"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_result"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_result.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_result"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_result_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_result_action_add"/>
		<do action="tournament_result_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_result_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_result_action_update"/>
		<do action="tournament_result_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_result_action_save">
		<lanshock:security area="tournament_result"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_result_listing"/>
		<xfa name="cancel" value="tournament_result_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_result"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_result_delete">
		<lanshock:security area="tournament_result"/>
		
		<!-- Delete: I delete the selected tournament_result records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('tournament_result','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_season_listing">
		<lanshock:security area="tournament_season"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_season table. -->
		<set name="request.page.objectName" value="tournament_season"/>
		<set name="request.page.description" value="I display a list of the tournament_season records in the table."/>
		<xfa name="update" value="tournament_season_edit_form"/>
		<xfa name="delete" value="tournament_season_delete"/>
		<xfa name="display" value="tournament_season_display"/>
		<xfa name="add" value="tournament_season_add_form"/>
		<xfa name="grid_json" value="tournament_season_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_season|id|ASC"/>
		
		<set name="fieldlist" value="id,name,description,event_id,player_coins,dt_start,dt_end,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_season"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_season_grid_json">
		<lanshock:security area="tournament_season"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_season"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_season','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_season|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_season_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_season_action_add"/>
		<do action="tournament_season_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_season_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_season_action_update"/>
		<do action="tournament_season_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_season_form">
		<lanshock:security area="tournament_season"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_season_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_season"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_season"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_season.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_season"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_season_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_season_action_add"/>
		<do action="tournament_season_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_season_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_season_action_update"/>
		<do action="tournament_season_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_season_action_save">
		<lanshock:security area="tournament_season"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_season_listing"/>
		<xfa name="cancel" value="tournament_season_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_season"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_season_delete">
		<lanshock:security area="tournament_season"/>
		
		<!-- Delete: I delete the selected tournament_season records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('tournament_season','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_team_listing">
		<lanshock:security area="tournament_team"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_team table. -->
		<set name="request.page.objectName" value="tournament_team"/>
		<set name="request.page.description" value="I display a list of the tournament_team records in the table."/>
		<xfa name="update" value="tournament_team_edit_form"/>
		<xfa name="delete" value="tournament_team_delete"/>
		<xfa name="display" value="tournament_team_display"/>
		<xfa name="add" value="tournament_team_add_form"/>
		<xfa name="grid_json" value="tournament_team_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_team|id|ASC"/>
		
		<set name="fieldlist" value="id,name,tournamentid,leaderid,autoacceptids,leagueid,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_team"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_team_grid_json">
		<lanshock:security area="tournament_team"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_team"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_team','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_team|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_team_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_team_action_add"/>
		<do action="tournament_team_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_team_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_team_action_update"/>
		<do action="tournament_team_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_team_form">
		<lanshock:security area="tournament_team"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_team_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_team"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_team"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_team.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_team"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_team_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_team_action_add"/>
		<do action="tournament_team_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_team_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_team_action_update"/>
		<do action="tournament_team_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_team_action_save">
		<lanshock:security area="tournament_team"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_team_listing"/>
		<xfa name="cancel" value="tournament_team_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_team"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_team_delete">
		<lanshock:security area="tournament_team"/>
		
		<!-- Delete: I delete the selected tournament_team records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('tournament_team','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_tournament_listing">
		<lanshock:security area="tournament_tournament"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the tournament_tournament table. -->
		<set name="request.page.objectName" value="tournament_tournament"/>
		<set name="request.page.description" value="I display a list of the tournament_tournament records in the table."/>
		<xfa name="update" value="tournament_tournament_edit_form"/>
		<xfa name="delete" value="tournament_tournament_delete"/>
		<xfa name="display" value="tournament_tournament_display"/>
		<xfa name="add" value="tournament_tournament_add_form"/>
		<xfa name="grid_json" value="tournament_tournament_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="tournament_tournament|id|ASC"/>
		
		<set name="fieldlist" value="id,name,type,export_league,export_league_data,status,groupid,maxteams,teamsize,teamsubstitute,rulefile,image,coins,starttime,endtime,pausetime,matchtime,matchcount,timetable_color,ladminids,infotext,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="list/dsp_list_tournament_tournament"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="tournament_tournament_grid_json">
		<lanshock:security area="tournament_tournament"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="tournament" template="list/act_json_filter_tournament_tournament"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('tournament_tournament','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="tournament_tournament|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_tournament_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_tournament_action_add"/>
		<do action="tournament_tournament_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_tournament_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_tournament_action_update"/>
		<do action="tournament_tournament_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_tournament_form">
		<lanshock:security area="tournament_tournament"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="tournament_tournament_listing"/>
		
		<include circuit="tournament" template="form/act_form_tournament_tournament"/>
		
		<include circuit="tournament" template="form/act_form_loadrelated_tournament_tournament"/>
		
		<!-- snippet 'modules/tournament/controller/form/snippets/act_form_loadrelated_custom_tournament_tournament.cfm' -->
		
			<include circuit="tournament" template="form/snippets/act_form_loadrelated_custom_tournament_tournament"/>
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_tournament" template="form/dsp_form_tournament_tournament"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_tournament_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="tournament_tournament_action_add"/>
		<do action="tournament_tournament_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="tournament_tournament_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="tournament_tournament_action_update"/>
		<do action="tournament_tournament_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="tournament_tournament_action_save">
		<lanshock:security area="tournament_tournament"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="tournament_tournament_listing"/>
		<xfa name="cancel" value="tournament_tournament_listing"/>
		<include circuit="tournament" template="form/act_action_save_tournament_tournament"/>
	</fuseaction>
	<fuseaction name="tournament_tournament_delete" access="public">
		<lanshock:security area="tournament_tournament"/>
		
		<!-- Delete: I delete the selected tournament_tournament records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none" />
		
		<invoke object="application.lanshock.oFactory.load('tournament_tournament','reactorGateway')" method="deleteByIDlist" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#" />
		</invoke>
	</fuseaction>
</circuit>
