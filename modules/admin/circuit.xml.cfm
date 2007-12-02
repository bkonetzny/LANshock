<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE circuit>
<!--
Copyright (C) by LANshock.com
Released under the GNU General Public License (v2)

$HeadURL: https://svn.sourceforge.net/svnroot/lanshock/trunk/core/admin/circuit.xml.cfm $
$LastChangedDate: 2006-11-03 22:48:03 +0100 (Fr, 03 Nov 2006) $
$LastChangedBy: majestixs $
$LastChangedRevision: 75 $
-->

<circuit access="public" xmlns:lanshock="lanshock/">
	
	<fuseaction name="main">
		<do action="start"/>
	</fuseaction>
	
	<fuseaction name="start">
		<include template="act_start.cfm"/>
		<include template="dsp_start.cfm"/>
	</fuseaction>
	
	<fuseaction name="admin">
		<include template="act_admin.cfm"/>
		<include template="dsp_admin.cfm"/>
	</fuseaction>
	
	<fuseaction name="admin_del">
		<set name="check" value="#UDF_SecurityCheck(area='setrights')#"/>
		<include template="qry_admin_del.cfm"/>
	</fuseaction>
	
	<fuseaction name="admin_new">
		<set name="check" value="#UDF_SecurityCheck(area='setrights')#"/>
		<include template="qry_admin_new.cfm"/>
		<include template="dsp_admin_new.cfm"/>
	</fuseaction>
	
	<fuseaction name="show_modulrights">
		<include template="act_showmodulrights.cfm"/>
		<include template="dsp_showmodulrights.cfm"/>
	</fuseaction>
	
	<fuseaction name="rights_update">
		<set name="check" value="#UDF_SecurityCheck(area='setrights')#"/>
		<include template="act_rights_update.cfm"/>
	</fuseaction>

	<fuseaction name="userlist">
		<include template="act_userlist.cfm"/>
		<include template="dsp_userlist.cfm"/>
	</fuseaction>

	<fuseaction name="userlist_export" lanshock:showlayout="none">
		<include template="act_userlist_export.cfm"/>
	</fuseaction>

	<fuseaction name="user_del">
		<set name="check" value="#UDF_SecurityCheck(area='guest')#"/>
		<include template="act_user_del.cfm"/>
		<include template="dsp_user_del.cfm"/>
	</fuseaction>

	<fuseaction name="user_del_history">
		<include template="act_user_del_history.cfm"/>
		<include template="dsp_user_del_history.cfm"/>
	</fuseaction>

	<fuseaction name="usernotice_save">
		<set name="check" value="#UDF_SecurityCheck(area='guest')#"/>
		<include template="qry_usernotice_save.cfm"/>
	</fuseaction>

	<fuseaction name="userpassword_change">
		<set name="check" value="#UDF_SecurityCheck(area='guest')#"/>
		<include template="qry_userpassword_change.cfm"/>
	</fuseaction>

	<fuseaction name="as_login">
		<include template="act_as_login.cfm"/>
	</fuseaction>

	<fuseaction name="userstatus_change" lanshock:showlayout="none">
		<set name="check" value="#UDF_SecurityCheck(area='guest')#"/>
		<include template="act_userstatus_change.cfm"/>
	</fuseaction>

	<fuseaction name="mailing">
		<set name="check" value="#UDF_SecurityCheck(area='mailing')#"/>
		<include template="act_mailing.cfm"/>
		<include template="dsp_mailing.cfm"/>
	</fuseaction>
	
	<fuseaction name="maintenance">
		<include template="dsp_maintenance.cfm"/>
	</fuseaction>

	<fuseaction name="config_editor">
		<include template="act_config_editor.cfm"/>
		<include template="dsp_config_editor.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config">
		<include template="dsp_core_config.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_general">
		<include template="act_core_config_general.cfm"/>
		<include template="dsp_core_config_general.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_security">
		<include template="act_core_config_security.cfm"/>
		<include template="dsp_core_config_security.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_sessionmanagement">
		<include template="act_core_config_sessionmanagement.cfm"/>
		<include template="dsp_core_config_sessionmanagement.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_layout">
		<include template="act_core_config_layout.cfm"/>
		<include template="dsp_core_config_layout.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_mailserver">
		<include template="act_core_config_mailserver.cfm"/>
		<include template="dsp_core_config_mailserver.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_cache">
		<include template="act_core_config_cache.cfm"/>
		<include template="dsp_core_config_cache.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_debugging">
		<include template="act_core_config_debugging.cfm"/>
		<include template="dsp_core_config_debugging.cfm"/>
	</fuseaction>
	
	<fuseaction name="core_config_profilesettings">
		<include template="act_core_config_profilesettings.cfm"/>
		<include template="dsp_core_config_profilesettings.cfm"/>
	</fuseaction>
	
	<fuseaction name="modules">
		<include template="act_modules.cfm"/>
		<include template="dsp_modules.cfm"/>
	</fuseaction>
	
	<fuseaction name="cron">
		<include template="act_cron.cfm"/>
		<include template="dsp_cron.cfm"/>
	</fuseaction>

	<fuseaction name="import">
		<include template="act_import.cfm"/>
		<include template="dsp_import.cfm"/>
	</fuseaction>

	<fuseaction name="admin_user">
		<include template="act_admin_user.cfm"/>
		<include template="dsp_admin_user.cfm"/>
	</fuseaction>
	
	<fuseaction name="logviewer">
		<include template="act_logviewer.cfm"/>
		<include template="dsp_logviewer.cfm"/>
	</fuseaction>

	<fuseaction name="datadump">
		<include template="dsp_datadump.cfm"/>
	</fuseaction>

	<fuseaction name="tabledump">
		<include template="act_tabledump.cfm"/>
		<include template="dsp_tabledump.cfm"/>
	</fuseaction>

	<fuseaction name="onlineupdate">
		<include template="act_onlineupdate.cfm"/>
		<include template="dsp_onlineupdate.cfm"/>
	</fuseaction>

	<fuseaction name="system_check">
		<include template="act_system_check.cfm"/>
		<include template="dsp_system_check.cfm"/>
	</fuseaction>

	<fuseaction name="cron_dbbackup" lanshock:showlayout="none">
		<include template="act_cron_dbbackup.cfm"/>
	</fuseaction>

	<fuseaction name="roleslist">
		<include template="act_roleslist.cfm"/>
		<include template="dsp_roleslist.cfm"/>
	</fuseaction>

</circuit>