<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/installer/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit access="public" xmlns:lanshock="lanshock/">
	
	<prefuseaction>
		<include template="layoutHeader.cfm"/>
	</prefuseaction>
	
	<postfuseaction>
		<include template="layoutFooter.cfm"/>
	</postfuseaction>
	
	<fuseaction name="main" lanshock:showlayout="none">
		<include template="act_main.cfm"/>
		<include template="dsp_main.cfm"/>
	</fuseaction>
	
	<fuseaction name="login" lanshock:showlayout="none">
		<include template="act_login.cfm"/>
		<include template="dsp_login.cfm"/>
	</fuseaction>
	
	<fuseaction name="logout" lanshock:showlayout="none">
		<include template="act_logout.cfm"/>
	</fuseaction>
	
	<fuseaction name="setpassword" lanshock:showlayout="none">
		<include template="act_setpassword.cfm"/>
		<include template="dsp_setpassword.cfm"/>
	</fuseaction>

</circuit>