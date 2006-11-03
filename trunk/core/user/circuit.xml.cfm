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
		<do action="userdetails"/>
	</fuseaction>
	
	<fuseaction name="login">
		<include template="act_login.cfm"/>
		<include template="dsp_login.cfm"/>
	</fuseaction>
	
	<fuseaction name="login_validation">
		<include template="act_login_validation.cfm"/>
	</fuseaction>
	
	<fuseaction name="logout">
		<include template="act_logout.cfm"/>
	</fuseaction>
	
	<fuseaction name="userdetails">
		<include template="act_profile.cfm"/>
		<include template="dsp_profile.cfm"/>
	</fuseaction>

	<fuseaction name="userdetails_edit">
		<include template="act_profile_edit.cfm"/>
		<include template="dsp_profile_edit.cfm"/>
	</fuseaction>

	<fuseaction name="profile_edit_logindata">
		<include template="act_profile_edit_logindata.cfm"/>
		<include template="dsp_profile_edit_logindata.cfm"/>
	</fuseaction>

	<fuseaction name="profile_edit_personaldata">
		<include template="act_profile_edit_personaldata.cfm"/>
		<include template="dsp_profile_edit_personaldata.cfm"/>
	</fuseaction>

	<fuseaction name="profile_edit_avatar">
		<include template="act_profile_edit_avatar.cfm"/>
		<include template="dsp_profile_edit_avatar.cfm"/>
	</fuseaction>

	<fuseaction name="profile_edit_settings">
		<include template="act_profile_edit_settings.cfm"/>
		<include template="dsp_profile_edit_settings.cfm"/>
	</fuseaction>

	<fuseaction name="register">
		<include template="act_register.cfm"/>
		<include template="dsp_register.cfm"/>
	</fuseaction>

	<fuseaction name="register_admin">
		<include template="act_register.cfm"/>
		<include template="dsp_register.cfm"/>
	</fuseaction>

	<fuseaction name="user_history">
		<set name="check" value="#UDF_SecurityCheck(area='history')#"/>
		<include template="act_user_history.cfm"/>
		<include template="dsp_user_history.cfm"/>
	</fuseaction>
	
	<fuseaction name="user_not_found">
		<include template="dsp_user_not_found.cfm"/>
	</fuseaction>

	<fuseaction name="reset_password">
		<include template="act_reset_password.cfm"/>
		<include template="dsp_reset_password.cfm"/>
	</fuseaction>

	<fuseaction name="reset_password_confirm">
		<include template="dsp_reset_password_confirm.cfm"/>
	</fuseaction>

	<fuseaction name="reset_password_done">
		<include template="dsp_reset_password_done.cfm"/>
	</fuseaction>

</circuit>