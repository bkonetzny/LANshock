<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL$
$LastChangedDate$
$LastChangedBy$
$LastChangedRevision$
-->

<circuit access="public">
	
	<prefuseaction>
		<include template="layoutHeader.cfm"/>
	</prefuseaction>
	
	<postfuseaction>
		<include template="layoutFooter.cfm"/>
	</postfuseaction>
	
	<fuseaction name="main"/>
	
	<fuseaction name="login">
		<set name="ShowLayout" value="none"/>
		<include template="act_login.cfm"/>
		<include template="dsp_login.cfm"/>
	</fuseaction>
	
	<fuseaction name="logout">
		<set name="ShowLayout" value="none"/>
		<include template="act_logout.cfm"/>
	</fuseaction>
	
	<fuseaction name="setpassword">
		<set name="ShowLayout" value="none"/>
		<include template="act_setpassword.cfm"/>
		<include template="dsp_setpassword.cfm"/>
	</fuseaction>
	
	<fuseaction name="config">
		<set name="ShowLayout" value="none"/>
		<include template="act_config.cfm"/>
		<include template="dsp_config.cfm"/>
	</fuseaction>

	<fuseaction name="rootuser">
		<set name="ShowLayout" value="none"/>
		<include template="act_rootuser.cfm"/>
		<include template="dsp_rootuser.cfm"/>
	</fuseaction>

	<fuseaction name="viewapp">
		<set name="ShowLayout" value="none"/>
		<include template="dsp_viewapp.cfm"/>
	</fuseaction>

</circuit>