<circuit xmlns:cf="cf/" xmlns:reactor="reactor/" xmlns:cs="coldspring/" xmlns:lanshock="lanshock/">

	
	<prefuseaction>
		<lanshock:fuseaction>
			<set name="request.page" value="#structNew()#"/>
			<lanshock:i18n load="modules/blog/i18n/lang.properties" returnvariable="request.content"/>
			<include circuit="blog" template="settings"/>
		</lanshock:fuseaction>
	</prefuseaction>
	
	<postfuseaction>
		<lanshock:fuseaction>
			<if condition="isDefined('request.layout')">
				<true>
					<if condition="request.layout EQ 'json'">
						<true>
							<set name="_fba.debug" value="false"/>
							<include circuit="v_blog" template="dsp_layout_json"/>
						</true>
						<false>
							<if condition="request.layout EQ 'none'">
								<true>
									<set name="_fba.debug" value="false"/>
								</true>
								<false>
									<if condition="request.layout EQ 'admin'">
										<true>
											
											<lanshock:htmlhead content="@import url('#application.lanshock.oRuntime.getEnvironment().sWebPath#modules/blog/view/styles.css');" type="style"/>
											
										</true>
									</if>
								</false>
							</if>
						</false>
					</if>
				</true>
				
				<false>
					<lanshock:htmlhead content="@import url('#application.lanshock.oRuntime.getEnvironment().sWebPath#modules/blog/view/styles.css');" type="style"/>
				</false>
				
			</if>
		</lanshock:fuseaction>
	</postfuseaction>
	
	<fuseaction access="public" name="main">
		
			
			<xfa name="relocate" value="news"/>
<lanshock:relocate xfa="relocate"/>
			
		
	</fuseaction>
	
	<fuseaction access="public" name="news">
		<include circuit="blog" template="custom/act_news"/>
		<include circuit="v_blog" template="custom/dsp_news"/>
	</fuseaction>
	
	<fuseaction access="public" name="archive">
		<include circuit="blog" template="custom/act_archive"/>
		<include circuit="v_blog" template="custom/dsp_archive"/>
	</fuseaction>
	
	<fuseaction access="public" name="categories">
		<include circuit="v_blog" template="custom/dsp_categories"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="trackback">
		<include circuit="blog" template="custom/act_trackback"/>
		<include circuit="v_blog" template="custom/dsp_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_details">
		<include circuit="blog" template="custom/act_news_details"/>
		<include circuit="v_blog" template="custom/dsp_news_details"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_comment_edit">
		<xfa name="next" value="news_comments"/>
		<include circuit="blog" template="custom/act_news_comment_edit"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_comment_del">
		<lanshock:security area="news_entry"/>
		<xfa name="next" value="news_comments"/>
		<include circuit="blog" template="custom/act_news_comment_del"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="rss">
		<include circuit="blog" template="custom/act_rss"/>
		<include circuit="v_blog" template="custom/dsp_rss"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_listing">
		<lanshock:security area="news_entry"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_entry table. -->
		<set name="request.page.objectName" value="news_entry"/>
		<set name="request.page.description" value="I display a list of the news_entry records in the table."/>
		<xfa name="update" value="news_entry_edit_form"/>
		<xfa name="delete" value="news_entry_delete"/>
		<xfa name="display" value="news_entry_display"/>
		<xfa name="add" value="news_entry_add_form"/>
		<xfa name="grid_json" value="news_entry_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_entry|id|ASC"/>
		
		<set name="fieldlist" value="id,author,title,text,date,mp3url,id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,geo_lat,geo_long,country,city,street,zip,logincount,reset_password_key,openid_url"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="list/dsp_list_news_entry"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_entry_grid_json">
		<lanshock:security area="news_entry"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="act_json_filter"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_entry','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_entry|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_Display">
		<!-- Display: I display the selected news_entry record. -->
		<set name="request.page.subtitle" value="View news_entry"/>
		<set name="request.page.description" value="I display the selected news_entry record."/>
		<xfa name="Edit" value="news_entry_Edit_Form"/>
		<xfa name="Delete" value="news_entry_Action_Delete"/>
		<xfa name="List" value="news_entry_Listing"/>
		<reactor:record alias="news_entry" returnvariable="onews_entry"/>
		
		<set value="#onews_entry.setlPKFields(attributes.lPKFields)#"/>
		<invoke method="load" object="onews_entry"/>
		
		<set name="fieldlist" value="id,author,title,text,date,mp3url,id,name,email,pwd,firstname,lastname,gender,status,signature,homepage,internal_note,dt_birthdate,dt_lastlogin,dt_registered,language,geo_lat,geo_long,country,city,street,zip,logincount,reset_password_key,openid_url"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include append="true" circuit="v_blog" contentvariable="request.page.pageContent" template="display/dsp_display_news_entry"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_action_add"/>
		<do action="news_entry_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_action_update"/>
		<do action="news_entry_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_form">
		<lanshock:security area="news_entry"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_entry_listing"/>
		
		<include circuit="blog" template="form/act_form_news_entry"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_entry"/>
		
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="form/dsp_form_news_entry"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_action_add"/>
		<do action="news_entry_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_action_update"/>
		<do action="news_entry_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_action_save">
		<lanshock:security area="news_entry"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_entry_listing"/>
		<xfa name="cancel" value="news_entry_listing"/>
		<include circuit="blog" template="form/act_action_save_news_entry"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_delete">
		<lanshock:security area="news_entry"/>
		
		<!-- Delete: I delete the selected news_entry records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_entry','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_listing">
		<lanshock:security area="news_trackback"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_trackback table. -->
		<set name="request.page.objectName" value="news_trackback"/>
		<set name="request.page.description" value="I display a list of the news_trackback records in the table."/>
		<xfa name="update" value="news_trackback_edit_form"/>
		<xfa name="delete" value="news_trackback_delete"/>
		<xfa name="display" value="news_trackback_display"/>
		<xfa name="add" value="news_trackback_add_form"/>
		<xfa name="grid_json" value="news_trackback_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_trackback|id|ASC"/>
		
		<set name="fieldlist" value="blog_name,date,entry_id,id,text,title,url,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="list/dsp_list_news_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_trackback_grid_json">
		<lanshock:security area="news_trackback"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="act_json_filter"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_trackback','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_trackback|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_Display">
		<!-- Display: I display the selected news_trackback record. -->
		<set name="request.page.subtitle" value="View news_trackback"/>
		<set name="request.page.description" value="I display the selected news_trackback record."/>
		<xfa name="Edit" value="news_trackback_Edit_Form"/>
		<xfa name="Delete" value="news_trackback_Action_Delete"/>
		<xfa name="List" value="news_trackback_Listing"/>
		<reactor:record alias="news_trackback" returnvariable="onews_trackback"/>
		
		<set value="#onews_trackback.setlPKFields(attributes.lPKFields)#"/>
		<invoke method="load" object="onews_trackback"/>
		
		<set name="fieldlist" value="blog_name,date,entry_id,id,text,title,url,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include append="true" circuit="v_blog" contentvariable="request.page.pageContent" template="display/dsp_display_news_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_trackback_action_add"/>
		<do action="news_trackback_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_trackback_action_update"/>
		<do action="news_trackback_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_trackback_form">
		<lanshock:security area="news_trackback"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_trackback_listing"/>
		
		<include circuit="blog" template="form/act_form_news_trackback"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_trackback"/>
		
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="form/dsp_form_news_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_trackback_action_add"/>
		<do action="news_trackback_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_trackback_action_update"/>
		<do action="news_trackback_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_trackback_action_save">
		<lanshock:security area="news_trackback"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_trackback_listing"/>
		<xfa name="cancel" value="news_trackback_listing"/>
		<include circuit="blog" template="form/act_action_save_news_trackback"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_trackback_delete">
		<lanshock:security area="news_trackback"/>
		
		<!-- Delete: I delete the selected news_trackback records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_trackback','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_listing">
		<lanshock:security area="news_category"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_category table. -->
		<set name="request.page.objectName" value="news_category"/>
		<set name="request.page.description" value="I display a list of the news_category records in the table."/>
		<xfa name="update" value="news_category_edit_form"/>
		<xfa name="delete" value="news_category_delete"/>
		<xfa name="display" value="news_category_display"/>
		<xfa name="add" value="news_category_add_form"/>
		<xfa name="grid_json" value="news_category_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_category|id|ASC"/>
		
		<set name="fieldlist" value="id,name,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="list/dsp_list_news_category"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_category_grid_json">
		<lanshock:security area="news_category"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="act_json_filter"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_category|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_Display">
		<!-- Display: I display the selected news_category record. -->
		<set name="request.page.subtitle" value="View news_category"/>
		<set name="request.page.description" value="I display the selected news_category record."/>
		<xfa name="Edit" value="news_category_Edit_Form"/>
		<xfa name="Delete" value="news_category_Action_Delete"/>
		<xfa name="List" value="news_category_Listing"/>
		<reactor:record alias="news_category" returnvariable="onews_category"/>
		
		<set value="#onews_category.setlPKFields(attributes.lPKFields)#"/>
		<invoke method="load" object="onews_category"/>
		
		<set name="fieldlist" value="id,name,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include append="true" circuit="v_blog" contentvariable="request.page.pageContent" template="display/dsp_display_news_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_category_action_add"/>
		<do action="news_category_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_category_action_update"/>
		<do action="news_category_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_category_form">
		<lanshock:security area="news_category"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_category_listing"/>
		
		<include circuit="blog" template="form/act_form_news_category"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_category"/>
		
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="form/dsp_form_news_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_category_action_add"/>
		<do action="news_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_category_action_update"/>
		<do action="news_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_category_action_save">
		<lanshock:security area="news_category"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_category_listing"/>
		<xfa name="cancel" value="news_category_listing"/>
		<include circuit="blog" template="form/act_action_save_news_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_category_delete">
		<lanshock:security area="news_category"/>
		
		<!-- Delete: I delete the selected news_category records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_listing">
		<lanshock:security area="news_entry_category"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_entry_category table. -->
		<set name="request.page.objectName" value="news_entry_category"/>
		<set name="request.page.description" value="I display a list of the news_entry_category records in the table."/>
		<xfa name="update" value="news_entry_category_edit_form"/>
		<xfa name="delete" value="news_entry_category_delete"/>
		<xfa name="display" value="news_entry_category_display"/>
		<xfa name="add" value="news_entry_category_add_form"/>
		<xfa name="grid_json" value="news_entry_category_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_entry_category|category_id|ASC"/>
		
		<set name="fieldlist" value="id,entry_id,category_id,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="list/dsp_list_news_entry_category"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_entry_category_grid_json">
		<lanshock:security area="news_entry_category"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="act_json_filter"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_entry_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_entry_category|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_Display">
		<!-- Display: I display the selected news_entry_category record. -->
		<set name="request.page.subtitle" value="View news_entry_category"/>
		<set name="request.page.description" value="I display the selected news_entry_category record."/>
		<xfa name="Edit" value="news_entry_category_Edit_Form"/>
		<xfa name="Delete" value="news_entry_category_Action_Delete"/>
		<xfa name="List" value="news_entry_category_Listing"/>
		<reactor:record alias="news_entry_category" returnvariable="onews_entry_category"/>
		
		<set value="#onews_entry_category.setlPKFields(attributes.lPKFields)#"/>
		<invoke method="load" object="onews_entry_category"/>
		
		<set name="fieldlist" value="id,entry_id,category_id,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include append="true" circuit="v_blog" contentvariable="request.page.pageContent" template="display/dsp_display_news_entry_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_category_action_add"/>
		<do action="news_entry_category_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_category_action_update"/>
		<do action="news_entry_category_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_category_form">
		<lanshock:security area="news_entry_category"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_entry_category_listing"/>
		
		<include circuit="blog" template="form/act_form_news_entry_category"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_entry_category"/>
		
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="form/dsp_form_news_entry_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_entry_category_action_add"/>
		<do action="news_entry_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_entry_category_action_update"/>
		<do action="news_entry_category_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_entry_category_action_save">
		<lanshock:security area="news_entry_category"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_entry_category_listing"/>
		<xfa name="cancel" value="news_entry_category_listing"/>
		<include circuit="blog" template="form/act_action_save_news_entry_category"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_entry_category_delete">
		<lanshock:security area="news_entry_category"/>
		
		<!-- Delete: I delete the selected news_entry_category records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none"/>
		
		<invoke method="deleteByIDlist" object="application.lanshock.oFactory.load('news_entry_category','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_listing">
		<lanshock:security area="news_ping_url"/>
		
		<!-- force layout: admin -->
		<set name="request.layout" value="admin"/>
		
		<!-- Listing: I display a list of the records in the news_ping_url table. -->
		<set name="request.page.objectName" value="news_ping_url"/>
		<set name="request.page.description" value="I display a list of the news_ping_url records in the table."/>
		<xfa name="update" value="news_ping_url_edit_form"/>
		<xfa name="delete" value="news_ping_url_delete"/>
		<xfa name="display" value="news_ping_url_display"/>
		<xfa name="add" value="news_ping_url_add_form"/>
		<xfa name="grid_json" value="news_ping_url_grid_json"/>
		
		<set name="attributes._maxrows" overwrite="false" value="10"/>
		<set name="attributes._startrow" overwrite="false" value="1"/>
		
		<set name="attributes._listSortByFieldList" overwrite="false" value="news_ping_url|id|ASC"/>
		
		<set name="fieldlist" value="id,name,url,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="list/dsp_list_news_ping_url"/>
	</fuseaction>
	
	<fuseaction access="public" lanshock:showlayout="none" name="news_ping_url_grid_json">
		<lanshock:security area="news_ping_url"/>
		
		<!-- force layout: json -->
		<set name="request.layout" value="json"/>
		
		<!-- params by ext.grid -->
		<include circuit="blog" template="act_json_filter"/>
		
		<invoke method="getRecordsForGrid" object="application.lanshock.oFactory.load('news_ping_url','reactorGateway')" returnvariable="request.page.pageContent">
			<argument name="sortByFieldList" value="news_ping_url|#attributes.sort#|#attributes.dir#"/>
			<argument name="startrow" value="#attributes.start#"/>
			<argument name="maxrows" value="#attributes.limit#"/>
			<argument name="filter" value="#stFilters#"/>
		</invoke>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_Display">
		<!-- Display: I display the selected news_ping_url record. -->
		<set name="request.page.subtitle" value="View news_ping_url"/>
		<set name="request.page.description" value="I display the selected news_ping_url record."/>
		<xfa name="Edit" value="news_ping_url_Edit_Form"/>
		<xfa name="Delete" value="news_ping_url_Action_Delete"/>
		<xfa name="List" value="news_ping_url_Listing"/>
		<reactor:record alias="news_ping_url" returnvariable="onews_ping_url"/>
		
		<set value="#onews_ping_url.setlPKFields(attributes.lPKFields)#"/>
		<invoke method="load" object="onews_ping_url"/>
		
		<set name="fieldlist" value="id,name,url,"/>
		<include circuit="udfs" template="udf_appendParam"/>
		<include append="true" circuit="v_blog" contentvariable="request.page.pageContent" template="display/dsp_display_news_ping_url"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_add_form">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_ping_url_action_add"/>
		<do action="news_ping_url_form"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_edit_form">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_ping_url_action_update"/>
		<do action="news_ping_url_form"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_ping_url_form">
		<lanshock:security area="news_ping_url"/>
		<set name="request.layout" value="admin"/>
		<xfa name="cancel" value="news_ping_url_listing"/>
		
		<include circuit="blog" template="form/act_form_news_ping_url"/>
		
		<include circuit="blog" template="form/act_form_loadrelated_news_ping_url"/>
		
		
		<include circuit="udfs" template="udf_appendParam"/>
		<include circuit="v_blog" template="form/dsp_form_news_ping_url"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_action_add">
		<set name="mode" value="insert"/>
		<xfa name="save" value="news_ping_url_action_add"/>
		<do action="news_ping_url_action_save"/>
	</fuseaction>
	
	<fuseaction access="public" name="news_ping_url_action_update">
		<set name="mode" value="edit"/>
		<xfa name="save" value="news_ping_url_action_update"/>
		<do action="news_ping_url_action_save"/>
	</fuseaction>
	
	<fuseaction access="private" lanshock:includedCircuit="true" name="news_ping_url_action_save">
		<lanshock:security area="news_ping_url"/>
		<set name="bHasErrors" value="false"/>
		<xfa name="continue" value="news_ping_url_listing"/>
		<xfa name="cancel" value="news_ping_url_listing"/>
		<include circuit="blog" template="form/act_action_save_news_ping_url"/>
	</fuseaction>
	<fuseaction name="news_ping_url_delete" access="public">
		<lanshock:security area="news_ping_url"/>
		
		<!-- Delete: I delete the selected news_ping_url records. -->
		
		<!-- force layout: none -->
		<set name="request.layout" value="none" />
		
		<invoke object="application.lanshock.oFactory.load('news_ping_url','reactorGateway')" method="deleteByIDlist" returnvariable="request.page.pageContent">
			<argument name="jsonData" value="#attributes.jsonData#" />
		</invoke>
	</fuseaction>
</circuit>
