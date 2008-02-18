<cfoutput>
	<fuseaction access="public" name="start">
		<include circuit="c_#sModule#" template="act_start"/>
		<include circuit="v_#sModule#" template="dsp_start"/>
	</fuseaction>

	<fuseaction access="public" name="userlist">
		<include circuit="c_#sModule#" template="act_userlist"/>
		<include circuit="v_#sModule#" template="dsp_userlist"/>
	</fuseaction>

	<fuseaction access="public" name="userlist_export" lanshock:showlayout="none">
		<include circuit="c_#sModule#" template="act_userlist_export"/>
	</fuseaction>

	<fuseaction access="public" name="user_del">
		<lanshock:security area="guest"/>
		<include circuit="c_#sModule#" template="act_user_del"/>
		<include circuit="v_#sModule#" template="dsp_user_del"/>
	</fuseaction>

	<fuseaction access="public" name="user_del_history">
		<include circuit="c_#sModule#" template="act_user_del_history"/>
		<include circuit="v_#sModule#" template="dsp_user_del_history"/>
	</fuseaction>

	<fuseaction access="public" name="usernotice_save">
		<lanshock:security area="guest"/>
		<include circuit="c_#sModule#" template="qry_usernotice_save"/>
	</fuseaction>

	<fuseaction access="public" name="userpassword_change">
		<lanshock:security area="guest"/>
		<include circuit="c_#sModule#" template="qry_userpassword_change"/>
	</fuseaction>

	<fuseaction access="public" name="as_login">
		<include circuit="c_#sModule#" template="act_as_login"/>
	</fuseaction>

	<fuseaction access="public" name="userstatus_change" lanshock:showlayout="none">
		<lanshock:security area="guest"/>
		<include circuit="c_#sModule#" template="act_userstatus_change"/>
	</fuseaction>

	<fuseaction access="public" name="mailing">
		<lanshock:security area="mailing"/>
		<include circuit="c_#sModule#" template="act_mailing"/>
		<include circuit="v_#sModule#" template="dsp_mailing"/>
	</fuseaction>
	
	<fuseaction access="public" name="maintenance">
		<include circuit="v_#sModule#" template="dsp_maintenance"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config">
		<include circuit="v_#sModule#" template="dsp_core_config"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_general">
		<include circuit="c_#sModule#" template="act_core_config_general"/>
		<include circuit="v_#sModule#" template="dsp_core_config_general"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_security">
		<include circuit="c_#sModule#" template="act_core_config_security"/>
		<include circuit="v_#sModule#" template="dsp_core_config_security"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_layout">
		<include circuit="c_#sModule#" template="act_core_config_layout"/>
		<include circuit="v_#sModule#" template="dsp_core_config_layout"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_mailserver">
		<include circuit="c_#sModule#" template="act_core_config_mailserver"/>
		<include circuit="v_#sModule#" template="dsp_core_config_mailserver"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_debugging">
		<include circuit="c_#sModule#" template="act_core_config_debugging"/>
		<include circuit="v_#sModule#" template="dsp_core_config_debugging"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_profilesettings">
		<include circuit="c_#sModule#" template="act_core_config_profilesettings"/>
		<include circuit="v_#sModule#" template="dsp_core_config_profilesettings"/>
	</fuseaction>
	
	<fuseaction access="public" name="modules">
		<include circuit="c_#sModule#" template="act_modules"/>
		<include circuit="v_#sModule#" template="dsp_modules"/>
	</fuseaction>
	
	<fuseaction access="public" name="cron">
		<include circuit="c_#sModule#" template="act_cron"/>
		<include circuit="v_#sModule#" template="dsp_cron"/>
	</fuseaction>

	<fuseaction access="public" name="import">
		<include circuit="c_#sModule#" template="act_import"/>
		<include circuit="v_#sModule#" template="dsp_import"/>
	</fuseaction>
	
	<fuseaction access="public" name="logviewer">
		<include circuit="c_#sModule#" template="act_logviewer"/>
		<include circuit="v_#sModule#" template="dsp_logviewer"/>
	</fuseaction>

	<fuseaction access="public" name="datadump">
		<include circuit="v_#sModule#" template="dsp_datadump"/>
	</fuseaction>

	<fuseaction access="public" name="system_check">
		<include circuit="c_#sModule#" template="act_system_check"/>
		<include circuit="v_#sModule#" template="dsp_system_check"/>
	</fuseaction>

	<fuseaction access="public" name="cron_dbbackup" lanshock:showlayout="none">
		<include circuit="c_#sModule#" template="act_cron_dbbackup"/>
	</fuseaction>
</cfoutput>