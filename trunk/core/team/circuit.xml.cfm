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

	<fuseaction name="main">
		<do action="details"/>
	</fuseaction>
	
	<!-- Show Teamdetails -->
	<fuseaction name="details">
		<include template="act_details.cfm"/>
		<include template="dsp_details.cfm"/>
	</fuseaction>
	
	<!-- Edit Teamdetails -->
	<fuseaction name="details_edit">
		<include template="act_details_edit.cfm"/>
		<include template="dsp_details_edit.cfm"/>
	</fuseaction>
	
	<!-- Edit Teammembers -->
	<fuseaction name="members_edit">
		<include template="act_members_edit.cfm"/>
		<include template="dsp_members_edit.cfm"/>
	</fuseaction>
	
	<!-- Show Teamlist -->
	<fuseaction name="list">
		<include template="act_list.cfm"/>
		<include template="dsp_list.cfm"/>
	</fuseaction>
	
	<!-- Join Team -->
	<fuseaction name="join">
		<include template="act_join.cfm"/>
	</fuseaction>
	
	<!-- Leave Team -->
	<fuseaction name="leave">
		<include template="act_leave.cfm"/>
	</fuseaction>
	
</circuit>