<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/user/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/" xmlns:lanshock="lanshock/">
		
	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/user/i18n/lang.properties" returnvariable="request.content"/>
			<include circuit="user" template="settings"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<fuseaction access="public" name="main">
		<xfa name="relocate" value="login"/>
		<lanshock:relocate xfa="relocate"/>
	</fuseaction>
	
	<fuseaction access="public" name="login">
		<include circuit="user" template="custom/act_login"/>
		<include circuit="v_user" template="custom/dsp_login"/>
	</fuseaction>
	
	<fuseaction access="public" name="login_validation">
		<include circuit="user" template="custom/act_login_validation"/>
	</fuseaction>
	
	<fuseaction access="public" name="logout">
		<include circuit="user" template="custom/act_logout"/>
	</fuseaction>
	
	<fuseaction access="public" name="userdetails">
		<include circuit="user" template="custom/act_profile"/>
		<include circuit="v_user" template="custom/dsp_profile"/>
	</fuseaction>

	<fuseaction access="public" name="userdetails_edit">
		<include circuit="user" template="custom/act_profile_edit"/>
		<include circuit="v_user" template="custom/dsp_profile_edit"/>
	</fuseaction>

	<fuseaction access="public" name="profile_edit_logindata">
		<include circuit="user" template="custom/act_profile_edit_logindata"/>
		<include circuit="v_user" template="custom/dsp_profile_edit_logindata"/>
	</fuseaction>

	<fuseaction access="public" name="profile_edit_personaldata">
		<include circuit="user" template="custom/act_profile_edit_personaldata"/>
		<include circuit="v_user" template="custom/dsp_profile_edit_personaldata"/>
	</fuseaction>

	<fuseaction access="public" name="profile_edit_avatar">
		<include circuit="user" template="custom/act_profile_edit_avatar"/>
		<include circuit="v_user" template="custom/dsp_profile_edit_avatar"/>
	</fuseaction>

	<fuseaction access="public" name="profile_edit_settings">
		<include circuit="user" template="custom/act_profile_edit_settings"/>
		<include circuit="v_user" template="custom/dsp_profile_edit_settings"/>
	</fuseaction>

	<fuseaction access="public" name="register">
		<include circuit="user" template="custom/act_register"/>
		<include circuit="v_user" template="custom/dsp_register"/>
	</fuseaction>

	<fuseaction access="public" name="register_admin">
		<include circuit="user" template="custom/act_register"/>
		<include circuit="v_user" template="custom/dsp_register"/>
	</fuseaction>

	<fuseaction access="public" name="user_history">
		<set name="check" value="#UDF_SecurityCheck(area='history')#"/>
		<include circuit="user" template="custom/act_user_history"/>
		<include circuit="v_user" template="custom/dsp_user_history"/>
	</fuseaction>
	
	<fuseaction access="public" name="user_not_found">
		<include circuit="v_user" template="custom/dsp_user_not_found"/>
	</fuseaction>

	<fuseaction access="public" name="reset_password">
		<include circuit="user" template="custom/act_reset_password"/>
		<include circuit="v_user" template="custom/dsp_reset_password"/>
	</fuseaction>

	<fuseaction access="public" name="reset_password_confirm">
		<include circuit="v_user" template="custom/dsp_reset_password_confirm"/>
	</fuseaction>

	<fuseaction access="public" name="reset_password_done">
		<include circuit="v_user" template="custom/dsp_reset_password_done"/>
	</fuseaction>

</circuit>