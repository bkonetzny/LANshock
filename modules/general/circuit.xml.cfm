<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/general/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit access="public" xmlns:lanshock="lanshock/">
	
	<fuseaction name="main">
		<do action="welcome"/>
	</fuseaction>
	
	<fuseaction name="info">
		<include template="dsp_info.cfm"/>
	</fuseaction>
	
	<fuseaction name="welcome">
		<include template="dsp_welcome.cfm"/>
	</fuseaction>
	
	<fuseaction name="http404">
		<include template="dsp_http404.cfm"/>
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
	
	<fuseaction name="online">
		<include template="act_online.cfm"/>
		<include template="dsp_online.cfm"/>
	</fuseaction>
	
	<fuseaction name="language">
		<include template="dsp_language.cfm"/>
	</fuseaction>
	
	<fuseaction name="session_language">
		<include template="act_session_language.cfm"/>
	</fuseaction>
	
	<fuseaction name="lanshock_code">
		<include template="dsp_lanshock_code.cfm"/>
	</fuseaction>
	
	<fuseaction name="lanshock_code_popup" lanshock:showlayout="basic">
		<include template="dsp_lanshock_code.cfm"/>
	</fuseaction>

</circuit>