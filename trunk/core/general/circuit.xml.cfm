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
	
	<fuseaction name="main">
		<do action="welcome"/>
	</fuseaction>
	
	<fuseaction name="info">
		<include template="dsp_info.cfm"/>
	</fuseaction>
	
	<fuseaction name="welcome">
		<include template="dsp_welcome.cfm"/>
	</fuseaction>
	
	<fuseaction name="error">
		<include template="dsp_error.cfm"/>
	</fuseaction>
	
	<fuseaction name="error_access_denied">
		<include template="dsp_error_access_denied.cfm"/>
	</fuseaction>
	
	<fuseaction name="error_session_hijack">
		<include template="dsp_error_session_hijack.cfm"/>
	</fuseaction>

	<fuseaction name="noright">
		<include template="dsp_error_noright.cfm"/>
	</fuseaction>

	<fuseaction name="panel" customattributes:showlayout="basic">
		<include template="act_panel.cfm"/>
		<include template="dsp_panel.cfm"/>
	</fuseaction>
	
	<fuseaction name="online">
		<include template="act_online.cfm"/>
		<include template="dsp_online.cfm"/>
	</fuseaction>
	
	<fuseaction name="language">
		<include template="dsp_language.cfm"/>
	</fuseaction>
	
	<fuseaction name="lanshock_code">
		<include template="dsp_lanshock_code.cfm"/>
	</fuseaction>
	
	<fuseaction name="lanshock_code_popup" customattributes:showlayout="basic">
		<include template="dsp_lanshock_code.cfm"/>
	</fuseaction>

</circuit>