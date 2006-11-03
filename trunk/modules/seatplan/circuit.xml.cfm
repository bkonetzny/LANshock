<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public">

	<!-- default / mainpage -->
	<fuseaction name="main">
		<include template="act_seatplan.cfm"/>
		<include template="dsp_seatplan.cfm"/>
	</fuseaction>

	<!-- locate to main action -->
	<fuseaction name="seatplan">
		<include template="act_seatplan.cfm"/>
		<include template="dsp_seatplan.cfm"/>
	</fuseaction>

	<!-- roomlist -->
	<fuseaction name="roomlist">
		<include template="act_roomlist.cfm"/>
		<include template="dsp_roomlist.cfm"/>
	</fuseaction>

	<!-- reserve a seat -->
	<fuseaction name="seat_reserve">
		<include template="act_seat_reserve.cfm"/>
	</fuseaction>

	<!-- release a seat -->
	<fuseaction name="seat_release">
		<include template="act_seat_release.cfm"/>
	</fuseaction>

	<!-- create room -->
	<fuseaction name="room_create">
		<set name="check" value="#UDF_SecurityCheck(area='room_edit')#"/>
		<include template="act_room_create.cfm"/>
		<include template="dsp_room_create.cfm"/>
	</fuseaction>

	<!-- edit room -->
	<fuseaction name="room_structure_edit">
		<set name="check" value="#UDF_SecurityCheck(area='room_edit')#"/>
		<include template="act_room_structure_edit.cfm"/>
		<include template="dsp_room_structure_edit.cfm"/>
	</fuseaction>

	<!-- change room structure -->
	<fuseaction name="room_changeStructure">
		<set name="check" value="#UDF_SecurityCheck(area='room_edit')#"/>
		<include template="act_room_changestructure.cfm"/>
	</fuseaction>

	<!-- delete room -->
	<fuseaction name="room_delete">
		<set name="check" value="#UDF_SecurityCheck(area='room_delete')#"/>
		<include template="act_room_delete.cfm"/>
	</fuseaction>

</circuit>