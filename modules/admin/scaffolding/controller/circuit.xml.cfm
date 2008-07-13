<cfoutput>
	<fuseaction access="public" name="start">
		<lanshock:security area="core_configmanager"/>
		<include circuit="#sModule#" template="custom/act_start"/>
		<include circuit="v_#sModule#" template="custom/dsp_start"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config">
		<lanshock:security area="core_configmanager"/>
		<include circuit="v_#sModule#" template="custom/dsp_core_config"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_general">
		<lanshock:security area="core_configmanager"/>
		<include circuit="#sModule#" template="custom/act_core_config_general"/>
		<include circuit="v_#sModule#" template="custom/dsp_core_config_general"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_layout">
		<lanshock:security area="core_configmanager"/>
		<include circuit="#sModule#" template="custom/act_core_config_layout"/>
		<include circuit="v_#sModule#" template="custom/dsp_core_config_layout"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_mailserver">
		<lanshock:security area="core_configmanager"/>
		<include circuit="#sModule#" template="custom/act_core_config_mailserver"/>
		<include circuit="v_#sModule#" template="custom/dsp_core_config_mailserver"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_profilesettings">
		<lanshock:security area="core_configmanager"/>
		<include circuit="#sModule#" template="custom/act_core_config_profilesettings"/>
		<include circuit="v_#sModule#" template="custom/dsp_core_config_profilesettings"/>
	</fuseaction>
	
	<fuseaction access="public" name="modules">
		<lanshock:security area="core_modules"/>
		<include circuit="#sModule#" template="custom/act_modules"/>
		<include circuit="v_#sModule#" template="custom/dsp_modules"/>
	</fuseaction>
	
	<fuseaction access="public" name="cron">
		<lanshock:security area="core_configmanager"/>
		<include circuit="#sModule#" template="custom/act_cron"/>
		<include circuit="v_#sModule#" template="custom/dsp_cron"/>
	</fuseaction>
	
	<fuseaction access="public" name="logviewer">
		<lanshock:security area="core_configmanager"/>
		<include circuit="#sModule#" template="custom/act_logviewer"/>
		<include circuit="v_#sModule#" template="custom/dsp_logviewer"/>
	</fuseaction>

	<fuseaction access="public" name="cron_dbbackup" lanshock:showlayout="none">
		<include circuit="#sModule#" template="custom/act_cron_dbbackup"/>
	</fuseaction>
	
	<fuseaction access="public" name="scaffolding">
		<lanshock:security area="scaffolding"/>
		<include circuit="admin" template="custom/act_scaffolding"/>
		<include circuit="v_admin" template="custom/dsp_scaffolding"/>
	</fuseaction>
	
	<fuseaction access="public" name="scaffolding_progress" lanshock:showlayout="none">
		<lanshock:security area="scaffolding"/>
		<include circuit="admin" template="custom/act_scaffolding_progress"/>
	</fuseaction>
</cfoutput>