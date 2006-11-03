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

<circuit access="public" xmlns:customattributes="customattributes/">

	<!-- Show Groups and Boards -->
	<fuseaction name="overview">
		<include template="act_overview.cfm"/>
		<include template="dsp_overview.cfm"/>
	</fuseaction>

	<!-- Copy of 'overview' -->
	<fuseaction name="main">
		<include template="act_overview.cfm"/>
		<include template="dsp_overview.cfm"/>
	</fuseaction>

	<!-- Show Board -->
	<fuseaction name="board">
		<include template="act_board.cfm"/>
		<include template="dsp_board.cfm"/>
	</fuseaction>

	<!-- Show Topic -->
	<fuseaction name="topic">
		<include template="act_topic.cfm"/>
		<include template="dsp_topic.cfm"/>
	</fuseaction>

	<!-- Show Topic Edit -->
	<fuseaction name="post">
		<include template="act_post.cfm"/>
		<include template="dsp_post.cfm"/>
	</fuseaction>

	<!-- Show Group Edit -->
	<fuseaction name="group_edit">
		<set name="check" value="#UDF_SecurityCheck(area='group')#"/>
		<include template="act_group_edit.cfm"/>
		<include template="dsp_group_edit.cfm"/>
	</fuseaction>

	<!-- Show Board Edit -->
	<fuseaction name="board_edit">
		<set name="check" value="#UDF_SecurityCheck(area='board')#"/>
		<include template="act_board_edit.cfm"/>
		<include template="dsp_board_edit.cfm"/>
	</fuseaction>

	<!-- Show Search -->
	<fuseaction name="search">
		<include template="act_search.cfm"/>
		<include template="dsp_search.cfm"/>
	</fuseaction>

	<!-- Show RSS -->
	<fuseaction name="rss" customattributes:showlayout="none">
		<include template="act_rss.cfm"/>
		<include template="dsp_rss.cfm"/>
	</fuseaction>

	<!-- Cron -->
	<fuseaction name="cron_monitoring" customattributes:showlayout="none">
		<include template="act_cron_monitoring.cfm"/>
	</fuseaction>

</circuit>