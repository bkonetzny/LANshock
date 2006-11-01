<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="Tournament System" version="0.7.0.1" date="2006-04-05" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="tournaments"/>
		<item action="timetable"/>
		<item action="rankings"/>
		<item action="mytournaments" reqstatus="loggedin"/>
		<item action="groups_edit" reqstatus="admin"/>
		<item action="tournaments_edit" reqstatus="admin"/>
		<item action="management" reqstatus="admin"/>
		<item action="export" reqstatus="admin"/>
	</navigation>
	
	<security>
		<area name="manage"/>
		<area name="export"/>
	</security>
	
	<database>
		<table name="t2k4_groups">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="description" type="text" null="false" default=""/>
			<field name="maxsignups" type="integer" len="11" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_players">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="userid" type="integer" len="10" null="false" default="0"/>
			<field name="teamid" type="integer" len="10" null="false" default="0"/>
			<field name="status" type="varchar" len="255" null="false" default=""/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_teams">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="tournamentid" type="integer" len="10" null="false" default="0"/>
			<field name="leaderid" type="integer" len="10" null="false" default="0"/>
			<field name="autoacceptids" type="text" default=""/>
			<field name="leagueid" type="varchar" len="255" null="false" default=""/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_tournaments">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<field name="type" type="varchar" len="255" null="false" default=""/>
			<field name="export_league" type="varchar" len="255" null="false" default=""/>
			<field name="export_league_data" type="varchar" len="255" null="false" default=""/>
			<field name="status" type="varchar" len="255" null="false" default="signup"/>
			<field name="groupid" type="integer" len="10" null="false" default="0"/>
			<field name="maxteams" type="integer" len="10" null="false" default="0"/>
			<field name="teamsize" type="integer" len="10" null="false" default="0"/>
			<field name="teamsubstitute" type="integer" len="10" null="false" default="0"/>
			<field name="rulefile" type="varchar" len="255" null="false" default=""/>
			<field name="image" type="varchar" len="255" null="false" default=""/>
			<field name="coins" type="integer" len="11" null="false" default="0"/>
			<field name="starttime" type="datetime" null="false" default="0000-00-00 00:00:00"/>
			<field name="endtime" type="datetime" null="false" default="0000-00-00 00:00:00"/>
			<field name="pausetime" type="integer" len="10" null="false" default="0"/>
			<field name="matchtime" type="integer" len="10" null="false" default="0"/>
			<field name="matchcount" type="integer" len="10" null="false" default="0"/>
			<field name="timetable_color" type="varchar" len="20" null="false" default=""/>
			<field name="ladminids" type="varchar" len="255" null="false" default=""/>
			<field name="infotext" type="text" null="false" default=""/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_se_matches">
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
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_se_results">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="matchid" type="integer" len="10" null="false" default="0"/>
			<field name="team1_result" type="integer" len="10" null="false" default="0"/>
			<field name="team2_result" type="integer" len="10" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_se_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_de_matches">
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
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_de_results">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="matchid" type="integer" len="10" null="false" default="0"/>
			<field name="team1_result" type="integer" len="10" null="false" default="0"/>
			<field name="team2_result" type="integer" len="10" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_de_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_group_matches">
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
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_group_groups">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="10" null="false" default="0"/>
			<field name="name" type="varchar" len="255" null="false" default=""/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_group_groups_teams">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="groupid" type="integer" len="10" null="false" default="0"/>
			<field name="teamid" type="integer" len="10" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_group_results">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="matchid" type="integer" len="10" null="false" default="0"/>
			<field name="team1_result" type="integer" len="10" null="false" default="0"/>
			<field name="team2_result" type="integer" len="10" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_group_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
		<table name="t2k4_type_customranking_ranking">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="tournamentid" type="integer" len="11" null="false" default="0"/>
			<field name="teamid" type="integer" len="11" null="false" default="0"/>
			<field name="pos" type="integer" len="11" null="false" default="0"/>
			<index name="id" value=""/>
		</table>
	</database>

</module>