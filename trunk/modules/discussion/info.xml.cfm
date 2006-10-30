<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="Discussion Board" version="0.2.0.1" date="2006-04-05" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="search"/>
		<item action="group_edit" reqstatus="admin"/>
		<item action="board_edit" reqstatus="admin"/>
	</navigation>
	
	<security>
		<area name="group"/>
		<area name="board"/>
	</security>
	
	<cron>
		<task action="cron_monitoring_daily" run="0 0 * * *"/>
		<task action="cron_monitoring_weekly" run="0 0 * * 0"/>
	</cron>
	
	<database>
		<table name="discussion_board">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="group_id" type="integer" len="10" null="false" default="0"/>
			<field name="title" type="varchar" len="255" default="NULL"/>
			<field name="subtitle" type="varchar" len="255" default="NULL"/>
			<index name="id" value=""/>
		</table>
		<table name="discussion_group">
			<field name="id" type="integer" len="11" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" default="NULL"/>
			<index name="id" value=""/>
		</table>
	</database>

</module>