<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)
$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->
<module name="Tournament System" version="2.0.0.0" date="2008-07-22" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="tournaments"/>
		<item action="timetable"/>
		<!-- <item action="rankings"/>
		<item action="mytournaments"/> -->
		<item action="management" permissions="manage"/>
		<item action="export" permissions="export"/>
		<item action="tournament_season_listing" permissions="tournament_season"/>
		<item action="tournament_group_listing" permissions="tournament_group"/>
		<item action="tournament_team_listing" permissions="tournament_team"/>
		<item action="tournament_player_listing" permissions="tournament_player"/>
		<item action="tournament_tournament_listing" permissions="tournament_tournament"/>
		<!-- <item action="tournament_type_se_match_listing" permissions="tournament_type_se_match"/>
		<item action="tournament_type_se_result_listing" permissions="tournament_type_se_result"/>
		<item action="tournament_type_se_ranking_listing" permissions="tournament_type_se_ranking"/> -->
	</navigation>
	
	<security>
		<permissions list="manage,export,tournament_season,tournament_group,tournament_team,tournament_player,tournament_tournament"/> <!-- tournament_type_se_match,tournament_type_se_result,tournament_type_se_ranking -->
		<role name="Tournament Admin" permissions="manage,export,tournament_season,tournament_group,tournament_team,tournament_player,tournament_tournament"/>
		<role name="Tournament Match-Admin" permissions="manage,export"/>
	</security>
	
	<database>
		<table name="tournament_season">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="description" type="text" null="false" default=""/>
			<field name="event_id" type="integer" len="11" null="true" default="NULL"/>
			<field name="player_coins" type="integer" len="11" null="true" default="NULL"/>
			<field name="dt_start" type="datetime" null="true" default="NULL"/>
			<field name="dt_end" type="datetime" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="event_id" type="manyToOne" mapping="event_events.id"/>
		</table>
		<table name="tournament_group">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="season_id" type="integer" len="10" null="true" default="NULL"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="description" type="text" null="false" default=""/>
			<field name="maxsignups" type="integer" len="11" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="season_id" type="manyToOne" mapping="tournament_season.id"/>
		</table>
		<table name="tournament_tournament">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="type" type="varchar" len="255" null="false" default=""/>
			<field name="export_league" type="varchar" len="255" null="true" default="NULL"/>
			<field name="export_league_data" type="varchar" len="255" null="true" default="NULL"/>
			<field name="status" type="varchar" len="255" null="false" default="signup"/>
			<field name="groupid" type="integer" len="10" null="false" default="0"/>
			<field name="maxteams" type="integer" len="10" null="false" default="0"/>
			<field name="teamsize" type="integer" len="10" null="false" default="0"/>
			<field name="teamsubstitute" type="integer" len="10" null="false" default="0"/>
			<field name="rulefile" type="varchar" len="255" null="false" default=""/>
			<field name="image" type="varchar" len="255" null="false" default=""/>
			<field name="coins" type="integer" len="11" null="false" default="0"/>
			<field name="starttime" type="datetime" null="true" default="NULL"/>
			<field name="endtime" type="datetime" null="true" default="NULL"/>
			<field name="pausetime" type="integer" len="10" null="false" default="0"/>
			<field name="matchtime" type="integer" len="10" null="false" default="0"/>
			<field name="matchcount" type="integer" len="10" null="false" default="0"/>
			<field name="timetable_color" type="varchar" len="20" null="false" default=""/>
			<field name="ladminids" type="varchar" len="255" null="true" default="NULL"/>
			<field name="infotext" type="text" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="groupid" type="manyToOne" mapping="tournament_group.id"/>
		</table>
		<table name="tournament_team">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="tournamentid" type="integer" len="10" null="false" default="0"/>
			<field name="leaderid" type="integer" len="10" null="false" default="0"/>
			<field name="autoacceptids" type="varchar" len="255" null="true" default="NULL"/>
			<field name="leagueid" type="varchar" len="255" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="tournamentid" type="manyToOne" mapping="tournament_tournament.id"/>
			<fk field="leaderid" type="manyToOne" mapping="user.id"/>
		</table>
		<table name="tournament_player">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="userid" type="integer" len="10" null="false" default="0"/>
			<field name="teamid" type="integer" len="10" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="teamid" type="manyToOne" mapping="tournament_team.id"/>
			<fk field="userid" type="manyToOne" mapping="user.id"/>
		</table>
		<table name="tournament_type_se_match">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="10" null="true" default="NULL"/>
			<field name="status" type="varchar" len="255" null="true" default="NULL"/>
			<field name="row" type="integer" len="10" null="true" default="NULL"/>
			<field name="col" type="integer" len="10" null="true" default="NULL"/>
			<field name="team1" type="integer" len="10" null="true" default="NULL"/>
			<field name="team2" type="integer" len="10" null="true" default="NULL"/>
			<field name="winner" type="varchar" len="255" null="true" default="NULL"/>
			<field name="submittedby_userid" type="integer" len="10" null="true" default="NULL"/>
			<field name="submittedby_teamid" type="integer" len="10" null="true" default="NULL"/>
			<field name="submittedby_dt" type="datetime" null="true" default="NULL"/>
			<field name="checkedby_userid" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_teamid" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_dt" type="datetime" null="true" default="NULL"/>
			<field name="checkedby_admin" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_admin_dt" type="datetime" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
			<fk field="team1" mapping="tournament_teams.id"/>
			<fk field="team2" mapping="tournament_teams.id"/>
			<fk field="submittedby_userid" mapping="user.id"/>
			<fk field="submittedby_teamid" mapping="tournament_teams.id"/>
			<fk field="checkedby_userid" mapping="user.id"/>
			<fk field="checkedby_teamid" mapping="tournament_teams.id"/>
			<fk field="checkedby_admin" mapping="user.id"/>
		</table>
		<table name="tournament_type_se_result">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="matchid" type="integer" len="10" null="false" default="0"/>
			<field name="team1_result" type="integer" len="10" null="false" default="0"/>
			<field name="team2_result" type="integer" len="10" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="matchid" mapping="tournament_type_se_matches.id"/>
		</table>
		<table name="tournament_type_se_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
			<fk field="teamid" mapping="tournament_teams.id"/>
			<index name="IDX_pos" fields="pos"/>
		</table>
		<!-- 
		<table name="tournament_type_de_matches">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="10" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="false" default=""/>
			<field name="row" type="integer" len="10" null="false" default="0"/>
			<field name="col" type="integer" len="10" null="false" default="0"/>
			<field name="team1" type="integer" len="10" null="false" default="0"/>
			<field name="team2" type="integer" len="10" null="false" default="0"/>
			<field name="winner" type="varchar" len="255" null="false" default=""/>
			<field name="submittedby_userid" type="integer" len="10" null="true" default="NULL"/>
			<field name="submittedby_teamid" type="integer" len="10" null="true" default="NULL"/>
			<field name="submittedby_dt" type="datetime" null="true" default="NULL"/>
			<field name="checkedby_userid" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_teamid" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_dt" type="datetime" null="true" default="NULL"/>
			<field name="checkedby_admin" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_admin_dt" type="datetime" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
			<fk field="team1" mapping="tournament_teams.id"/>
			<fk field="team2" mapping="tournament_teams.id"/>
			<fk field="submittedby_userid" mapping="user.id"/>
			<fk field="submittedby_teamid" mapping="tournament_teams.id"/>
			<fk field="checkedby_userid" mapping="user.id"/>
			<fk field="checkedby_teamid" mapping="tournament_teams.id"/>
			<fk field="checkedby_admin" mapping="user.id"/>
		</table>
		<table name="tournament_type_de_results">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="matchid" type="integer" len="10" null="false" default="0"/>
			<field name="team1_result" type="integer" len="10" null="false" default="0"/>
			<field name="team2_result" type="integer" len="10" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="matchid" mapping="tournament_type_de_matches.id"/>
		</table>
		<table name="tournament_type_de_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
			<fk field="teamid" mapping="tournament_teams.id"/>
			<index name="IDX_pos" fields="pos"/>
		</table>
		<table name="tournament_type_group_matches">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="10" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="false" default=""/>
			<field name="row" type="integer" len="10" null="false" default="0"/>
			<field name="col" type="integer" len="10" null="false" default="0"/>
			<field name="team1" type="integer" len="10" null="false" default="0"/>
			<field name="team2" type="integer" len="10" null="false" default="0"/>
			<field name="winner" type="varchar" len="255" null="false" default=""/>
			<field name="submittedby_userid" type="integer" len="10" null="true" default="NULL"/>
			<field name="submittedby_teamid" type="integer" len="10" null="true" default="NULL"/>
			<field name="submittedby_dt" type="datetime" null="true" default="NULL"/>
			<field name="checkedby_userid" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_teamid" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_dt" type="datetime" null="true" default="NULL"/>
			<field name="checkedby_admin" type="integer" len="10" null="true" default="NULL"/>
			<field name="checkedby_admin_dt" type="datetime" null="true" default="NULL"/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
			<fk field="team1" mapping="tournament_teams.id"/>
			<fk field="team2" mapping="tournament_teams.id"/>
			<fk field="submittedby_userid" mapping="user.id"/>
			<fk field="submittedby_teamid" mapping="tournament_teams.id"/>
			<fk field="checkedby_userid" mapping="user.id"/>
			<fk field="checkedby_teamid" mapping="tournament_teams.id"/>
			<fk field="checkedby_admin" mapping="user.id"/>
		</table>
		<table name="tournament_type_group_groups">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="10" null="false" default="0"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
		</table>
		<table name="tournament_type_group_groups_teams">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="groupid" type="integer" len="10" null="false" default="0"/>
			<field name="teamid" type="integer" len="10" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="groupid" mapping="tournament_type_group_groups.id"/>
			<fk field="teamid" mapping="tournament_teams.id"/>
		</table>
		<table name="tournament_type_group_results">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="matchid" type="integer" len="10" null="false" default="0"/>
			<field name="team1_result" type="integer" len="10" null="false" default="0"/>
			<field name="team2_result" type="integer" len="10" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="matchid" mapping="tournament_type_group_matches.id"/>
		</table>
		<table name="tournament_type_group_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
			<fk field="teamid" mapping="tournament_teams.id"/>
			<index name="IDX_pos" fields="pos"/>
		</table>
		<table name="tournament_type_customranking_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<pk fields="id"/>
			<fk field="tournamentid" mapping="tournament_tournaments.id"/>
			<fk field="teamid" mapping="tournament_teams.id"/>
			<index name="IDX_pos" fields="pos"/>
		</table>
		-->
	</database>
	
	<special>
		<reactor>
			<table name="tournament_group">
				<![CDATA[
				    <hasOne name="tournament_season">
				        <relate from="season_id" to="id"/>
				    </hasOne>
				]]>
			</table>
		</reactor>
		<scaffolding>
			<table name="tournament_season">
				<list fields="id,name,event_id,dt_start,dt_end" sortDefault="name ASC"/>
				<form>
					<field name="description" formType="FckEditor"/>
				</form>
			</table>
			<table name="tournament_group">
				<list fields="id,name,season_id,maxsignups" sortDefault="name ASC"/>
				<form>
					<field name="description" formType="FckEditor"/>
				</form>
			</table>
			<table name="tournament_tournament">
				<list fields="id,name,type,status,starttime" sortDefault="name ASC"/>
				<form>
					<field name="type" formType="Select"/>
					<field name="status" formType="Select"/>
					<field name="image" formType="Select"/>
					<field name="rulefile" formType="Select"/>
					<field name="timetable_color" formType="Select"/>
					<field name="infotext" formType="FckEditor"/>
				</form>
			</table>
			<table name="tournament_team">
				<list fields="id,name,tournamentid,leaderid" sortDefault="name ASC"/>
			</table>
		</scaffolding>
	</special>
</module>