<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/" xmlns:lanshock="lanshock/">

	
	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/admin/i18n/lang.properties" returnvariable="request.content"/>
			
			<include circuit="admin" template="settings"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<postfuseaction>
		<lanshock:fuseaction>
			<if condition="isDefined('request.layout')">
				<true>
					<if condition="request.layout EQ 'json'">
						<true>
							<set name="_fba.debug" value="false"/>
							<include circuit="v_admin" template="dsp_layout_json"/>
						</true>
						<false>
							<if condition="request.layout EQ 'none'">
								<true>
									<set name="_fba.debug" value="false"/>
								</true>
								<false>
									<if condition="request.layout EQ 'admin'">
										<true>
											
										</true>
									</if>
								</false>
							</if>
						</false>
					</if>
				</true>
				
			</if>
		</lanshock:fuseaction>
	</postfuseaction>
	
	<fuseaction access="public" name="main">
		
			
			<xfa name="relocate" value="start"/>
<lanshock:relocate xfa="relocate"/>
			
		
	</fuseaction>
	
	<fuseaction access="public" name="start">
		<lanshock:security area="core_configmanager"/>
		<include circuit="admin" template="custom/act_start"/>
		<include circuit="v_admin" template="custom/dsp_start"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config">
		<lanshock:security area="core_configmanager"/>
		<include circuit="v_admin" template="custom/dsp_core_config"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_general">
		<lanshock:security area="core_configmanager"/>
		<include circuit="admin" template="custom/act_core_config_general"/>
		<include circuit="v_admin" template="custom/dsp_core_config_general"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_layout">
		<lanshock:security area="core_configmanager"/>
		<include circuit="admin" template="custom/act_core_config_layout"/>
		<include circuit="v_admin" template="custom/dsp_core_config_layout"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_mailserver">
		<lanshock:security area="core_configmanager"/>
		<include circuit="admin" template="custom/act_core_config_mailserver"/>
		<include circuit="v_admin" template="custom/dsp_core_config_mailserver"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_config_profilesettings">
		<lanshock:security area="core_configmanager"/>
		<include circuit="admin" template="custom/act_core_config_profilesettings"/>
		<include circuit="v_admin" template="custom/dsp_core_config_profilesettings"/>
	</fuseaction>
	
	<fuseaction access="public" name="modules">
		<lanshock:security area="core_modules"/>
		<include circuit="admin" template="custom/act_modules"/>
		<include circuit="v_admin" template="custom/dsp_modules"/>
	</fuseaction>
	
	<fuseaction access="public" name="cron">
		<lanshock:security area="core_configmanager"/>
		<include circuit="admin" template="custom/act_cron"/>
		<include circuit="v_admin" template="custom/dsp_cron"/>
	</fuseaction>
	
	<fuseaction access="public" name="logviewer">
		<lanshock:security area="core_configmanager"/>
		<include circuit="admin" template="custom/act_logviewer"/>
		<include circuit="v_admin" template="custom/dsp_logviewer"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="cron_dbbackup">
		<include circuit="admin" template="custom/act_cron_dbbackup"/>
	</fuseaction>
	
	<fuseaction access="public" name="scaffolding">
		<lanshock:security area="scaffolding"/>
		<include circuit="admin" template="custom/act_scaffolding"/>
		<include circuit="v_admin" template="custom/dsp_scaffolding"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="scaffolding_progress">
		<lanshock:security area="scaffolding"/>
		<include circuit="admin" template="custom/act_scaffolding_progress"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_configmanager_listing">
		<lanshock:security area="core_configmanager"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_configmanager table. -->
		<set name="request.page.objectName" value="core_configmanager"/>
		<set name="request.page.description" value="I display a list of the core_configmanager records in the table."/>
		<xfa name="update" value="core_configmanager_edit_form"/>
		<xfa name="delete" value="core_configmanager_delete"/>
		<xfa name="display" value="core_configmanager_display"/>
		<xfa name="add" value="core_configmanager_add_form"/>
		<xfa name="grid_json" value="core_configmanager_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_configmanager|module|ASC"/>
		
		<set name="fieldlist" value="module,version,data,dtlastchanged,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_configmanager"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_configmanager_grid_json">
		<lanshock:security area="core_configmanager"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_configmanager"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_configmanager','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_configmanager|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_configmanager_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_configmanager_action_add"/>
		<do action="core_configmanager_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_configmanager_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_configmanager_action_update"/>
		<do action="core_configmanager_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_configmanager_form">
		<lanshock:security area="core_configmanager"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_configmanager_listing"/>
		
		<include circuit="admin" template="form/act_form_core_configmanager"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_configmanager"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_configmanager.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_configmanager"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_configmanager_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_configmanager_action_add"/>
		<do action="core_configmanager_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_configmanager_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_configmanager_action_update"/>
		<do action="core_configmanager_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_configmanager_action_save">
		<lanshock:security area="core_configmanager"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_configmanager_listing"/>
		<xfa name="cancel" value="core_configmanager_listing"/>
		<include circuit="admin" template="form/act_action_save_core_configmanager"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_configmanager_delete">
		<lanshock:security area="core_configmanager"/>
		
		<!-- Delete: I delete the selected core_configmanager records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_configmanager','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_cron_listing">
		<lanshock:security area="core_cron"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_cron table. -->
		<set name="request.page.objectName" value="core_cron"/>
		<set name="request.page.description" value="I display a list of the core_cron records in the table."/>
		<xfa name="update" value="core_cron_edit_form"/>
		<xfa name="delete" value="core_cron_delete"/>
		<xfa name="display" value="core_cron_display"/>
		<xfa name="add" value="core_cron_add_form"/>
		<xfa name="grid_json" value="core_cron_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_cron|id|ASC"/>
		
		<set name="fieldlist" value="id,active,run,module,action,executions,lastrun_dt,lastrun_time,result,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_cron"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_cron_grid_json">
		<lanshock:security area="core_cron"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_cron"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_cron','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_cron|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_cron_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_cron_action_add"/>
		<do action="core_cron_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_cron_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_cron_action_update"/>
		<do action="core_cron_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_cron_form">
		<lanshock:security area="core_cron"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_cron_listing"/>
		
		<include circuit="admin" template="form/act_form_core_cron"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_cron"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_cron.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_cron"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_cron_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_cron_action_add"/>
		<do action="core_cron_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_cron_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_cron_action_update"/>
		<do action="core_cron_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_cron_action_save">
		<lanshock:security area="core_cron"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_cron_listing"/>
		<xfa name="cancel" value="core_cron_listing"/>
		<include circuit="admin" template="form/act_action_save_core_cron"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_cron_delete">
		<lanshock:security area="core_cron"/>
		
		<!-- Delete: I delete the selected core_cron records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_cron','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_logs_listing">
		<lanshock:security area="core_logs"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_logs table. -->
		<set name="request.page.objectName" value="core_logs"/>
		<set name="request.page.description" value="I display a list of the core_logs records in the table."/>
		<xfa name="update" value="core_logs_edit_form"/>
		<xfa name="delete" value="core_logs_delete"/>
		<xfa name="display" value="core_logs_display"/>
		<xfa name="add" value="core_logs_add_form"/>
		<xfa name="grid_json" value="core_logs_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_logs|id|ASC"/>
		
		<set name="fieldlist" value="id,logname,level,data,timestamp,userid,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_logs"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_logs_grid_json">
		<lanshock:security area="core_logs"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_logs"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_logs','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_logs|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_logs_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_logs_action_add"/>
		<do action="core_logs_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_logs_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_logs_action_update"/>
		<do action="core_logs_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_logs_form">
		<lanshock:security area="core_logs"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_logs_listing"/>
		
		<include circuit="admin" template="form/act_form_core_logs"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_logs"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_logs.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_logs"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_logs_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_logs_action_add"/>
		<do action="core_logs_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_logs_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_logs_action_update"/>
		<do action="core_logs_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_logs_action_save">
		<lanshock:security area="core_logs"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_logs_listing"/>
		<xfa name="cancel" value="core_logs_listing"/>
		<include circuit="admin" template="form/act_action_save_core_logs"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_logs_delete">
		<lanshock:security area="core_logs"/>
		
		<!-- Delete: I delete the selected core_logs records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_logs','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_modules_listing">
		<lanshock:security area="core_modules"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_modules table. -->
		<set name="request.page.objectName" value="core_modules"/>
		<set name="request.page.description" value="I display a list of the core_modules records in the table."/>
		<xfa name="update" value="core_modules_edit_form"/>
		<xfa name="delete" value="core_modules_delete"/>
		<xfa name="display" value="core_modules_display"/>
		<xfa name="add" value="core_modules_add_form"/>
		<xfa name="grid_json" value="core_modules_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_modules|folder|ASC"/>
		
		<set name="fieldlist" value="name,version,date,folder,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_modules"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_modules_grid_json">
		<lanshock:security area="core_modules"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_modules"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_modules','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_modules|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_modules_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_modules_action_add"/>
		<do action="core_modules_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_modules_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_modules_action_update"/>
		<do action="core_modules_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_modules_form">
		<lanshock:security area="core_modules"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_modules_listing"/>
		
		<include circuit="admin" template="form/act_form_core_modules"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_modules"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_modules.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_modules"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_modules_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_modules_action_add"/>
		<do action="core_modules_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_modules_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_modules_action_update"/>
		<do action="core_modules_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_modules_action_save">
		<lanshock:security area="core_modules"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_modules_listing"/>
		<xfa name="cancel" value="core_modules_listing"/>
		<include circuit="admin" template="form/act_action_save_core_modules"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_modules_delete">
		<lanshock:security area="core_modules"/>
		
		<!-- Delete: I delete the selected core_modules records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_modules','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_navigation_listing">
		<lanshock:security area="core_navigation"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_navigation table. -->
		<set name="request.page.objectName" value="core_navigation"/>
		<set name="request.page.description" value="I display a list of the core_navigation records in the table."/>
		<xfa name="update" value="core_navigation_edit_form"/>
		<xfa name="delete" value="core_navigation_delete"/>
		<xfa name="display" value="core_navigation_display"/>
		<xfa name="add" value="core_navigation_add_form"/>
		<xfa name="grid_json" value="core_navigation_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_navigation|action|ASC"/>
		
		<set name="fieldlist" value="module,action,level,sortorder,permissions,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_navigation"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_navigation_grid_json">
		<lanshock:security area="core_navigation"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_navigation"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_navigation','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_navigation|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_navigation_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_navigation_action_add"/>
		<do action="core_navigation_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_navigation_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_navigation_action_update"/>
		<do action="core_navigation_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_navigation_form">
		<lanshock:security area="core_navigation"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_navigation_listing"/>
		
		<include circuit="admin" template="form/act_form_core_navigation"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_navigation"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_navigation.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_navigation"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_navigation_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_navigation_action_add"/>
		<do action="core_navigation_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_navigation_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_navigation_action_update"/>
		<do action="core_navigation_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_navigation_action_save">
		<lanshock:security area="core_navigation"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_navigation_listing"/>
		<xfa name="cancel" value="core_navigation_listing"/>
		<include circuit="admin" template="form/act_action_save_core_navigation"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_navigation_delete">
		<lanshock:security area="core_navigation"/>
		
		<!-- Delete: I delete the selected core_navigation records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_navigation','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_permissions_listing">
		<lanshock:security area="core_security_permissions"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_security_permissions table. -->
		<set name="request.page.objectName" value="core_security_permissions"/>
		<set name="request.page.description" value="I display a list of the core_security_permissions records in the table."/>
		<xfa name="update" value="core_security_permissions_edit_form"/>
		<xfa name="delete" value="core_security_permissions_delete"/>
		<xfa name="display" value="core_security_permissions_display"/>
		<xfa name="add" value="core_security_permissions_add_form"/>
		<xfa name="grid_json" value="core_security_permissions_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_security_permissions|id|ASC"/>
		
		<set name="fieldlist" value="id,name,module,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_security_permissions"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_security_permissions_grid_json">
		<lanshock:security area="core_security_permissions"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_security_permissions"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_security_permissions','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_security_permissions|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_permissions_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_permissions_action_add"/>
		<do action="core_security_permissions_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_permissions_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_permissions_action_update"/>
		<do action="core_security_permissions_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_permissions_form">
		<lanshock:security area="core_security_permissions"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_security_permissions_listing"/>
		
		<include circuit="admin" template="form/act_form_core_security_permissions"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_security_permissions"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_security_permissions.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_security_permissions"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_permissions_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_permissions_action_add"/>
		<do action="core_security_permissions_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_permissions_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_permissions_action_update"/>
		<do action="core_security_permissions_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_permissions_action_save">
		<lanshock:security area="core_security_permissions"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_security_permissions_listing"/>
		<xfa name="cancel" value="core_security_permissions_listing"/>
		<include circuit="admin" template="form/act_action_save_core_security_permissions"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_permissions_delete">
		<lanshock:security area="core_security_permissions"/>
		
		<!-- Delete: I delete the selected core_security_permissions records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_security_permissions','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_listing">
		<lanshock:security area="core_security_roles"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_security_roles table. -->
		<set name="request.page.objectName" value="core_security_roles"/>
		<set name="request.page.description" value="I display a list of the core_security_roles records in the table."/>
		<xfa name="update" value="core_security_roles_edit_form"/>
		<xfa name="delete" value="core_security_roles_delete"/>
		<xfa name="display" value="core_security_roles_display"/>
		<xfa name="add" value="core_security_roles_add_form"/>
		<xfa name="grid_json" value="core_security_roles_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_security_roles|id|ASC"/>
		
		<set name="fieldlist" value="id,name,module,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_security_roles"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_security_roles_grid_json">
		<lanshock:security area="core_security_roles"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_security_roles"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_security_roles','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_security_roles|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_roles_action_add"/>
		<do action="core_security_roles_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_roles_action_update"/>
		<do action="core_security_roles_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_roles_form">
		<lanshock:security area="core_security_roles"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_security_roles_listing"/>
		
		<include circuit="admin" template="form/act_form_core_security_roles"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_security_roles"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_security_roles.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_security_roles"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_roles_action_add"/>
		<do action="core_security_roles_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_roles_action_update"/>
		<do action="core_security_roles_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_roles_action_save">
		<lanshock:security area="core_security_roles"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_security_roles_listing"/>
		<xfa name="cancel" value="core_security_roles_listing"/>
		<include circuit="admin" template="form/act_action_save_core_security_roles"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_delete">
		<lanshock:security area="core_security_roles"/>
		
		<!-- Delete: I delete the selected core_security_roles records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_security_roles','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_permissions_rel_listing">
		<lanshock:security area="core_security_roles_permissions_rel"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_security_roles_permissions_rel table. -->
		<set name="request.page.objectName" value="core_security_roles_permissions_rel"/>
		<set name="request.page.description" value="I display a list of the core_security_roles_permissions_rel records in the table."/>
		<xfa name="update" value="core_security_roles_permissions_rel_edit_form"/>
		<xfa name="delete" value="core_security_roles_permissions_rel_delete"/>
		<xfa name="display" value="core_security_roles_permissions_rel_display"/>
		<xfa name="add" value="core_security_roles_permissions_rel_add_form"/>
		<xfa name="grid_json" value="core_security_roles_permissions_rel_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_security_roles_permissions_rel|id|ASC"/>
		
		<set name="fieldlist" value="id,role_id,permission_id,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_security_roles_permissions_rel"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_security_roles_permissions_rel_grid_json">
		<lanshock:security area="core_security_roles_permissions_rel"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_security_roles_permissions_rel"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_security_roles_permissions_rel','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_security_roles_permissions_rel|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_permissions_rel_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_roles_permissions_rel_action_add"/>
		<do action="core_security_roles_permissions_rel_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_permissions_rel_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_roles_permissions_rel_action_update"/>
		<do action="core_security_roles_permissions_rel_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_roles_permissions_rel_form">
		<lanshock:security area="core_security_roles_permissions_rel"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_security_roles_permissions_rel_listing"/>
		
		<include circuit="admin" template="form/act_form_core_security_roles_permissions_rel"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_security_roles_permissions_rel"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_security_roles_permissions_rel.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_security_roles_permissions_rel"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_permissions_rel_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_roles_permissions_rel_action_add"/>
		<do action="core_security_roles_permissions_rel_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_permissions_rel_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_roles_permissions_rel_action_update"/>
		<do action="core_security_roles_permissions_rel_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_roles_permissions_rel_action_save">
		<lanshock:security area="core_security_roles_permissions_rel"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_security_roles_permissions_rel_listing"/>
		<xfa name="cancel" value="core_security_roles_permissions_rel_listing"/>
		<include circuit="admin" template="form/act_action_save_core_security_roles_permissions_rel"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_roles_permissions_rel_delete">
		<lanshock:security area="core_security_roles_permissions_rel"/>
		
		<!-- Delete: I delete the selected core_security_roles_permissions_rel records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_security_roles_permissions_rel','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_users_roles_rel_listing">
		<lanshock:security area="core_security_users_roles_rel"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the core_security_users_roles_rel table. -->
		<set name="request.page.objectName" value="core_security_users_roles_rel"/>
		<set name="request.page.description" value="I display a list of the core_security_users_roles_rel records in the table."/>
		<xfa name="update" value="core_security_users_roles_rel_edit_form"/>
		<xfa name="delete" value="core_security_users_roles_rel_delete"/>
		<xfa name="display" value="core_security_users_roles_rel_display"/>
		<xfa name="add" value="core_security_users_roles_rel_add_form"/>
		<xfa name="grid_json" value="core_security_users_roles_rel_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="core_security_users_roles_rel|role_id|ASC"/>
		
		<set name="fieldlist" value="user_id,role_id,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_core_security_users_roles_rel"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="core_security_users_roles_rel_grid_json">
		<lanshock:security area="core_security_users_roles_rel"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_core_security_users_roles_rel"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('core_security_users_roles_rel','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="core_security_users_roles_rel|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_users_roles_rel_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_users_roles_rel_action_add"/>
		<do action="core_security_users_roles_rel_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_users_roles_rel_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_users_roles_rel_action_update"/>
		<do action="core_security_users_roles_rel_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_users_roles_rel_form">
		<lanshock:security area="core_security_users_roles_rel"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="core_security_users_roles_rel_listing"/>
		
		<include circuit="admin" template="form/act_form_core_security_users_roles_rel"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_core_security_users_roles_rel"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_core_security_users_roles_rel.cfm' -->
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_core_security_users_roles_rel"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_users_roles_rel_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="core_security_users_roles_rel_action_add"/>
		<do action="core_security_users_roles_rel_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_users_roles_rel_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="core_security_users_roles_rel_action_update"/>
		<do action="core_security_users_roles_rel_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="core_security_users_roles_rel_action_save">
		<lanshock:security area="core_security_users_roles_rel"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="core_security_users_roles_rel_listing"/>
		<xfa name="cancel" value="core_security_users_roles_rel_listing"/>
		<include circuit="admin" template="form/act_action_save_core_security_users_roles_rel"/>
	</fuseaction>
	
	<fuseaction access="public" name="core_security_users_roles_rel_delete">
		<lanshock:security area="core_security_users_roles_rel"/>
		
		<!-- Delete: I delete the selected core_security_users_roles_rel records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('core_security_users_roles_rel','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="user_listing">
		<lanshock:security area="user"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the user table. -->
		<set name="request.page.objectName" value="user"/>
		<set name="request.page.description" value="I display a list of the user records in the table."/>
		<xfa name="update" value="user_edit_form"/>
		<xfa name="delete" value="user_delete"/>
		<xfa name="display" value="user_display"/>
		<xfa name="add" value="user_add_form"/>
		<xfa name="grid_json" value="user_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="user|id|ASC"/>
		
		<set name="fieldlist" value="id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,logincount,language,geo_latlong,country,city,street,zip,reset_password_key,openid_url,data_access,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="list/dsp_list_user"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="user_grid_json">
		<lanshock:security area="user"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="admin" template="list/act_json_filter_user"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('user','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="user|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="user_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="user_action_add"/>
		<do action="user_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="user_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="user_action_update"/>
		<do action="user_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="user_form">
		<lanshock:security area="user"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="user_listing"/>
		
		<include circuit="admin" template="form/act_form_user"/>
		
		<include circuit="admin" template="form/act_form_loadrelated_user"/>
		
		<!-- snippet 'modules/admin/controller/form/snippets/act_form_loadrelated_custom_user.cfm' -->
		
			<include circuit="admin" template="form/snippets/act_form_loadrelated_custom_user"/>
		
		<!-- /snippet -->
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_admin" template="form/dsp_form_user"/>
	</fuseaction>
	
	<fuseaction access="public" name="user_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="user_action_add"/>
		<do action="user_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="user_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="user_action_update"/>
		<do action="user_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="user_action_save">
		<lanshock:security area="user"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="user_listing"/>
		<xfa name="cancel" value="user_listing"/>
		<include circuit="admin" template="form/act_action_save_user"/>
	</fuseaction>
	<fuseaction name="user_delete" access="public">
		<lanshock:security area="user"/>
		
		<!-- Delete: I delete the selected user records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none" />
		
		<invoke object="application.lanshock.oFactory.load('user','reactorGateway')" method="deleteByIDlist" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#" />
		</invoke>
	</fuseaction>
</circuit>
