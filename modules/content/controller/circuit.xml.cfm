<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/" xmlns:lanshock="lanshock/">

	
	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/content/i18n/lang.properties" returnvariable="request.content"/>
			<include circuit="content" template="settings"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<postfuseaction>
		<lanshock:fuseaction>
			<if condition="isDefined('request.layout')">
				<true>
					<if condition="request.layout EQ 'json'">
						<true>
							<set name="_fba.debug" value="false"/>
							<include circuit="v_content" template="dsp_layout_json"/>
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
		
			
			<xfa name="relocate" value="show"/>
<lanshock:relocate xfa="relocate"/>
			
		
	</fuseaction>
	
	<fuseaction access="public" name="show">
		<include circuit="content" template="custom/act_content"/>
		<include circuit="v_content" template="custom/dsp_content"/>
	</fuseaction>
	
	<fuseaction access="public" name="content_content_listing">
		<lanshock:security area="content_content"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the content_content table. -->
		<set name="request.page.objectName" value="content_content"/>
		<set name="request.page.description" value="I display a list of the content_content records in the table."/>
		<xfa name="update" value="content_content_edit_form"/>
		<xfa name="delete" value="content_content_delete"/>
		<xfa name="display" value="content_content_display"/>
		<xfa name="add" value="content_content_add_form"/>
		<xfa name="grid_json" value="content_content_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="content_content|id|ASC"/>
		
		<set name="fieldlist" value="id,title,content,user_id,dtcreated,dtchanged,bactive,codename,id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,country,city,street,zip,logincount,reset_password_key,openid_url,geo_latlong"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_content" template="list/dsp_list_content_content"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="content_content_grid_json">
		<lanshock:security area="content_content"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="content" template="act_json_filter"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('content_content','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="content_content|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="content_content_Display">
		<!-- Display: I display the selected content_content record. -->
		<set name="request.page.subtitle" value="View content_content"/>
		<set name="request.page.description" value="I display the selected content_content record."/>
		<xfa name="Edit" value="content_content_Edit_Form"/>
		<xfa name="Delete" value="content_content_Action_Delete"/>
		<xfa name="List" value="content_content_Listing"/>
		<reactor:record alias="content_content" returnvariable="ocontent_content"/>
		
		<set value="#ocontent_content.setlPKFields(attributes.lPKFields)#"/>
		<invoke method="load" object="ocontent_content"/>
		
		<set name="fieldlist" value="id,title,content,user_id,dtcreated,dtchanged,bactive,codename,id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,country,city,street,zip,logincount,reset_password_key,openid_url,geo_latlong"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include append="true" circuit="v_content" contentvariable="request.page.pageContent" template="display/dsp_display_content_content"/>
	</fuseaction>
	
	<fuseaction access="public" name="content_content_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="content_content_action_add"/>
		<do action="content_content_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="content_content_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="content_content_action_update"/>
		<do action="content_content_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="content_content_form">
		<lanshock:security area="content_content"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="content_content_listing"/>
		
		<include circuit="content" template="form/act_form_content_content"/>
		
		<include circuit="content" template="form/act_form_loadrelated_content_content"/>
		
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_content" template="form/dsp_form_content_content"/>
	</fuseaction>
	
	<fuseaction access="public" name="content_content_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="content_content_action_add"/>
		<do action="content_content_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="content_content_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="content_content_action_update"/>
		<do action="content_content_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="content_content_action_save">
		<lanshock:security area="content_content"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="content_content_listing"/>
		<xfa name="cancel" value="content_content_listing"/>
		<include circuit="content" template="form/act_action_save_content_content"/>
	</fuseaction>
	<fuseaction name="content_content_delete" access="public">
		<lanshock:security area="content_content"/>
		
		<!-- Delete: I delete the selected content_content records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none" />
		
		<invoke object="application.lanshock.oFactory.load('content_content','reactorGateway')" method="deleteByIDlist" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#" />
		</invoke>
	</fuseaction>
</circuit>
