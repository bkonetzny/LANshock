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
	
	<prefuseaction>
		<include template="layoutHeader.cfm"/>
	</prefuseaction>
	
	<postfuseaction>
		<include template="layoutFooter.cfm"/>
	</postfuseaction>
	
	<fuseaction name="main"/>
	
	<fuseaction name="login" customattributes:showlayout="none">
		<include template="act_login.cfm"/>
		<include template="dsp_login.cfm"/>
	</fuseaction>
	
	<fuseaction name="logout" customattributes:showlayout="none">
		<include template="act_logout.cfm"/>
	</fuseaction>
	
	<fuseaction name="setpassword" customattributes:showlayout="none">
		<include template="act_setpassword.cfm"/>
		<include template="dsp_setpassword.cfm"/>
	</fuseaction>
	
	<fuseaction name="config" customattributes:showlayout="none">
		<include template="act_config.cfm"/>
		<include template="dsp_config.cfm"/>
	</fuseaction>

	<fuseaction name="rootuser" customattributes:showlayout="none">
		<include template="act_rootuser.cfm"/>
		<include template="dsp_rootuser.cfm"/>
	</fuseaction>

	<fuseaction name="viewapp" customattributes:showlayout="none">
		<include template="dsp_viewapp.cfm"/>
	</fuseaction>

</circuit>