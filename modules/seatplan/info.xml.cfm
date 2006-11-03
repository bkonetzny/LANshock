<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<module name="Seatplan" version="1.3.0.0" date="2005-08-19" author="LANshock" url="http://www.lanshock.com">
	
	<general requiresLogin="false"/>
	
	<license>
		<license type="gpl"/>
	</license>
	
	<navigation>
		<item action="roomlist" reqstatus="admin"/>
	</navigation>
	
	<security>
		<area name="room_edit"/>
		<area name="room_delete"/>
		<area name="set_user_seat"/>
	</security>
	
	<database>
		<table name="seatplan_location_data">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="name" type="varchar" len="255" default=""/>
			<field name="rows" type="integer" len="10" default="0"/>
			<field name="cols" type="integer" len="10" default="0"/>
			<field name="labels_x" type="text" null="false" default=""/>
			<field name="labels_y" type="text" null="false" default=""/>
			<index name="id" value=""/>
		</table>
		<table name="seatplan_location_elements">
			<field name="id" type="integer" len="10" null="false" special="auto_increment"/>
			<field name="block" type="integer" len="10" null="false" default="0"/>
			<field name="col" type="integer" len="10" null="false" default="0"/>
			<field name="row" type="integer" len="10" null="false" default="0"/>
			<field name="status" type="integer" len="10" null="false" default="0"/>
			<field name="guest" type="integer" len="10" default="0"/>
			<field name="image" type="varchar" len="255" default=""/>
			<field name="type" type="varchar" len="255" default=""/>
			<index name="id" value=""/>
		</table>
	</database>

</module>